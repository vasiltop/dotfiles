-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- leader key
vim.g.mapleader = " "

-- autochdir
-- vim.o.autochdir = true

-- clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- wrap
-- vim.opt.wrap = false

-- backups
vim.opt.swapfile = false
vim.opt.backup = false

-- searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- colors
vim.opt.termguicolors = true

-- scrolling
vim.opt.scrolloff = 8

-- command line
vim.api.nvim_set_keymap("n", ":", "q:i", { noremap = true, silent = true })

-- explorer
vim.api.nvim_set_keymap("n", "<Space>e", ":Ex<CR>", { noremap = true, silent = true })

-- splits
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space>h', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>v', ':vsplit<CR>', { noremap = true, silent = true })

-- compile mode
vim.api.nvim_create_user_command('Output', function(opts)
    local cmd = opts.args
    if cmd == "" then
			return
    end
    
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_command("vsplit")
    vim.api.nvim_command("buffer " .. buf)
    
    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
            end
        end,
        on_exit = function()
            vim.api.nvim_buf_set_option(buf, "modifiable", true)
        end
    })
end, {nargs = '*'})

vim.api.nvim_set_keymap('n', '<Space>c', [[q:OOutput ]], { noremap = true, silent = true })

-- setup lazy.nvim
require("lazy").setup({
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.moonflyTransparent = true
			vim.cmd("colorscheme moonfly")
		end,
	},
	{ 
		'nvim-treesitter/nvim-treesitter',
		opts = {
			auto_install = true,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function(_, _)
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', function()

				local git_root = require('telescope.utils').buffer_dir()
				if vim.fn.executable('git') == 1 then
					git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
					if vim.v.shell_error ~= 0 then
						git_root = require('telescope.utils').buffer_dir()
					end
				end

				require('telescope.builtin').find_files({
					cwd = git_root,
					prompt_title = 'Find Files (Git Root)',
					hidden = false,
				})
			end, { desc = 'Find files from Git root' })

			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

			local function find_and_cd(dir, opts)
				opts = opts or {}
				local depth = opts.depth or 1
				local title = opts.title or 'Directories (' .. depth .. ' level' .. (depth == 1 and '' or 's') .. ')'

				require('telescope.builtin').find_files({
					cwd = dir,
					find_command = {
						'fdfind',
						'--type', 'd',
						'--no-ignore',
						'--hidden',
						'--max-depth', tostring(depth),
						'--strip-cwd-prefix'
					},
					prompt_title = title,
					attach_mappings = function(_, map)
						map('i', '<CR>', function(prompt_bufnr)
							local entry = require('telescope.actions.state').get_selected_entry()
							require('telescope.actions').close(prompt_bufnr)
							vim.cmd('cd ' .. vim.fn.fnameescape(entry.path))
							vim.cmd('Ex')
						end)

						map('n', '<CR>', function(prompt_bufnr)
							local entry = require('telescope.actions.state').get_selected_entry()
							require('telescope.actions').close(prompt_bufnr)
							vim.cmd('cd ' .. vim.fn.fnameescape(entry.path))
							vim.cmd('Ex')
						end)

						return true
					end
				})
			end

			-- Original keymap using the generic function
			vim.keymap.set('n', '<leader>fp', function()
				find_and_cd(vim.fn.expand('~/projects'), {
					title = 'Project Directories (1 level)'
				})
			end, { desc = 'Find and cd into project directories' })

			-- Example of another keymap using the same function
			vim.keymap.set('n', '<leader>fc', function()
				find_and_cd(vim.fn.expand('~/.config'), {
					depth = 2,
					title = 'Config Directories'
				})
			end, { desc = 'Find and cd into config directories' })
		end
	}
})
