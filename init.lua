-- basic settings
vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.swapfile = false

-- leader
vim.g.mapleader = " "

-- theme
vim.pack.add({{ src = "https://github.com/sainnhe/everforest" }})
vim.cmd("colorscheme everforest")

-- transparency
vim.pack.add({{ src = "https://github.com/xiyaowong/transparent.nvim" }})

require("transparent").setup({
  extra_groups = {
    "NormalFloat",     -- Floating window background
    "FloatBorder",     -- Floating window border
    "FloatTitle",      -- Floating window title (if any)
  },
})

vim.g.transparent_enabled = true

-- status bar
vim.pack.add({{ src = "https://github.com/nvim-lualine/lualine.nvim" }})
vim.pack.add({{ src = "https://github.com/nvim-tree/nvim-web-devicons" }})
require('lualine').setup({
	options = {
		theme = 'everforest'
	}
})

-- autopairs
vim.pack.add({{ src ="https://github.com/windwp/nvim-autopairs" }})
require('nvim-autopairs').setup({
	event = "InsertEnter",
	config = true,
})

-- terminal
vim.pack.add({{ src = "https://github.com/akinsho/toggleterm.nvim"}})
require('toggleterm').setup({
	open_mapping = "<C-k>",
	direction= 'float',
	float_opts = {
		border = 'curved',
	}
})

-- file grep 
vim.pack.add({{ src = "https://github.com/nvim-lua/plenary.nvim"}})
vim.pack.add({{ src = "https://github.com/nvim-telescope/telescope.nvim"}})
local telescope_builtin = require('telescope.builtin')
vim.keymap.set({'n','i','v','t'}, '<C-p>', telescope_builtin.find_files)
vim.keymap.set({'n','i','v','t'}, '<C-l>', telescope_builtin.live_grep)

-- file explorer
vim.pack.add({{ src = "https://github.com/mikavilpas/yazi.nvim" }})
require("yazi").setup({
  yazi_floating_window_winblend = 0,
  floating_window_scaling_factor = 0.8, -- Default is 0.9, makes window 90% of screen
})
vim.keymap.set("n", "<C-y>", function()
	require("yazi").yazi()
end)

-- lsp
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig"},
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim"},
	{ src = "https://github.com/mason-org/mason.nvim"}
})
require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true
})

vim.lsp.enable('lua-language-server')
