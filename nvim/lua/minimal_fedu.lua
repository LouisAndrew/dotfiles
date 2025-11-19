local preset_config = {
    light = {
        bg = "#131313",
        shade = "#0c0c0c",
    },
    dark = {
        bg = "#0a0a0a",
        shade = "#131313",
    },
}

local theme = "dark"

local preset = preset_config[theme]

local dimmed_white = "#9a9a9a"
local white = "#ffffff"

local palette = {
    red = {
        "#42191b",
        "#ff8185",
    },
    blue = {
        "#172554",
        "#93c5fd",
    },
    indigo = {
        "#1e1b4b",
        "#818cf8",
        "#a5b4fc",
        "#242536",
        "#221f36",
    },
    yellow = {
        "#713f12",
        "#fed7aa",
    },
    green = {
        "#173626",
        "#81ffbb",
    },
    magenta = {
        "#291A2E",
        "#e879f9",
    },
    cyan = {
        "#97CCF1",
    },
    navy = {
        "#678CB1",
    },
    grey = {
        white,
        "#f5f5f5",
        "#d5d5d5",
        "#b4b4b4",
        "#a7a7a7",
        dimmed_white, -- 5
        "#737373",
        "#545454",
        "#434343",
        "#323232",
        "#212121",
    },
}

local bg_shade = preset.shade
local background = preset.bg

local bg_accent_light = "#1a1a1a"
local foreground = "#ffcfa7"
local debug = "#ff0000"

local diagnostic = {
    error = palette.red[2],
    warn = palette.yellow[2],
    info = palette.blue[2],
    hint = dimmed_white,
}

local M = {
    -- noirbuddy related.
    primary = foreground,
    diagnostic = diagnostic,

    cyan = palette.cyan[1],
    white = "#ffffff",
    navy = palette.navy[1],
    dimmed_white = dimmed_white,
    debug = debug,
    foreground = foreground,
    background = background,
    bg = background,
    bg_shade = bg_shade,
    bg_accent = "#1f2425",
    bg_accent_light = bg_accent_light,
    palette = palette,
    misc = {
        bool = "#eeb684",
        number = "#ffd6b3",
        remove_fg = palette.red[2],
        remove = palette.red[1],
        add_fg = palette.green[2],
        add = palette.green[1],
        change = palette.indigo[5],
        change_fg = palette.indigo[3],
        visual = palette.indigo[4],
    },
}

return M
