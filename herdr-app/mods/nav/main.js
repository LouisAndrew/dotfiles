// Ctrl+h/j/k/l: Neovim gets the key (smart-splits crosses into the next pane at its
// edge); other panes move focus. A lone pane gets the key back, so shell ctrl+l still clears.

import { View, div } from "gpui-kit";
import { panes, focused, hc, run, checking, nextCommand, setShared } from "herdr";

const KEYS = { left: "ctrl+h", down: "ctrl+j", up: "ctrl+k", right: "ctrl+l" };
const VIM = new Set(["nvim", "vim"]);

export default class Nav extends View {
  init(_props, cx) {
    if (checking()) return;
    cx.spawn(async (cx) => {
      for (;;) {
        const command = await nextCommand();
        if (KEYS[command]) await this.go(command);
        else if (command === "copy") await this.copy();
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

  // Leader c. Claude Code draws on the alternate screen, so the copy mod sees only its last
  // screen; its own transcript view (ctrl+o) holds the whole conversation.
  async copy() {
    const f = focused();
    const terminal = f?.shown ?? f?.terminal;
    const pane = panes().find((p) => p.terminal === terminal);
    if (!terminal) return;
    if (pane?.program?.key === "claude") return void (await hc(["keys", terminal, "ctrl+o"]));
    // The copy mod shows in the "copy" child of the main stack, so the sidebar and tab bar stay.
    setShared("copy", { terminal, at: Date.now() });
    run("layout.select", { stack: "main-stack", child: "copy" });
  }

  render() {
    return div();
  }
}
