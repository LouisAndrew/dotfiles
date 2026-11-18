// Leader c: tmux-style copy mode. It reads the pane's text once with `hc read` and draws that
// snapshot in the "copy" child of the layout's main stack, with its own cursor, so keys never
// wait on the terminal and an agent that keeps redrawing cannot move the text under the cursor.
// Plain text only: hc gives no colors.

import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { run, shared, terminals, hc, theme, settings, checking } from "herdr";

const HISTORY = 10000;
const STACK = "main-stack";
const HINT = "hjkl wbe 0^$ gG ^u^d f/t  v V o  y ⏎ Y  / ? n N * #  q";

const space = (ch) => ch === " " || ch === "\t";
const kind = (ch, big) => (space(ch) ? 0 : big || /[\p{L}\p{N}_]/u.test(ch) ? 1 : 2);
const WIDE =
  /\p{Emoji_Presentation}|[ᄀ-ᅟ⺀-〾ぁ-㏿㐀-䶿一-鿿ꀀ-꓏가-힣豈-﫿︰-﹏＀-｠￠-￦\u{20000}-\u{3FFFD}]/u;
const escapeRe = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

export default class Copy extends View {
  init(_props, cx) {
    this.handle = cx.focus_handle();
    this.height = 600;
    this.reset();
    if (checking()) return;
    // The stack starts this mod the first time it shows it and keeps it alive after, so each
    // Leader c arrives as a new shared("copy") request from the nav mod, not as a new start.
    cx.spawn(async (cx) => {
      for (;;) {
        const req = shared("copy");
        if (req && req.at !== this.seen && Date.now() - req.at < 3000) {
          this.seen = req.at;
          await this.open(cx, req.terminal);
        }
        await new Promise((resolve) => cx.timer.after(50, () => resolve()));
      }
    });
  }

  async open(cx, terminal) {
    this.reset();
    this.terminal = terminal;
    this.done = false;
    this.handle.focus();
    cx.notify();
    await this.load();
    if (this.done) return;
    this.handle.focus();
    cx.notify();
  }

  reset() {
    this.rows = null;
    this.cur = { row: 0, col: 0 };
    this.want = 0;
    this.top = 0;
    this.visual = null;
    this.count = "";
    this.pending = null;
    this.prompt = null;
    this.search = null;
    this.lastFind = null;
    this.lastKey = null;
    this.message = "";
  }


  async load() {
    const t = terminals().find((x) => x.address === this.terminal);
    const cols = t?.cols ?? 200;
    const r = await hc(["read", "--json", "--lines", String(HISTORY), this.terminal]);
    if (r.code !== 0) {
      this.rows = [];
      this.message = r.stderr.trim() || "hc read failed";
      return;
    }
    const lines = JSON.parse(r.stdout).text.split("\n");
    this.rows = [];
    for (const line of lines) this.rows.push(...this.wrap(line, cols));
    let last = this.rows.length - 1;
    while (last > 0 && !this.rows[last].text.trim()) last--;
    this.cur = { row: last, col: 0 };
    this.top = Math.max(0, last - this.visibleRows() + 1);
    this.anchor = true;
  }

  // `hc read` joins wrapped lines, so they are wrapped again at the pane width to look as they
  // did. `joined` marks a row that continues the one above: a yank across it adds no newline.
  // A wide character counts two cells and wraps whole, as the terminal draws it.
  wrap(line, cols) {
    const rows = [];
    let chars = [];
    let width = 0;
    for (const ch of line) {
      const w = WIDE.test(ch) ? 2 : 1;
      if (width + w > cols && chars.length) {
        rows.push(chars);
        chars = [];
        width = 0;
      }
      chars.push(ch);
      width += w;
    }
    rows.push(chars);
    return rows.map((c, i) => ({ chars: c, text: c.join(""), joined: i > 0 }));
  }

  // The terminal's font and line height, so the snapshot reads like the pane it came from.
  // font_size already has the zoom in it, but the terminal spaces its rows from the unzoomed size.
  metrics() {
    const s = settings();
    const size = Number(s.font_size) || 14;
    const lh = Number(s.terminal_line_height) || 1.3;
    return { size, row: Math.round((size * lh) / (Number(s.zoom) || 1)), font: s.font_family ?? s.font };
  }

  visibleRows() {
    return Math.max(1, Math.floor((this.height - 48) / this.metrics().row));
  }

  len(r) {
    return this.rows[r]?.chars.length ?? 0;
  }

  char({ row, col }) {
    return this.rows[row]?.chars[col] ?? " ";
  }

  clampCol(row, col) {
    const max = Math.max(0, this.len(row) - 1 + (this.visual ? 1 : 0));
    return Math.max(0, Math.min(max, col));
  }

  step(p, dir) {
    const col = p.col + dir;
    if (col >= 0 && col < Math.max(1, this.len(p.row))) return { row: p.row, col };
    const row = p.row + dir;
    if (row < 0 || row >= this.rows.length) return null;
    return { row, col: dir > 0 ? 0 : Math.max(0, this.len(row) - 1) };
  }

  // Vim word motions across rows; big words split on spaces only.
  word(motion, big) {
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
    const dir = motion === "b" ? -1 : 1;
    if (!(next = this.step(p, dir))) return p;
    p = next;
    while (!k(p) && (next = this.step(p, dir))) p = next;
    const cls = k(p);
    while ((next = this.step(p, dir)) && k(next) === cls) p = next;
    return p;
  }

  find(op, ch, row, col) {
    const chars = this.rows[row].chars;
    const fwd = op === "f" || op === "t";
    const till = op === "t" || op === "T";
    const from = col + (fwd ? 1 : -1) + (till && this.lastFindRepeat ? (fwd ? 1 : -1) : 0);
    const i = fwd ? chars.indexOf(ch, from) : chars.lastIndexOf(ch, from);
    if (i < 0) return null;
    return { row, col: till ? i - (fwd ? 1 : -1) : i };
  }

  paragraph(dir) {
    let r = this.cur.row + dir;
    while (r > 0 && r < this.rows.length - 1 && !this.rows[r].text.trim()) r += dir;
    while (r > 0 && r < this.rows.length - 1 && this.rows[r].text.trim()) r += dir;
    return { row: Math.max(0, Math.min(this.rows.length - 1, r)), col: 0 };
  }

  matchRe() {
    if (!this.search) return null;
    const flags = /[A-Z]/.test(this.search.text) ? "g" : "gi";
    try {
      return new RegExp(this.search.word ? `\\b${escapeRe(this.search.text)}\\b` : escapeRe(this.search.text), flags);
    } catch {
      return null;
    }
  }

  // Finds the next match after the cursor (or before it, going back), wrapping like vim.
  // Columns are character offsets in the row, the same unit the cursor uses.
  searchNext(back) {
    const re = this.matchRe();
    if (!re) return null;
    const n = this.rows.length;
    const hits = (r) => {
      const out = [];
      const text = this.rows[r].text;
      for (const m of text.matchAll(re)) out.push(Array.from(text.slice(0, m.index)).length);
      return out;
    };
    for (let i = 0; i <= n; i++) {
      const r = (this.cur.row + (back ? -i : i) + n * 2) % n;
      let cols = hits(r);
      if (i === 0) cols = cols.filter((c) => (back ? c < this.cur.col : c > this.cur.col));
      else if (i === n) cols = cols.filter((c) => (back ? c >= this.cur.col : c <= this.cur.col));
      if (cols.length) return { row: r, col: back ? cols.at(-1) : cols[0] };
    }
    this.message = `not found: ${this.search.text}`;
    return null;
  }

  wordUnderCursor() {
    const chars = this.rows[this.cur.row].chars;
    const isWord = (ch) => kind(ch ?? " ", false) === 1;
    let s = this.cur.col;
    while (s < chars.length && !isWord(chars[s])) s++;
    if (s >= chars.length) return null;
    let e = s;
    while (s > 0 && isWord(chars[s - 1])) s--;
    while (e < chars.length && isWord(chars[e])) e++;
    return chars.slice(s, e).join("");
  }

  // Where a motion takes the cursor, or null when it does not move it.
  target(key, n) {
    const { row, col } = this.cur;
    const last = this.rows.length - 1;
    const clampRow = (r) => Math.max(0, Math.min(last, r));
    const page = this.visibleRows();
    const half = Math.max(1, Math.floor(page / 2));
    switch (key) {
      case "h":
        return { row, col: Math.max(0, col - n) };
      case "l":
        return { row, col: col + n };
      case "j":
        return { row: clampRow(row + n), col: this.want, keep: true };
      case "k":
        return { row: clampRow(row - n), col: this.want, keep: true };
      case "ctrl-d":
        return { row: clampRow(row + half * n), col: this.want, keep: true, scroll: half * n };
      case "ctrl-u":
        return { row: clampRow(row - half * n), col: this.want, keep: true, scroll: -half * n };
      case "ctrl-f":
        return { row: clampRow(row + page * n), col: this.want, keep: true, scroll: page * n };
      case "ctrl-b":
        return { row: clampRow(row - page * n), col: this.want, keep: true, scroll: -page * n };
      case "g":
        return { row: this.count ? clampRow(n - 1) : 0, col: 0 };
      case "G":
        return { row: this.count ? clampRow(n - 1) : last, col: 0 };
      case "H":
        return { row: this.top, col: 0 };
      case "M":
        return { row: clampRow(this.top + Math.floor(Math.min(page, this.rows.length - this.top) / 2)), col: 0 };
      case "L":
        return { row: clampRow(this.top + page - 1), col: 0 };
      case "0":
        return { row, col: 0 };
      case "^": {
        const i = this.rows[row].chars.findIndex((ch) => !space(ch));
        return { row, col: Math.max(0, i) };
      }
      case "$":
        return { row, col: Infinity };
      case "{":
        return this.paragraph(-1);
      case "}":
        return this.paragraph(1);
      case "n":
      case "N":
        return this.searchNext(this.search && (key === "N") !== this.search.back);
    }
    if ("wbeWBE".includes(key)) {
      const from = this.cur;
      for (let i = 0; i < n; i++) this.cur = this.word(key.toLowerCase(), key !== key.toLowerCase());
      const to = this.cur;
      this.cur = from;
      return to;
    }
    return null;
  }

  // j and k keep the column the cursor wanted, as vim does, so a short row does not pull it left.
  moveTo(to) {
    if (!to) return;
    if (!to.keep) this.want = to.col;
    this.cur = { row: to.row, col: this.clampCol(to.row, to.col) };
    if (to.scroll) this.scroll(to.scroll);
    this.reveal();
  }

  scroll(by) {
    const max = Math.max(0, this.rows.length - this.visibleRows());
    this.top = Math.max(0, Math.min(max, this.top + by));
  }

  reveal() {
    const page = this.visibleRows();
    if (this.cur.row < this.top) this.top = this.cur.row;
    else if (this.cur.row >= this.top + page) this.top = this.cur.row - page + 1;
  }

  // Keeps the cursor on screen after the view moved under it (ctrl-e, ctrl-y, the wheel).
  follow() {
    const page = this.visibleRows();
    const row = Math.max(this.top, Math.min(this.top + page - 1, this.cur.row));
    if (row !== this.cur.row) this.cur = { row, col: this.clampCol(row, this.want) };
  }

  range() {
    if (!this.visual) return null;
    let [a, b] = [this.vstart, this.cur];
    if (a.row > b.row || (a.row === b.row && a.col > b.col)) [a, b] = [b, a];
    return { a, b };
  }

  selectedText() {
    const r = this.range();
    if (!r) return "";
    let out = "";
    for (let row = r.a.row; row <= r.b.row; row++) {
      const chars = this.rows[row].chars;
      const line = this.visual === "line";
      const from = line || row !== r.a.row ? 0 : r.a.col;
      const to = line || row !== r.b.row ? chars.length : r.b.col + 1;
      if (row > r.a.row && !this.rows[row].joined) out += "\n";
      out += chars.slice(from, to).join("");
    }
    return this.visual === "line" ? out.replace(/[ \t]+$/gm, "") + "\n" : out;
  }

  yank(cx, text) {
    if (text) cx.write_to_clipboard(text);
    this.exit();
  }

  exit() {
    if (this.done) return;
    this.done = true;
    run("layout.select", { stack: STACK, child: "main" });
    if (this.terminal) run("pane.focus", { terminal: this.terminal });
  }

  promptKey(e) {
    const p = this.prompt;
    if (e.key === "escape") this.prompt = null;
    else if (e.key === "backspace") {
      if (!p.text) this.prompt = null;
      else p.text = Array.from(p.text).slice(0, -1).join("");
    } else if (e.key === "enter") {
      this.prompt = null;
      if (p.text) this.search = { text: p.text, back: p.back };
      this.moveTo(this.searchNext(this.search?.back));
    } else if (e.key_char && !e.modifiers.control && !e.modifiers.platform) p.text += e.key_char;
  }

  onKey(e, cx) {
    this.message = "";
    this.anchor = false;
    if (this.prompt) return this.promptKey(e);
    if (this.pending) {
      const op = this.pending;
      this.pending = null;
      const ch = e.key === "space" ? " " : e.key_char;
      if (!ch || e.key === "escape") return;
      this.lastFind = { op, ch };
      return this.moveTo(this.find(op, ch, this.cur.row, this.cur.col));
    }
    let k = e.modifiers.shift && e.key_char ? e.key_char : e.key;
    k = { left: "h", down: "j", up: "k", right: "l", home: "0", end: "$", pageup: "ctrl-b", pagedown: "ctrl-f" }[k] ?? k;
    if (e.modifiers.control) k = "ctrl-" + k;
    if (e.modifiers.platform) k = "cmd-" + k;
    if (/^[0-9]$/.test(k) && (k !== "0" || this.count)) {
      this.count += k;
      return;
    }
    const n = Math.max(1, Number(this.count) || 1);
    if (k === "g" && this.lastKey !== "g") {
      this.lastKey = "g";
      return;
    }
    this.lastKey = null;
    if (!this.rows?.length) {
      if (k === "q" || k === "escape") this.exit();
      return;
    }

    if ("fFtT".includes(k) && k.length === 1) this.pending = k;
    else if (k === ";" || k === ",") {
      const f = this.lastFind;
      if (f) {
        const flip = { f: "F", F: "f", t: "T", T: "t" };
        this.lastFindRepeat = true;
        this.moveTo(this.find(k === "," ? flip[f.op] : f.op, f.ch, this.cur.row, this.cur.col));
        this.lastFindRepeat = false;
      }
    } else if (k === "/" || k === "?") this.prompt = { back: k === "?", text: "" };
    else if (k === "*" || k === "#") {
      const w = this.wordUnderCursor();
      if (w) {
        this.search = { text: w, back: k === "#", word: true };
        this.moveTo(this.searchNext(k === "#"));
      }
    } else if (k === "ctrl-e" || k === "ctrl-y") {
      this.scroll(k === "ctrl-e" ? n : -n);
      this.follow();
    } else if (k === "v" || k === "V" || k === "space") {
      const mode = k === "V" ? "line" : "char";
      if (this.visual === mode) this.visual = null;
      else {
        if (!this.visual) this.vstart = this.cur;
        this.visual = mode;
      }
    } else if (k === "o" && this.visual) [this.vstart, this.cur] = [this.cur, this.vstart];
    else if (k === "y" || k === "enter" || k === "cmd-c") this.yank(cx, this.selectedText());
    else if (k === "Y") {
      this.vstart = this.cur;
      this.cur = { row: Math.min(this.rows.length - 1, this.cur.row + n - 1), col: 0 };
      this.visual = "line";
      this.yank(cx, this.selectedText());
    } else if (k === "escape" || k === "ctrl-c") {
      if (this.visual) this.visual = null;
      else this.exit();
    } else if (k === "q") this.exit();
    else this.moveTo(this.target(k, n));
    this.count = "";
  }

  // Splits a row into runs that share one look: cursor, selection, search match or plain.
  runs(r, re, sel) {
    const chars = this.rows[r].chars;
    const n = Math.max(chars.length, r === this.cur.row ? this.cur.col + 1 : 0);
    const look = new Array(n).fill(0);
    if (re) {
      const text = this.rows[r].text;
      for (const m of text.matchAll(re)) {
        const s = Array.from(text.slice(0, m.index)).length;
        for (let i = 0; i < Array.from(m[0]).length; i++) look[s + i] = 1;
      }
    }
    if (sel && r >= sel.a.row && r <= sel.b.row) {
      const line = this.visual === "line";
      const from = line || r !== sel.a.row ? 0 : sel.a.col;
      const to = line || r !== sel.b.row ? n - 1 : sel.b.col;
      for (let i = from; i <= to && i < n; i++) look[i] = 2;
    }
    if (r === this.cur.row) look[this.cur.col] = 3;
    const out = [];
    for (let i = 0; i < n; i++) {
      const ch = chars[i] ?? " ";
      if (out.length && out.at(-1).look === look[i]) out.at(-1).text += ch;
      else out.push({ look: look[i], text: ch });
    }
    return out;
  }

  render() {
    const t = theme();
    const m = this.metrics();
    const page = this.visibleRows();
    const sel = this.range();
    const re = this.matchRe();
    const looks = [
      null,
      [t.ansi3, t.background],
      [t.selection, t.foreground],
      [t.accent, t.accent_foreground ?? t.background],
    ];
    const lines = [];
    if (this.rows) {
      for (let r = this.top; r < Math.min(this.rows.length, this.top + page); r++) {
        lines.push(
          h_flex()
            .h(m.row)
            .flex_none()
            .whitespace_nowrap()
            .overflow_hidden()
            .when(this.visual === "line" && sel && r >= sel.a.row && r <= sel.b.row, (el) => el.bg(t.selection))
            .children(
              this.runs(r, re, sel).map(({ look, text }) => {
                const span = div().child(text);
                return looks[look] ? span.bg(looks[look][0]).text_color(looks[look][1]) : span;
              }),
            ),
        );
      }
    }
    const mode = this.visual === "line" ? "V-LINE" : this.visual ? "VISUAL" : "COPY";
    const left = this.prompt
      ? (this.prompt.back ? "?" : "/") + this.prompt.text + "▏"
      : this.message || (this.rows ? HINT : "Reading…");
    const where = this.rows ? `${this.count}${this.count ? " " : ""}${this.cur.row + 1}/${this.rows.length}` : "";
    const bar = h_flex()
      .h(32)
      .flex_none()
      .px(12)
      .gap(12)
      .bg(t.chrome)
      .border_t_1()
      .border_color(t.border)
      .text_size(12)
      .child(div().px(6).rounded(4).bg(this.visual ? t.accent : t.raised).text_color(this.visual ? t.accent_foreground : t.foreground).child(mode))
      .child(div().flex_1().min_w_0().truncate().text_color(this.prompt ? t.foreground : t.muted).child(left))
      .child(div().text_color(t.muted).child(where));
    return v_flex()
      .id("copy")
      .track_focus(this.handle)
      .on_key_down((e, cx) => {
        if (["shift", "control", "alt", "platform", "function"].includes(e.key)) return;
        this.onKey(e, cx);
        cx.stop_propagation();
        cx.notify();
      })
      .on_mouse_down("left", (_e, cx) => {
        this.handle.focus();
        cx.stop_propagation();
      })
      .on_scroll_wheel((e, cx) => {
        const lines = e.delta_lines?.y ?? e.delta.y / m.row;
        this.wheel = (this.wheel ?? 0) - lines;
        const by = Math.trunc(this.wheel);
        if (!by || !this.rows) return;
        this.wheel -= by;
        this.scroll(by);
        this.follow();
        cx.notify();
      })
      .on_size_change((size, cx) => {
        // The reported size has the zoom applied, but the rows are drawn without it.
        const height = size.height / (Number(settings().zoom) || 1);
        // A hidden stack child can report no height; keep the last real one.
        if (height === this.height || height < this.metrics().row) return;
        this.height = height;
        if (!this.rows) return cx.notify();
        if (this.anchor) this.top = Math.max(0, this.cur.row - this.visibleRows() + 1);
        else this.reveal();
        this.anchor = false;
        cx.notify();
      })
      .size_full()
      .bg(t.background)
      .text_color(t.foreground)
      .child(
        v_flex()
          .flex_1()
          .min_h_0()
          .overflow_hidden()
          .p(8)
          .font_family(m.font)
          .text_size(m.size)
          .children(lines),
      )
      .child(bar);
  }
}
