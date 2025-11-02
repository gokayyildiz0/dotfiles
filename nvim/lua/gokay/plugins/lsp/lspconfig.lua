config = function()
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local keymap = vim.keymap

	-- 󰘚 Attach keymaps when an LSP connects
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local opts = { buffer = ev.buf, silent = true }

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "Code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Rename symbol"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Prev diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Hover docs"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end,
	})

	-- 󰘚 Autocompletion capabilities
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- 󰘚 Diagnostic signs (new API-friendly)
	local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- 󰘚 Define special per-server options
	local server_settings = {
		svelte = {
			on_attach = function(client)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		},
		graphql = {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		},
		emmet_ls = {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		},
		lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT", special = { love = "require" } },
					diagnostics = { globals = { "vim", "love" } },
					workspace = {
						library = {
							vim.fn.expand("$HOME/.local/share/love-api"),
							vim.fn.expand("$VIMRUNTIME/lua"),
							vim.fn.stdpath("config") .. "/lua",
						},
						checkThirdParty = false,
						maxPreload = 100000,
						preloadFileSize = 100000,
					},
					completion = { callSnippet = "Replace" },
					telemetry = { enable = false },
				},
			},
		},
		tailwindcss = {
			filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro" },
		},
	}

	-- 󰘚 Loop over all installed servers
	for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
		local opts = {
			capabilities = capabilities,
		}

		-- merge custom settings if present
		if server_settings[server_name] then
			for k, v in pairs(server_settings[server_name]) do
				opts[k] = v
			end
		end

		lspconfig[server_name].setup(opts)
	end
end
