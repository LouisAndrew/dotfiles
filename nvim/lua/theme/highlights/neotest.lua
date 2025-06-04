local colors = require("minimal_fedu")

return {
	prefix = "Neotest",
	{ "Failed", "Removed", link = true },
	{ "Passed", "Added", link = true },
	{ "Running", "Changed", link = true },
	{ "Skipped", "Comment", link = true },
	{ "AdapterName", colors.white },
	{ "Dir", colors.palette.grey[7] },
	{ "File", colors.palette.grey[5] },
	{ "Namespace", colors.white },
	{ "Focused", "AdapterName", link = true },
	{ "ExpandMarker", "NeotestIndent", link = true },
}
