// Ctrl+h/j/k/l: Neovim gets the key (smart-splits crosses into the next pane at its
// edge); other panes move focus. A lone pane gets the key back, so shell ctrl+l still clears.
// split_right/split_down open the new shell in the WSL folder of the focused pane (see split()).

import { View, div } from "gpui-kit";
import { panes, focused, hc, run, checking, nextCommand, setShared } from "herdr";

const KEYS = { left: "ctrl+h", down: "ctrl+j", up: "ctrl+k", right: "ctrl+l" };
const VIM = new Set(["nvim", "vim"]);
const SPLITS = { split_right: "right", split_down: "down" };

// On Windows the core sees only wsl.exe, whose folder is always the Windows home, so a plain
// split starts in ~. The shell's title ("user@host:~/dir") is the only place the WSL folder shows.
// Agent panes set their own title; those splits fall back to the core's shell in ~.
function wslFolder(pane) {
  if (!/^[A-Za-z]:\\/.test(pane?.cwd ?? "")) return null;
  const m = /^([^@\s]+)@[^:\s]+:(~|~\/.*|\/.*)$/.exec(pane.title ?? "");
  if (!m) return null;
  return m[2].replace(/^~/, `/home/${m[1]}`);
}

export default class Nav extends View {
  init(_props, cx) {
    if (checking()) return;
    cx.spawn(async (cx) => {
      for (;;) {
        const command = await nextCommand();
        if (KEYS[command]) await this.go(command);
        else if (command === "copy") await this.copy();
        else if (SPLITS[command]) this.split(SPLITS[command]);
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

  split(direction) {
    const f = focused();
    const dir = wslFolder(panes().find((p) => p.pane === f?.pane));
    if (!dir) return run("pane.split", { direction });
    // Keep in step with the shell in herdr-core/config.windows.toml.
    run("pane.split", { direction, argv: ["wsl.exe", "--cd", dir, "--", "HERDR_WSL=1", "exec", "$SHELL", "-l"] });
  }

  render() {
    return div();
  }
}
