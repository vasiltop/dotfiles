return {
		{ 
		'nvim-treesitter/nvim-treesitter',
		opts = {
			auto_install = true,
			ensure_installed = { "rust", "gdscript", "typescript", "html" },
			sync_install = false,
			auto_install = true,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
