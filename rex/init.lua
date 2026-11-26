-- Rex keys, matching the Herdr app setup in herdr-app/keys.json and its leader and nav mods.
-- Herdr "space" is a Rex session, a Herdr "tab" is a Rex tab (window), and a pane is a block.

local TERMINAL = "com.superlogical.terminal"
local SHELL = "com.superlogical.terminal.shell"
local VIM = { nvim = true, vim = true }

local function window_of(view, block_id)
  for _, w in ipairs(view.windows or {}) do
    for _, layer in ipairs(w.layers or {}) do
      for _, b in ipairs(layer.blocks or {}) do
        if b.block_id == block_id then return w end
      end
    end
  end
end

local function tiled_count(w)
  local n = 0
  for _, layer in ipairs(w.layers or {}) do
    if layer.kind == "tiled" then n = n + #(layer.blocks or {}) end
  end
  return n
end

-- While a zoomed pane hides other panes, its tab label ends with ZOOM_MARK. The config file
-- gets no events, so only the zoom and nav keys below update the mark.
local ZOOM_MARK = " ⛶"
-- An unnamed tab shows its pane's title, so the mark goes after that title, and these tabs get
-- their label cleared again on unzoom. Lua state lasts until the next config reload.
local unnamed = {}

local SHELLS = { zsh = true, bash = true, fish = true, sh = true, login = true }

-- Without a title from the program, Rex titles the tab from the program and its folder.
local function pane_title(block_id)
  local t = rex.block.call(TERMINAL, "title", { block_id = block_id })
  if t and t.title and t.title ~= "" then return t.title end
  local p = rex.block.call(TERMINAL, "process", { block_id = block_id })
  local fg = p and p.foreground
  if not fg then return "zoomed" end
  local dir = fg.cwd == os.getenv("HOME") and "~" or (fg.cwd or ""):match("[^/]+$")
  if SHELLS[fg.name] then return dir or fg.name end
  return dir and (fg.name .. " · " .. dir) or fg.name
end

local function mark_zoom(block_id)
  local view = rex.session.view{}
  if not view then return end
  local w = block_id and window_of(view, block_id)
  if not w then
    for _, aw in ipairs(view.windows or {}) do
      if aw.window_id == view.active_window_id then w = aw end
    end
  end
  if not w then return end
  local label = w.label or ""
  local marked = label:sub(-#ZOOM_MARK) == ZOOM_MARK
  local base = marked and label:sub(1, -#ZOOM_MARK - 1) or label
  if base:match("^Window %x+$") or (marked and unnamed[w.window_id]) then base = "" end
  local want = base
  if w.tiled_zoomed_block_id and tiled_count(w) > 1 then
    unnamed[w.window_id] = base == "" or nil
    want = (base ~= "" and base or pane_title(w.tiled_zoomed_block_id)) .. ZOOM_MARK
  else
    unnamed[w.window_id] = nil
  end
  if marked or want ~= base then
    rex.session.set_window_label{ window_id = w.window_id, label = want }
  end
end

rex.action{
  name = "zoom_toggle",
  title = "Zoom Pane and Mark Tab",
  run = function(ctx)
    rex.session.zoom_block{ block_id = ctx.block_id }
    mark_zoom(ctx.block_id)
  end,
}

-- Ctrl+h/j/k/l: Neovim gets the key (nvim/lua/plugins/splits.lua crosses into the next pane at
-- its edge); other panes move focus. A lone pane gets the key back, so shell ctrl+l still clears.
-- Returning false hands the key to the focused terminal.
local function nav(dir)
  return function(ctx)
    if not ctx.block_id then return false end
    local p = rex.block.call(TERMINAL, "process", { block_id = ctx.block_id })
    if p and p.foreground and VIM[p.foreground.name] then return false end
    local view = rex.session.view{}
    local w = view and window_of(view, ctx.block_id)
    if not w or tiled_count(w) <= 1 then return false end
    rex.session.focus_direction{ direction = dir }
    mark_zoom(ctx.block_id)
    return true
  end
end

rex.bind("ctrl+h", nav("left"))
rex.bind("ctrl+j", nav("down"))
rex.bind("ctrl+k", nav("up"))
rex.bind("ctrl+l", nav("right"))

-- Herdr ctrl-1..9 selects a space by its place in the list.
rex.action{
  name = "session_goto",
  title = "Go to Session by Number",
  args = { index = "integer" },
  run = function(ctx, args)
    local list, err = rex.call("session.list")
    if not list then error(err, 0) end
    local s = (list.sessions or {})[args.index]
    if s then rex.client.queue("session.select", { session_id = s.session_id }) end
  end,
}

-- Leader I: a session named after a Jira key. shell/functions/herdr-ticket.sh exports the
-- name as $TN in its shells.
rex.action{
  name = "ticket_session",
  title = "New Ticket Session…",
  run = function(ctx, args)
    local name = rex.ui.input{ title = "new ticket space", placeholder = "Jira key, for example rad-885" }
    if name == nil or name == "" then return end
    local s, err = rex.call("session.create", {
      label = name,
      initial_windows = { { layout = rex.layout.block{ flavor = SHELL } } },
    })
    if not s then error(err, 0) end
    rex.client.queue("session.select", { session_id = s.session_id })
  end,
}

-- Global keys from herdr-app/keys.json that differ from Rex's defaults.
rex.bind("cmd+w", "client.tab.close")
rex.bind("cmd+shift+w", "pane.close")
rex.bind("cmd+alt+]", "session.next")
rex.bind("cmd+alt+[", "session.previous")
rex.bind("cmd+p", "session.switch")
rex.bind("cmd+b", "client.sidebar.toggle")
rex.bind("f2", "client.tab.rename")
rex.bind("shift+f2", "session.rename")
rex.bind("alt+backspace", "pane.send_key", { key = "ctrl+w" })
rex.bind("cmd+x", "pane.copy_mode.enter")
for i = 1, 9 do
  rex.bind("ctrl+" .. i, "session_goto", { index = i })
end

-- Leader: ctrl+i, then one key, as the Herdr leader mod.
local L = "ctrl+i>"
rex.bind(L .. "l", "pane.split", { direction = "right" })
rex.bind(L .. "j", "pane.split", { direction = "down" })
rex.bind(L .. "q", "pane.close")
rex.bind(L .. "f", "zoom_toggle")
rex.bind(L .. "z", "zoom_toggle")
rex.bind("cmd+shift+enter", "zoom_toggle")
rex.bind(L .. "t", "client.tab.new")
rex.bind(L .. "[", "client.tab.previous")
rex.bind(L .. "]", "client.tab.next")
rex.bind(L .. "shift+[", "session.previous")
rex.bind(L .. "shift+]", "session.next")
rex.bind(L .. "n", "session.new")
rex.bind(L .. "shift+i", "ticket_session")
rex.bind(L .. "shift+q", "session.close")
rex.bind(L .. "e", "client.tab.rename")
rex.bind(L .. "s", "session.switch")
rex.bind(L .. "shift+4", "session.rename")
rex.bind(L .. "b", "client.sidebar.toggle")
rex.bind(L .. "space", "client.palette.toggle")
rex.bind(L .. "c", "pane.copy_mode.enter")
rex.bind(L .. "m", "client.mode.enter", { name = "movetab" })
for i = 1, 9 do
  rex.bind(L .. i, "client.tab.goto", { index = i })
end

-- Leader m: move the tab with h/l until escape or enter.
rex.mode("movetab", { exclusive = true })
rex.bind("movetab/h", "client.tab.move.backward")
rex.bind("movetab/j", "client.tab.move.backward")
rex.bind("movetab/l", "client.tab.move.forward")
rex.bind("movetab/k", "client.tab.move.forward")
rex.bind("movetab/enter", "client.mode.exit")
rex.bind("movetab/escape", "client.mode.exit")
