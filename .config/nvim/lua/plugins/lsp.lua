return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
      "nvim-telescope/telescope.nvim",
    },
		config = function()
			require("lspconfig").rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            diagnostics = { enable = false }
          }
        }
      })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
				end,
				})

				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				local lspconfig = require('lspconfig')
				lspconfig.gdscript.setup(capabilities)
				lspconfig.volar.setup {}
				lspconfig.ts_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = "/home/vasil/.local/share/pnpm/global/5/.pnpm/@vue+language-server@3.0.1_typescript@5.8.3/node_modules/@vue/language-server",
								languages = { "vue" },
							},
						},
					},
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				})
				lspconfig.html.setup({})
		end,
		opts = {
			servers = {
				rust_analyzer = { enabled = false },
				ts_ls = {},
				html = {
					autoClosingTags = true,
					filetypes = {
						'html'
					}
				},
			},
		},
	}
}
