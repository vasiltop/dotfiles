-- leader key
vim.g.mapleader = " "

-- clipboard
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-- tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- command line
vim.api.nvim_set_keymap('n', ':', 'q:i', { noremap = true, silent = true })

-- packer
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- color scheme
  use({ 'kepano/flexoki-neovim', as = 'flexoki' })
	vim.cmd('colorscheme flexoki-dark')

	-- fuzzy finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

end)

