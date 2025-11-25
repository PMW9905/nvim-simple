-- basic settings
vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.swapfile = false

vim.o.winborder = 'rounded'

-- leader
vim.g.mapleader = " "

-- theme
vim.pack.add({ { src = "https://github.com/sainnhe/everforest" } })
vim.cmd("colorscheme everforest")

-- transparency
vim.pack.add({ { src = "https://github.com/xiyaowong/transparent.nvim" } })

require("transparent").setup({
	extra_groups = {
		"NormalFloat", -- Floating window background
		"FloatBorder", -- Floating window border
		"FloatTitle", -- Floating window title (if any)
	},
})

vim.g.transparent_enabled = true

-- status bar
vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })
vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-web-devicons" } })
require('lualine').setup({
	options = {
		theme = 'everforest'
	}
})

-- autopairs
vim.pack.add({ { src = "https://github.com/windwp/nvim-autopairs" } })
require('nvim-autopairs').setup({
	event = "InsertEnter",
	config = true,
})

-- terminal
vim.pack.add({ { src = "https://github.com/akinsho/toggleterm.nvim" } })
require('toggleterm').setup({
	open_mapping = "<C-k>",
	direction = 'float',
	float_opts = {
		border = 'curved',
	}
})

-- file grep
vim.pack.add({ { src = "https://github.com/nvim-lua/plenary.nvim" } })
vim.pack.add({ { src = "https://github.com/nvim-telescope/telescope.nvim" } })
vim.pack.add({ { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' } })

require("telescope").load_extension("ui-select")

local telescope_builtin = require('telescope.builtin')
vim.keymap.set({ 'n', 'i', 'v', 't' }, '<C-p>', telescope_builtin.find_files)
vim.keymap.set({ 'n', 'i', 'v', 't' }, '<C-l>', telescope_builtin.live_grep)

-- file explorer
vim.pack.add({ { src = "https://github.com/mikavilpas/yazi.nvim" } })
require("yazi").setup({
	yazi_floating_window_winblend = 0,
	floating_window_scaling_factor = 0.8,
})
vim.keymap.set("n", "<C-y>", function()
	require("yazi").yazi()
end)

-- syntax highlighting
vim.pack.add({
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' }
})
require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'lua', 'gdscript', 'godot_resource', 'gdshader', 'yaml'
	},
	auto_install = true
})

-- lsp
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" }
})

local enabled_language_servers = { 'lua_ls', 'yamlls'}

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = enabled_language_servers,
})

vim.keymap.set("n", '<leader>fm', vim.lsp.buf.format)
vim.keymap.set("n", '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set("n", '<leader>hd', vim.lsp.buf.hover)
vim.keymap.set("n", '<leader>df', vim.lsp.buf.definition)
vim.keymap.set("n", '<leader>dc', vim.lsp.buf.declaration)
vim.keymap.set("n", '<leader>x', vim.diagnostic.open_float)

for _, language_server in ipairs(enabled_language_servers) do
	vim.lsp.enable(language_server)
end

-- completions
vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*"), }
})

require("blink.cmp").setup({
	fuzzy = { implementation = "lua" },
	signature = { enabled = true },
	keymap = {
		preset = "default",
		['<CR>'] = {},
		['<Tab>'] = { "select_and_accept" },
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},
	completion = {
		auto_show = true,
		auto_show_delay_ms = 200,
	},

	sources = { default = { "lsp" } }
})
