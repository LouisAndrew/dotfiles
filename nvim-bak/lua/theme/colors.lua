local Color = require("colorbuddy").Color
local minimal_fedu = require("minimal_fedu")

Color.new("nb_background", minimal_fedu.background)
Color.new("primary", minimal_fedu.foreground)
Color.new("secondary", minimal_fedu.white)

Color.new("diagnostic_error", minimal_fedu.diagnostic.error)
Color.new("diagnostic_warning", minimal_fedu.diagnostic.warn)
Color.new("diagnostic_info", minimal_fedu.diagnostic.info)
Color.new("diagnostic_hint", minimal_fedu.diagnostic.hint)

Color.new("mfed_0", minimal_fedu.palette.grey[1])
Color.new("mfed_1", minimal_fedu.palette.grey[2])
Color.new("mfed_2", minimal_fedu.palette.grey[3])
Color.new("mfed_3", minimal_fedu.palette.grey[4])
Color.new("mfed_4", minimal_fedu.palette.grey[5])
Color.new("mfed_5", minimal_fedu.palette.navy[1])
Color.new("mfed_6", minimal_fedu.palette.grey[7])
Color.new("mfed_7", minimal_fedu.palette.grey[8])
Color.new("mfed_8", minimal_fedu.palette.grey[9])
Color.new("mfed_9", minimal_fedu.palette.grey[10])

Color.new("mfed_cyan", minimal_fedu.cyan)
Color.new("mfed_navy", minimal_fedu.navy)
Color.new("mfed_dim", minimal_fedu.dimmed_white)
Color.new("mfed_bool", minimal_fedu.misc.bool)
Color.new("mfed_num", minimal_fedu.misc.number)
Color.new("debug", minimal_fedu.debug)
Color.new("mfed_bg_accent", minimal_fedu.bg_accent)
Color.new("mfed_bg_accent_light", minimal_fedu.bg_accent_light)
Color.new("dimmed_white", minimal_fedu.dimmed_white)
Color.new("bg_shade", minimal_fedu.bg_shade)

Color.new("add", minimal_fedu.misc.add)
Color.new("remove", minimal_fedu.misc.remove)
Color.new("change", minimal_fedu.misc.change)
Color.new("remove_fg", minimal_fedu.misc.remove_fg)
Color.new("add_fg", minimal_fedu.misc.add_fg)

Color.new("yellow_fg", minimal_fedu.palette.yellow[2])
Color.new("yellow", minimal_fedu.palette.yellow[1])

Color.new("indigo_fg", minimal_fedu.palette.indigo[2])
Color.new("indigo_fg_light", minimal_fedu.palette.indigo[3])
Color.new("indigo", minimal_fedu.palette.indigo[1])

Color.new("blue_fg", minimal_fedu.palette.blue[2])
Color.new("blue", minimal_fedu.palette.blue[1])

Color.new("magenta", minimal_fedu.palette.magenta[1])
Color.new("magenta_fg", minimal_fedu.palette.magenta[2])
Color.new("visual", minimal_fedu.misc.visual)
