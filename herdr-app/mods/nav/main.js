// Ctrl+h/j/k/l: Neovim gets the key (smart-splits crosses into the next pane at its
// edge); other panes move focus. A lone pane gets the key back, so shell ctrl+l still clears.

import { View, div } from "gpui-kit";
import { panes, focused, hc, run, checking, nextCommand } from "herdr";

const KEYS = { left: "ctrl+h", down: "ctrl+j", up: "ctrl+k", right: "ctrl+l" };
const VIM = new Set(["nvim", "vim"]);

export default class Nav extends View {
  init(_props, cx) {
    if (checking()) return;
    cx.spawn(async () => {
      for (;;) {
        const dir = await nextCommand();
        if (KEYS[dir]) await this.go(dir);
      }
    });
  }

  async go(dir) {
    const f = focused();
    const all = panes();
    const pane = all.find((p) => p.pane === f?.pane);
    const terminal = f?.shown ?? f?.terminal;
    const alone = pane && all.filter((p) => p.tab === pane.tab).length === 1;
    if (terminal && (VIM.has(pane?.program?.key) || alone)) {
      await hc(["keys", terminal, KEYS[dir]]);
      return;
    }
    run("pane.go", { direction: dir });
  }

  render() {
    return div();
  }
}
