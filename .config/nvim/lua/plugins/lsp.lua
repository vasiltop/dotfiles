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
				end,
				})
		end,
		opts = {
			servers = {
				rust_analyzer = { enabled = false },
			},
		},
	}
}
