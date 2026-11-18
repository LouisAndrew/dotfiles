// Leader c: keyboard copy mode on the live pane, built on Herdr's terminal selection.
// The selection doubles as the cursor: outside visual mode it is one cell, placed directly
// with terminal.select, because adjust_selection would flash a two-cell selection first.
// Herdr gives mods no cell text, so word and line-edge motions read it with `hc read`.

import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { run, props, closeOverlay, focused, terminals, panes, hc, theme, checking } from "herdr";

const HELP = [
  ["hjkl", "move"],
  ["w b e", "word"],
  ["0 ^ $", "line"],
  ["^u ^d", "page"],
  ["g G", "top/end"],
  ["v V", "select"],
  ["y ⏎", "copy"],
  ["/", "search"],
  ["q esc", "quit"],
];

const space = (ch) => ch === " " || ch === "\t";
const kind = (ch, big) => (space(ch) ? 0 : big || /[\p{L}\p{N}_]/u.test(ch) ? 1 : 2);
const WIDE =
  /\p{Emoji_Presentation}|[ᄀ-ᅟ⺀-〾ぁ-㏿㐀-䶿一-鿿ꀀ-꓏가-힣豈-﫿︰-﹏＀-｠￠-￦\u{20000}-\u{3FFFD}]/u;

export default class Copy extends View {
  init(_props, cx) {
    this.handle = cx.focus_handle();
    this.handle.focus();
    const f = focused();
    this.terminal = f?.shown ?? f?.terminal;
    this.visual = null;
    this.done = false;
    this.queue = [];
    this.wake = null;
    if (checking()) return;
    if (!this.terminal) return this.exit();
    // A selection command shows in terminals() only a moment after run() returns, so each
    // step waits for it before the next one reads it. Steps run in key order.
    cx.spawn(async (cx) => {
      this.cur = (await this.apply(cx, "terminal.select", { at: "cursor" }))?.end ?? { row: 0, col: 0 };
      this.anchor = this.cur.row;
      this.rowsLoad = this.loadRows();
      while (!this.done) {
        if (!this.queue.length) await new Promise((resolve) => (this.wake = resolve));
        const step = this.queue.shift();
        if (step) await step(cx);
      }
    });
  }

  enqueue(step) {
    this.queue.push(step);
    this.wake?.();
    this.wake = null;
  }

  info() {
    return terminals().find((t) => t.address === this.terminal);
  }

  selection() {
    return this.info()?.selection ?? null;
  }

  // Shell panes have history; alternate-screen panes (Claude Code, Vim) are only their screen.
  view() {
    const t = this.info();
    const scroll = panes().find((p) => p.terminal === this.terminal)?.scroll;
    const rows = t?.rows ?? 1;
    return {
      cols: t?.cols ?? 1,
      total: scroll?.total ?? rows,
      top: scroll?.offset ?? 0,
      len: scroll?.len ?? rows,
      scrolls: !!scroll,
    };
  }

  async apply(cx, name, args) {
    const before = JSON.stringify(this.selection());
    run(name, { terminal: this.terminal, ...args });
    for (let i = 0; i < 10 && JSON.stringify(this.selection()) === before; i++) {
      await new Promise((resolve) => cx.timer.after(10, () => resolve()));
    }
    return this.selection();
  }

  // `hc read` takes over 100 ms, so motions use the last read and a stale one refreshes behind them.
  async readRows() {
    if (!this.rows) await this.rowsLoad;
    else if (!this.loading && Date.now() - this.rowsAt > 1000) this.rowsLoad = this.loadRows();
  }

  // `hc read` joins wrapped lines and trims trailing blank rows, so the text is wrapped again
  // at the pane width and its last row is lined up with the row the cursor had at the start,
  // where the prompt is. An alternate screen comes back as exactly its rows, so it maps one to one.
  async loadRows() {
    this.loading = true;
    try {
      await this.fetchRows();
    } finally {
      this.loading = false;
      this.rowsAt = Date.now();
    }
  }

  async fetchRows() {
    const v = this.view();
    const r = await hc(["read", "--json", "--lines", String(v.total), this.terminal]);
    if (r.code !== 0) return (this.rows = null);
    const { text, how } = JSON.parse(r.stdout);
    const rows = [];
    for (const line of text.split("\n")) rows.push(...this.cells(line, v.cols));
    const exact = how === "screen" && !v.scrolls && rows.length === v.total;
    this.rowsFirst = exact ? 0 : this.anchor - (rows.length - 1);
    this.rows = rows;
  }

  // `hc read` gives characters, but selections count cells: an emoji or CJK character takes two
  // (here the character twice, so it stays one word), a combining mark or a joined emoji none.
  // A wide character that does not fit at the end of a row wraps whole and leaves a blank cell.
  cells(line, cols) {
    const rows = [];
    let row = [];
    let joined = false;
    for (const ch of line) {
      if (joined) {
        joined = false;
        continue;
      }
      if (ch === "‍") {
        joined = true;
        continue;
      }
      if (ch === "️" && row.length && row.at(-1) !== row.at(-2)) row.push(row.at(-1));
      if (/\p{M}/u.test(ch)) continue;
      const w = WIDE.test(ch) ? 2 : 1;
      if (row.length + w > cols) {
        while (row.length < cols) row.push(" ");
        rows.push(row);
        row = [];
      }
      row.push(ch);
      if (w === 2) row.push(ch);
    }
    rows.push(row);
    return rows;
  }

  row(r) {
    return this.rows?.[r - this.rowsFirst] ?? [];
  }

  char({ row, col }) {
    return this.row(row)[col] ?? " ";
  }

  step(p, dir) {
    const { cols, total } = this.view();
    const col = p.col + dir;
    if (col >= 0 && col < cols) return { row: p.row, col };
    const row = p.row + dir;
    if (row < 0 || row >= total) return null;
    return { row, col: dir > 0 ? 0 : cols - 1 };
  }

  // Vim motions over the cells: w and e go forward, b goes back; big words split on spaces only.
  word(motion, big) {
    const dir = motion === "b" ? -1 : 1;
    const k = (p) => kind(this.char(p), big);
    let p = this.cur;
    let next;
    if (motion === "w") {
      const start = k(p);
      while (start && (next = this.step(p, 1)) && k(next) === start) p = next;
      while ((next = this.step(p, 1))) {
        p = next;
        if (k(p)) return p;
      }
      return p;
    }
    if (!(next = this.step(p, dir))) return p;
    p = next;
    while (!k(p) && (next = this.step(p, dir))) p = next;
    const cls = k(p);
    while ((next = this.step(p, dir)) && k(next) === cls && cls) p = next;
    return p;
  }

  lineEdge(edge) {
    const chars = this.row(this.cur.row);
    if (edge === "end") return Math.max(0, chars.length - 1);
    const first = chars.findIndex((ch) => !space(ch));
    return first < 0 ? 0 : first;
  }

  async target(key) {
    const v = this.view();
    const { row, col } = this.cur;
    const clampRow = (r) => Math.max(0, Math.min(v.total - 1, r));
    const half = Math.max(1, Math.floor(v.len / 2));
    switch (key) {
      case "h":
        return { row, col: Math.max(0, col - 1) };
      case "l":
        return { row, col: Math.min(v.cols - 1, col + 1) };
      case "j":
        return { row: clampRow(row + 1), col };
      case "k":
        return { row: clampRow(row - 1), col };
      case "ctrl-d":
        return { row: clampRow(row + half), col };
      case "ctrl-u":
        return { row: clampRow(row - half), col };
      case "ctrl-f":
        return { row: clampRow(row + v.len), col };
      case "ctrl-b":
        return { row: clampRow(row - v.len), col };
      case "g":
        return { row: 0, col: 0 };
      case "G":
        return { row: v.total - 1, col: 0 };
      case "0":
        return { row, col: 0 };
    }
    await this.readRows();
    if (key === "$") return { row, col: this.lineEdge("end") };
    if (key === "^") return { row, col: this.lineEdge("start") };
    return this.word(key.toLowerCase(), key !== key.toLowerCase());
  }

  async move(cx, key) {
    const to = await this.target(key);
    if (!this.visual) {
      run("terminal.select", { terminal: this.terminal, at: to });
      this.cur = to;
      this.reveal(to.row);
      return;
    }
    // A selection can only grow from its anchor by adjust_selection, one cell at a time.
    const { row, col } = this.cur;
    const steps = [];
    if (to.row === 0 && to.col === 0 && key === "g") steps.push("home");
    else if (key === "G") steps.push("end");
    else {
      for (let i = row; i < to.row; i++) steps.push("down");
      for (let i = row; i > to.row; i--) steps.push("up");
      for (let i = col; i < to.col; i++) steps.push("right");
      for (let i = col; i > to.col; i--) steps.push("left");
    }
    if (!steps.length) return;
    const last = steps.pop();
    for (const direction of steps) run("terminal.adjust_selection", { terminal: this.terminal, direction });
    const sel = await this.apply(cx, "terminal.adjust_selection", { direction: last });
    this.cur = sel?.end ?? to;
  }

  reveal(row) {
    const v = this.view();
    if (!v.scrolls) return;
    if (row < v.top) run("terminal.scroll", { terminal: this.terminal, lines: row - v.top });
    else if (row >= v.top + v.len) run("terminal.scroll", { terminal: this.terminal, lines: row - (v.top + v.len - 1) });
  }

  setVisual(mode) {
    this.visual = mode;
    this.enqueue((cx) => this.apply(cx, "terminal.select", { at: this.cur, mode: mode === "line" ? "line" : "cell" }));
  }

  exit() {
    if (this.done) return;
    this.done = true;
    this.wake?.();
    if (this.terminal) {
      run("terminal.clear_selection", { terminal: this.terminal });
      run("terminal.scroll", { terminal: this.terminal, to: "bottom" });
    }
    closeOverlay(props().overlay);
  }

  // Esc and a click beside the popup close it without onKey, so clean up here too.
  async close() {
    this.exit();
  }

  onKey(e) {
    let k = e.modifiers.shift && e.key_char ? e.key_char : e.key;
    k = { left: "h", down: "j", up: "k", right: "l", home: "0", end: "$" }[k] ?? k;
    if (e.modifiers.control) k = "ctrl-" + k;
    const visual = this.visual;
    if (/^([hjklgG0^$wbeWBE]|ctrl-[udfb])$/.test(k)) this.enqueue((cx) => this.move(cx, k));
    else if (k === "v" || k === "space") this.setVisual(visual === "cell" ? null : "cell");
    else if (k === "V") this.setVisual(visual === "line" ? null : "line");
    else if (k === "y" || k === "enter") {
      this.enqueue(async () => {
        if (visual) run("terminal.copy");
        this.exit();
      });
    } else if (k === "/") {
      this.enqueue(async () => {
        this.exit();
        run("terminal.search");
      });
    } else if (k === "q" || k === "escape") {
      if (visual) this.setVisual(null);
      else this.enqueue(async () => this.exit());
    }
  }

  render() {
    const t = theme();
    const mode = this.visual === "line" ? "COPY · V-LINE" : this.visual ? "COPY · VISUAL" : "COPY";
    const panel = v_flex()
      .w(520)
      .p(14)
      .gap(10)
      .rounded(10)
      .border_1()
      .border_color(t.border)
      .bg(t.popover)
      .text_size(12)
      .child(div().text_color(this.visual ? t.accent : t.muted).child(mode))
      .child(
        h_flex()
          .flex_wrap()
          .gap_x(18)
          .gap_y(6)
          .children(
            HELP.map(([k, label]) =>
              h_flex()
                .w(100)
                .gap(8)
                .child(div().w(40).text_color(t.accent).child(k))
                .child(div().text_color(t.foreground).child(label)),
            ),
          ),
      );
    return v_flex()
      .id("copy")
      .track_focus(this.handle)
      .on_key_down((e, cx) => {
        if (["shift", "control", "alt", "platform", "function"].includes(e.key)) return;
        this.onKey(e);
        cx.stop_propagation();
        cx.notify();
      })
      .size_full()
      .justify_end()
      .items_end()
      .pr(16)
      .pb(52)
      .child(panel);
  }
}
