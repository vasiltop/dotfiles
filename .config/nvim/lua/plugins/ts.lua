return {
		{ 
		'nvim-treesitter/nvim-treesitter',
		opts = {
			auto_install = true,
			ensure_installed = { "rust" },
			sync_install = false,
			auto_install = true,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
