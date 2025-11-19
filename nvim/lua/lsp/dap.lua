-- https://github.com/nikolovlazar/dotfiles/blob/main/.config/nvim/lua/plugins/dap.lua
local dap = require("dap")

if not dap.adapters["pwa-node"] then
	require("dap").adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "node",
			args = {
				vim.env.MASON .. "/packages/" .. "js-debug-adapter" .. "/js-debug/src/dapDebugServer.js",
				"${port}",
			},
		},
	}
end

if not dap.adapters["node"] then
	dap.adapters["node"] = function(cb, config)
		if config.type == "node" then
			config.type = "pwa-node"
		end
		local nativeAdapter = dap.adapters["pwa-node"]
		if type(nativeAdapter) == "function" then
			nativeAdapter(cb, config)
		else
			cb(nativeAdapter)
		end
	end
end

local js_filetypes = { "typescript", "javascript", "typescriptreact", "vue", "astro" }
local vscode = require("dap.ext.vscode")
vscode.type_to_filetypes["node"] = js_filetypes
vscode.type_to_filetypes["pwa-node"] = js_filetypes

for _, language in ipairs(js_filetypes) do
	if not dap.configurations[language] then
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file (JS)",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				name = "Launch file (TS)",
				type = "pwa-node",
				request = "launch",
				program = "${workspaceFolder}/node_modules/tsx/dist/cli.mjs",
				args = {
					"${file}",
				},
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**" },
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to running process",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-chrome",
				request = "launch",
				name = "Launch & Debug Chrome",
				url = function()
					local co = coroutine.running()
					return coroutine.create(function()
						vim.ui.input({
							prompt = "Enter URL: ",
							default = "http://localhost:3000",
						}, function(url)
							if url == nil or url == "" then
								return
							else
								coroutine.resume(co, url)
							end
						end)
					end)
				end,
				webRoot = vim.fn.getcwd(),
				protocol = "inspector",
				sourceMaps = true,
				userDataDir = false,
			},
			{
				name = "Debug Node npm run start",
				type = "pwa-node",
				request = "launch",
				program = "/Users/louis.andrew/.nvm/versions/node/v20.10.0/bin/npm",
				args = {
					"run-script",
					"start",
					"--",
					"--inspect-brk=9229",
				},
				port = 9229,
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**" },
				protocol = "inspector",
				console = "integratedTerminal",
			},
		}
	end
end

local dapui = require("dapui")

local icons = require("theme.icons")
dapui.setup({
	icons = {
		collapsed = icons.ArrowOpened,
		current_frame = icons.ArrowOpened,
		expanded = icons.ArrowClosed,
	},
})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close
