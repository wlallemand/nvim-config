-- Install plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
	"https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- Neovide configuration
vim.o.guifont = "Dejavu Sans Mono:h7:#e-subpixelantialias"
vim.g.neovide_scale_factor = 0.5
vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_size = 0

-- Core settings
vim.g.mapleader = ","
vim.o.number = true
vim.o.mouse = "a"
vim.o.mousemodel = "extend"
vim.o.shortmess = "c"
vim.o.concealcursor = ""
vim.o.textwidth = 120

vim.o.listchars = "tab:»·,trail:·"
vim.o.list = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.laststatus = 3
vim.g.rustfmt_autosave = false
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱]]
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.colorcolumn = "120"
vim.o.cursorline = true
vim.o.showmatch = true
vim.o.winblend = 0
vim.o.pumblend = 0
vim.o.scrolloff = 10
vim.o.fixendofline = true
vim.o.clipboard = "unnamed"

-- spaces, tabs, indent
vim.o.smarttab = true
vim.o.expandtab = false
vim.o.softtabstop = 8
vim.o.tabstop = 8
vim.o.shiftwidth = 8
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.wrap = true
vim.opt.formatoptions:remove('t')

-- lazy plugins
local plugins = {
	{ "catppuccin/nvim", priority = 1000 },
	{ "nvim-treesitter/nvim-treesitter", name = "treesitter" },
	{ 'nvim-treesitter/nvim-treesitter-textobjects' }, -- Additional textobjects for treesitter
	{ "nvim-lua/plenary.nvim" },
	{ "sindrets/diffview.nvim" },
	{ "NeogitOrg/neogit", tag = 'v1.0.0', config = true },
	{ "lewis6991/gitsigns.nvim", config = true },
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', config = true },

	{ 'p00f/clangd_extensions.nvim', config = true },
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{ 'hrsh7th/cmp-nvim-lsp'},
	{ 'hrsh7th/nvim-cmp'},
	{ 'L3MON4D3/LuaSnip'},

	{ "MysticalDevil/inlay-hints.nvim", config = true },
	{ "kwkarlwang/bufresize.nvim", config = true }, -- resize the split when resizing the terminal

}
require("lazy").setup(plugins, opts)

-- Treesitter setup
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "c", "cpp", "python", "rust" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

-- theme
vim.cmd.colorscheme "catppuccin"

-- trailing whitespace hilighting
vim.cmd.syn "on"
vim.g.show_whitespace = 1
if vim.g.show_whitespace then
  local ag = vim.api.nvim_create_augroup('show_whitespace', { clear = true })
  vim.api.nvim_create_autocmd('Syntax', {
    pattern = '*',
    command = [[syntax match TrailingWS /\v\s\ze\s*$/ containedin=ALL]],
    group = ag,
  })
  vim.cmd [[highlight TrailingWS ctermbg=203 ctermfg=203 guibg=IndianRed1 guifg=IndianRed1]]
end

-- completion
vim.o.completeopt = "menu,menuone,noinsert"

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- neovide
if vim.g.neovide == true then
	local function set_scale(scale)
		vim.g.neovide_scale_factor = scale
		-- Force redraw, otherwise the scale change won't be rendered until the next UI update
		vim.cmd.redraw { bang = true }
	end
	vim.keymap.set("n", "<C-=>", function() set_scale(vim.g.neovide_scale_factor + 0.1) end)
	vim.keymap.set("n", "<C-->", function() set_scale(vim.g.neovide_scale_factor - 0.1) end)
	vim.keymap.set("n", "<C-0>", function() set_scale(.5) end)
end


vim.lsp.config.clangd = {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
}

vim.lsp.enable({'clangd'})
