require("plugin")
require("coc")

vim.g.coc_snippet_prev = "<c-s-k>"
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#whitespace#enabled'] = 0
vim.g.airline_theme  = 'catppuccin'
vim.g.airline_powerline_fonts  = 1
vim.g.go_def_mapping_enabled =0
vim.g.go_gopls_enabled =1

vim.g.vimtex_view_method  = 'zathura'
vim.g.vimtex_compiler_method  = 'latexmk'
vim.g.vimtex_quickfix_enabled  = 0
vim.g.maplocalleader = ","

vim.o.errorbells = false
vim.o.title = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.ruler = true
vim.o.wrap = true
vim.o.scrolloff = 3
vim.o.clipboard = "unnamedplus"
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon0"
vim.o.foldenable = false
vim.o.updatetime = 300
vim.o.shortmess = "filnxtToOFc"
vim.o.mouse = "ar"

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 0

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

require("catppuccin").setup {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	term_colors = true,
	transparent_background = true,
	no_italic = false,
	no_bold = false,
	styles = {
		comments = { "italic" },
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
	},
	color_overrides = {
		mocha = {
			base = "#000000",
			mantle = "#222222",
		},
	},
	integrations = {
		coc_nvim = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "undercurl" },
				hints = { "italic" },
				warnings = { "undercurl" },
				information = { "italic" },
			},
			underlines = {
				errors = { "undercurl" },
				hints = { "underline" },
				warnings = { "undercurl" },
				information = { "underline" },
			},
		},
	},
	highlight_overrides = {
		mocha = function(C)
		return {
			Comment = { fg = C.sky },
			TabLineSel = { bg = C.pink },
			CmpBorder = { fg = C.surface2 },
			Pmenu = { bg = C.none },
			TelescopeBorder = { link = "FloatBorder" },
		}
		end,
	},
}

vim.o.background = "dark"
vim.o.termguicolors = true
vim.cmd.colorscheme("catppuccin-mocha")

require'telescope'.setup {
	defaults = {
		initial_mode = "normal"
	}
}

require'nvim-treesitter.configs'.setup {
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
}

vim.g.coc_snippet_next = "<c-s-j>"
vim.g.coc_snippet_prev = "<c-s-k>"

vim.keymap.set('n', ';', ':')

vim.g.mapleader = ','
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
