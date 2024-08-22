-- Vim Stuff
vim.wo.number = true
vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4

require('plugins')

-- Colorscheme
local ok, _ = pcall(vim.cmd, 'colorscheme oak')
if not ok then
	vim.cmd 'colorscheme default'
end

-- Treesitter
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

-- Nvim-Prose
local prose = require 'nvim-prose'
require 'lualine'.setup {
	sections = {
		lualine_x = {
			{ prose.word_count, cond = prose.is_available },
			{ prose.reading_time, cond = prose.is_available },
		},
	},
}
--require('nvim-prose').setup {
--	wpm = 140.0,
--	filetypes = { 'markdown', 'asciidoc' },
--	placeholders = {
--		words = 'words',
--		minutes = 'min'
--	}
--}
