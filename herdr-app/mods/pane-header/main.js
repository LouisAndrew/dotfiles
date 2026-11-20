// Terminals pane header; props: { pane, terminal }.

import { View, div, svg, image } from "gpui-kit";
import { h_flex } from "gpui-base";
import { panes, props, run, home, layout, window, settings } from "herdr";


function folder(cwd) {
  if (!cwd) return "";
  const h = home();
  return cwd === h ? "~" : cwd.startsWith(h + "/") ? "~" + cwd.slice(h.length) : cwd;
}

function find(node, id) {
  if (node?.id === id) return node;
  for (const child of node?.children ?? []) {
    const hit = find(child, id);
    if (hit) return hit;
  }
  return null;
}

// With the sidebar hidden, the macOS traffic lights sit over the top-left pane's header.
// Start that header's title just right of them, as the shipped tab bar does.
function lightsPadding(p) {
  const root = layout();
  const w = window();
  if (!root?.traffic_lights || w?.platform !== "macos" || w.titlebar !== "none" || w.fullscreen) return 12;
  if (!find(root, "sidebar")?.hidden) return 12;
  const first = panes().find((q) => q.tab === p.tab);
  if (!p.zoomed && first?.pane !== p.pane) return 12;
  const pad = Array.isArray(root.padding) ? root.padding[0] : root.padding ?? 0;
  return (root.traffic_lights[0] + 64) / (Number(settings().zoom) || 1) - pad;
}

export default class TerminalsPane extends View {
  me() {
    return panes().find((p) => p.pane === props()?.pane);
  }

  button(id, icon, command, args) {
    return div()
      .id(id)
      .p(4)
      .rounded(5)
      .text_color("#5d6168")
      .cursor_pointer()
      .hover((s) => s.bg("#ffffff0d").text_color("#d6d8db"))
      .on_click((_e, cx) => {
        cx.stop_propagation();
        run(command, args);
      })
      .child(svg(`mods/pane/${icon}.svg`).size(15));
  }

  render() {
    const p = this.me();
    if (!p) return div();
    const pane = p.pane;
    const g = p.program;
    const where = folder(p.cwd);
    // Shells often put the folder in their title already.
    const title = p.title || "shell";
    const dir = where && !title.includes(where) && !/^[~/]/.test(title) ? where : "";
    return h_flex()
      .id(`tm-head-${pane}`)
      .size_full()
      .pl(lightsPadding(p))
      .pr(8)
      .gap(8)
      .items_center()
      .text_size(14)
      .on_click(() => run("pane.focus", { pane }))
      .when(Boolean(g?.icon), (el) =>
        el.child(g.tint ? svg(g.icon).size(16).flex_none().text_color("#d6d8db") : image(g.icon).w(15).h(15).flex_none()),
      )
      .child(div().flex_none().max_w(320).truncate().font_semibold().text_color(p.focused ? "#e8e9eb" : "#a9adb3").child(title))
      .child(div().flex_1().truncate().text_color("#8b8f95").child(dir))
      .child(this.button(`th-r-${pane}`, "split-right", "pane.split", { direction: "right", pane }))
      .child(this.button(`th-d-${pane}`, "split-down", "pane.split", { direction: "down", pane }))
      .child(this.button(`th-z-${pane}`, p.zoomed ? "unzoom" : "zoom", "pane.zoom", { pane }))
      .child(this.button(`th-x-${pane}`, "close", "pane.close", { pane }));
  }
}
