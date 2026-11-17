// Ctrl+h/j/k/l: Neovim gets the key (smart-splits crosses into the next pane at its
// edge); other panes move focus. A lone pane gets the key back, so shell ctrl+l still clears.

import { View, div } from "gpui-kit";
import { panes, focused, hc, run, checking, nextCommand, terminals, notify } from "herdr";

const KEYS = { left: "ctrl+h", down: "ctrl+j", up: "ctrl+k", right: "ctrl+l" };
const VIM = new Set(["nvim", "vim"]);

// Leader c: Herdr has no copy mode, so the pane's history opens read-only in Vim instead.
// It runs here, not in the leader, because this mod outlives the leader's popup.
// Plain `hc read` with history can take seconds; its --json form returns at once.
const PAGER = [
  "\"$HOME/.local/bin/hc\" read --json --lines 100000 \"$1\" | /opt/homebrew/bin/jq -r .text | /usr/bin/vim -u NONE -N -R",
  "-c 'set clipboard=unnamed hlsearch incsearch ignorecase smartcase' -c 'nnoremap q :qa!<cr>' -c 'normal! G' -",
].join(" ");

async function copyMode(cx) {
  const f = focused();
  const terminal = f?.shown ?? f?.terminal;
  if (!terminal) throw new Error("No focused terminal");
  // A child of the pane, so terminal.peek can show it over the tab.
  const r = await hc(["run", "--bg", "--json", "--rm", "--no-notify", "--parent", terminal, "--", "sh", "-c", PAGER, "sh", terminal]);
  const address = r.code === 0 ? JSON.parse(r.stdout).address : null;
  if (!address) throw new Error(r.stderr || r.stdout || "hc run failed");
  // The app learns about new terminals a moment after the core starts them.
  const tick = () => new Promise((resolve) => cx.timer.after(50, () => resolve()));
  for (let i = 0; i < 60 && !terminals().some((t) => t.address === address); i++) await tick();
  run("terminal.peek", { terminal: address });
}

export default class Nav extends View {
  init(_props, cx) {
    if (checking()) return;
    cx.spawn(async (cx) => {
      for (;;) {
        const command = await nextCommand();
        if (KEYS[command]) await this.go(command);
        else if (command === "copy") {
          try {
            await copyMode(cx);
          } catch (err) {
            notify({ title: "Copy mode failed", body: String(err), level: "error" });
          }
        }
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
