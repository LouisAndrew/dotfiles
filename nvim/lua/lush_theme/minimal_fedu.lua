local lush = require("lush")

local highlight_modules = {
	"theme.highlights.editor",
	"theme.highlights.treesitter",
	"theme.highlights.diagnostics",
	"theme.highlights.git",
	"theme.highlights.markdown",
	"theme.highlights.blink",
	"theme.highlights.noice",
	"theme.highlights.snacks",
	"theme.highlights.mason",
	"theme.highlights.neotest",
	"theme.highlights.ai",
	"theme.highlights.others",
}

local specs = {}
for _, module_name in ipairs(highlight_modules) do
	package.loaded[module_name] = nil
	specs[#specs + 1] = require(module_name)
end

return lush.merge(specs)
