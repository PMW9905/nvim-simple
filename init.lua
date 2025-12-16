-- basic settings
vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.swapfile = false

-- Fix line endings for WSL/Windows
vim.o.fileformats = "unix,dos"

vim.o.winborder = 'rounded'

-- leader
vim.g.mapleader = " "

-- ctrl+C is esc
vim.keymap.set({ 'n', 'i', 'v'}, '<C-c>', '<ESC>')

-- init.lua
vim.opt.fileformats = "dos,unix"  -- Prefer DOS (CRLF) format on Windows
vim.opt.fileformat = "dos"        -- Default to DOS format for new files

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

-- markdown viewer
vim.pack.add({ { src = "https://github.com/OXY2DEV/markview.nvim" } })

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

-- lazygit
vim.pack.add({ { src = "https://github.com/kdheepak/lazygit.nvim" } })
vim.keymap.set({ 'n', 'i', 'v', 't' }, '<C-j>', '<CMD>LazyGit<CR>')

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
		'lua', 'yaml', 'markdown'
	},
	auto_install = true
})

-- lsp
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" }
})

local enabled_language_servers = { 'lua_ls', 'yamlls', 'eslint', 'ts_ls', 'html', 'cssls' }

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = enabled_language_servers,
})

-- Setup conform for formatting with Prettier
vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
})

-- Setup nvim-lint for linting with ESLint
vim.pack.add({ { src = "https://github.com/mfussenegger/nvim-lint" } })
require("lint").linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	javascriptreact = { "eslint" },
	typescriptreact = { "eslint" },
}

-- Auto-lint on save and on text change
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

vim.keymap.set("n", '<leader>fm', function() require("conform").format({ lsp_fallback = true }) end)
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
		['<Tab>'] = { "select_and_accept", "fallback" },
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},

	sources = { default = { "lsp", "buffer" } }
})
