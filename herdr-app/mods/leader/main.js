// tmux-style prefix, matching the WezTerm leader in dotfiles (Ctrl+I).
// keys.json opens this popup; the next key runs one command, then it closes.
// `m` enters a sticky mode that moves the tab with h/l until Escape or Enter.

import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { run, props, closeOverlay, theme, focused, hc, openOverlay } from "herdr";

const TIMEOUT_MS = 1000;

const KEYS = [
  ["l", "split right", () => run("pane.split", { direction: "right" })],
  ["j", "split down", () => run("pane.split", { direction: "down" })],
  ["q", "close pane", () => run("pane.close", {})],
  ["z", "zoom pane", () => run("pane.zoom", {})],
  ["t", "new tab", () => run("tab.new", {})],
  ["[", "prev tab", () => run("tab.prev", {})],
  ["]", "next tab", () => run("tab.next", {})],
  ["{", "prev space", () => run("space.prev", {})],
  ["}", "next space", () => run("space.next", {})],
  ["n", "new space", () => run("space.new", {})],
  ["e", "rename tab", () => run("tab.rename", {})],
  ["s", "spaces", () => run("mod.open", { name: "picker" })],
  ["$", "rename space", () => run("space.rename", {})],
  ["b", "sidebar", () => run("layout.toggle", { id: "sidebar" })],
  ["space", "palette", () => run("app.palette", {})],
  ["c", "copy mode", copyMode],
  ["H", "prev agent", () => run("agent.prev", {})],
  ["L", "next agent", () => run("agent.next", {})],
  ["m", "move tab…", null],
];

// Herdr has no copy mode, so the pane's history opens read-only in Neovim instead.
const PAGER = [
  "\"$HOME/.local/bin/hc\" read --lines 100000 \"$1\" | /opt/homebrew/bin/nvim -R",
  "-c 'set buftype=nofile clipboard=unnamedplus' -c 'nnoremap <buffer> q <cmd>qa!<cr>' -c 'normal! G' -",
].join(" ");

async function copyMode() {
  const f = focused();
  const terminal = f?.shown ?? f?.terminal;
  if (!terminal) return;
  const r = await hc(["run", "--bg", "--json", "--rm", "--no-parent", "--", "sh", "-c", PAGER, "sh", terminal]);
  const address = r.code === 0 ? JSON.parse(r.stdout).address : null;
  if (!address) return;
  openOverlay({ layout: { id: "copy", type: "block", content: { terminal: address } }, kind: "dialog", width: 0.9, height: 0.9 });
}

export default class Leader extends View {
  init(_props, cx) {
    this.handle = cx.focus_handle();
    this.handle.focus();
    this.mode = null;
    this.timer = cx.timer.after(TIMEOUT_MS, () => this.close());
  }

  close() {
    closeOverlay(props().overlay);
  }

  onKey(e) {
    // Shift+] reports key "]"; key_char carries the "}" it types.
    const k = e.modifiers.shift && e.key_char ? e.key_char : e.key;
    if (this.mode === "move") {
      if (k === "h" || k === "j") run("tab.move", { by: -1 });
      else if (k === "l" || k === "k") run("tab.move", { by: 1 });
      else if (k === "escape" || k === "enter") this.close();
      return;
    }
    if (k === "m") {
      this.timer?.cancel?.();
      this.mode = "move";
      return;
    }
    if (/^[1-9]$/.test(k)) {
      this.close();
      run("tab.select", { index: Number(k) });
      return;
    }
    const hit = KEYS.find(([key]) => key === k);
    // Closing stops this mod's pending tasks, so copy mode must finish first.
    if (hit?.[2] === copyMode) {
      this.timer?.cancel?.();
      copyMode().catch(() => {}).finally(() => this.close());
      return;
    }
    this.close();
    hit?.[2]?.();
  }

  render() {
    const t = theme();
    const move = this.mode === "move";
    const rows = move
      ? [["h", "move tab left"], ["l", "move tab right"], ["esc", "done"]]
      : [...KEYS.map(([k, label]) => [k, label]), ["1-9", "go to tab"]];
    return v_flex()
      .id("leader")
      .track_focus(this.handle)
      .on_key_down((e, cx) => {
        if (["shift", "control", "alt", "platform", "function"].includes(e.key)) return;
        this.onKey(e);
        cx.stop_propagation();
        cx.notify();
      })
      .size_full()
      .p(14)
      .gap(10)
      .bg(t.popover)
      .text_size(12)
      .child(div().text_color(t.muted).child(move ? "MOVE TAB" : "LEADER"))
      .child(
        h_flex()
          .flex_wrap()
          .gap_x(18)
          .gap_y(6)
          .children(
            rows.map(([k, label]) =>
              h_flex()
                .w(140)
                .gap(8)
                .child(div().w(36).text_color(t.accent).child(k))
                .child(div().text_color(t.foreground).child(label)),
            ),
          ),
      );
  }
}
