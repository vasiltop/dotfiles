vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.nu = true
vim.opt.relativenumber = true

-- scroll
vim.opt.scrolloff = 8

-- clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- command line
vim.api.nvim_set_keymap("n", ":", "q:i", { noremap = true, silent = true })

-- explorer
vim.api.nvim_set_keymap("n", "<Space>e", ":Ex<CR>", { noremap = true, silent = true })

-- splits
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-f>', ':tab split<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space>h', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>v', ':vsplit<CR>', { noremap = true, silent = true })

vim.diagnostic.config({
	virtual_text = true,
})
