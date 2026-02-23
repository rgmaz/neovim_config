return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		require("mason-nvim-dap").setup({
			ensure_installed = { "delve", "python", "js" },
			automatic_installation = true,
		})

		local mason_path = vim.fn.stdpath("data") .. "/mason/packages"

		require("dap-go").setup()

		require("dap-python").setup(mason_path .. "/debugpy/venv/bin/python")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					mason_path .. "/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}
		end

		local keymap = vim.keymap.set

		keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		keymap("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Conditional Breakpoint" })

		keymap("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		keymap("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		keymap("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		keymap("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
		keymap("n", "<leader>dt", dapui.toggle, { desc = "Toggle Debug UI" })
	end,
}
