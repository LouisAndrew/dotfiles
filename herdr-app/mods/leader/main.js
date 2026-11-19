// tmux-style prefix, matching the WezTerm leader in dotfiles (Ctrl+I).
// keys.json opens this popup; the next key runs one command, then it closes.
// `m` enters a sticky mode that moves the tab with h/l until Escape or Enter.

import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { run, props, closeOverlay, theme, focused, panes, terminals, layout } from "herdr";

const TIMEOUT_MS = 2500;

function focusedPane() {
  const f = focused();
  return panes().find((p) => (f?.pane ? p.pane === f.pane : p.focused && p.tab === f?.tab));
}

// The sub-agent shows in the "sub-agent" agent block of layouts/ghostty.json, which sits in a
// stack over the tab. The agents sidebar marks a sub-agent row only for the agent such a block shows.
// agent.focus does nothing while the block is hidden, so select the stack child first.
// pane.focus cannot target an agent block ("no such pane").
// Each press shows the next live sub-agent, so repeated presses cycle through them.
function showSubAgent() {
  const pane = focusedPane();
  if (!pane?.terminal) return;
  const kids = terminals().filter((t) => t.parent === pane.terminal && t.state === "live");
  if (!kids.length) return;
  const at = kids.findIndex((t) => t.address === focused()?.agent);
  const kid = kids[(at + 1) % kids.length].address;
  run("layout.select", { stack: "main-stack", child: "sub-agent" });
  run("agent.focus", { terminal: kid });
}

function showPrimary() {
  const pane = focusedPane();
  run("layout.select", { stack: "main-stack", child: "main" });
  if (pane) run("pane.focus", { pane: pane.pane });
}

// pane.close on the sub-agent block closes the parent's pane, because the block is not a pane.
// Kill only the sub-agent that J shows, so a press on the primary view does nothing.
function killSubAgent() {
  const pane = focusedPane();
  const shown = focused()?.agent;
  if (!pane?.terminal || !shown) return;
  const kid = terminals().find((t) => t.parent === pane.terminal && t.address === shown);
  if (!kid) return;
  run("terminal.kill", { terminal: kid.address });
  showPrimary();
}

function findNode(node, id) {
  if (!node) return null;
  if (node.id === id) return node;
  for (const child of node.children ?? []) {
    const hit = findNode(child, id);
    if (hit) return hit;
  }
  return null;
}

// The built-in changes and files mods sit in the "panel-body" stack of layouts/ghostty.json.
function togglePanel(child) {
  const root = layout();
  const panel = findNode(root, "panel");
  const body = findNode(root, "panel-body");
  if (panel && !panel.hidden && body?.active === child) {
    run("layout.hide", { id: "panel" });
    return;
  }
  run("layout.select", { stack: "panel-body", child });
  run("layout.show", { id: "panel" });
}

const KEYS = [
  ["g", "changes", () => togglePanel("changes")],
  ["o", "files", () => togglePanel("files")],
  ["l", "split right", () => run("nav.split_right")],
  ["j", "split down", () => run("nav.split_down")],
  ["q", "close pane", () => run("pane.close", {})],
  ["f", "zoom pane", () => run("pane.zoom", {})],
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
  // The nav mod runs it: this popup closes first, and closing a mod cancels its hc calls.
  ["c", "copy mode", () => run("nav.copy")],
  ["H", "prev agent", () => run("agent.prev", {})],
  ["L", "next agent", () => run("agent.next", {})],
  ["J", "sub-agent", showSubAgent],
  ["K", "primary", showPrimary],
  ["X", "kill sub-agent", killSubAgent],
  ["m", "move tab…", null],
];

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
    this.close();
    hit?.[2]?.();
  }

  render() {
    const t = theme();
    const move = this.mode === "move";
    const rows = move
      ? [["h", "move tab left"], ["l", "move tab right"], ["esc", "done"]]
      : [...KEYS.map(([k, label]) => [k, label]), ["1-9", "go to tab"]];
    // Herdr can't anchor a popup to a corner: mod.json opens it past the bottom right so it
    // lands there, and the frameless popup leaves room for the tab bar below the panel.
    const panel = v_flex()
      .w(520)
      .p(14)
      .gap(10)
      .rounded(10)
      .border_1()
      .border_color(t.border)
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
      .justify_end()
      .items_end()
      .pr(16)
      .pb(52)
      .child(panel);
  }
}
