// One row for the bottom of layouts/ghostty-compact.json: the spaces, then the agents.
// A space chip shows that space; an agent chip focuses the agent's pane.

import { View, div, svg } from "gpui-kit";
import { h_flex } from "gpui-base";
import { agents, spaces, run, theme } from "herdr";

function status(t, s) {
  if (!s) return null;
  if (s === "working") return svg("mods/workspace-chrome/spinner.svg").size(11).flex_none().text_color(t.working).spin(900);
  if (s === "idle") return div().size(7).flex_none().rounded(4).border(1.5).border_color(t.idle ?? t.dim);
  return div().size(7).flex_none().rounded(4).bg(t[s] ?? t.dim);
}

function chip(t, id, label, { active, s, tooltip, onClick }) {
  return h_flex()
    .id(id)
    .h(24)
    .px(10)
    .gap(6)
    .flex_none()
    .items_center()
    .rounded(6)
    .text_size(12)
    .cursor_pointer()
    .bg(active ? t.raised : t.background)
    .text_color(s === "blocked" ? t.blocked : active ? t.foreground : t.muted)
    .hover((st) => st.bg(t.hover))
    .tooltip(tooltip)
    .on_click(onClick)
    .when(Boolean(s), (el) => el.child(status(t, s)))
    .child(div().max_w(220).whitespace_nowrap().text_ellipsis().child(label));
}

export default class AgentBar extends View {
  render() {
    const t = theme();
    const spaceChips = spaces().map((sp) =>
      chip(t, `ab-sp-${sp.id}`, `${sp.index} ${sp.name}`, {
        active: sp.active,
        s: sp.status,
        tooltip: sp.branch ? `${sp.name} · ${sp.branch}` : sp.name,
        onClick: () => run("space.select", { id: sp.id }),
      }),
    );
    const agentChips = agents().map((a) =>
      chip(t, `ab-${a.address}`, `${a.space_name} · ${a.program?.name ?? a.app ?? "agent"}`, {
        active: a.focused,
        s: a.status,
        tooltip: a.title,
        onClick: () => run("pane.focus", { pane: a.pane }),
      }),
    );
    return h_flex()
      .id("agent-bar")
      .size_full()
      .gap(4)
      .items_center()
      .overflow_x_scroll()
      .children(spaceChips)
      .child(div().w(2).h(18).mx(8).flex_none().rounded(1).bg(t.dim))
      .children(agentChips.length ? agentChips : [div().text_size(12).text_color(t.dim).child("No agents")]);
  }
}
