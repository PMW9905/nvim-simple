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
vim.keymap.set("n", "<C-y>", function()
  require("yazi").yazi()
end)
