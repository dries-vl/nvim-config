vim.g.mapleader = 't'
vim.g.maplocalleader = 't'
vim.keymap.set('n', 'e', '5k')
vim.keymap.set('v', 'e', '5k')
vim.keymap.set('n', 'n', '5j')
vim.keymap.set('v', 'n', '5j')
--vim.keymap.set('n', ';', 'n')
--vim.keymap.set('v', ';', 'n')
vim.keymap.set('n', '<C-m>', ':bprevious<CR>')
vim.keymap.set('n', '<C-i>', ':bNext<CR>')
vim.keymap.set('n', '<C-a>', 'ggVG') -- allow ctrl+a to select the entire file
vim.keymap.set('n', '<M-c>', ':e $MYVIMRC<CR>') --set shortcut to go to this config quickly
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true }) -- ensure correct goto definition behavior
vim.api.nvim_set_option('clipboard', 'unnamed') -- configure clipboard to be able to use system clipboard
--vim.keymap.set('n', 'y', '"+y') -- make yank copy to system cliboard (wsl)
--vim.keymap.set('n', 'p', '"+p') -- make paste also paste the system clipboard (wsl)
vim.api.nvim_set_keymap('i', '<C-n>', '<C-x><C-o>', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':!RUN.bat<CR>', { noremap = true, silent = false })
vim.o.wrap = false
vim.opt.foldenable = false
vim.o.number = false
vim.o.relativenumber = false
vim.opt.cmdheight = 0 -- put status bar at bottom instead of at offset
vim.o.signcolumn = 'no' -- remove the gutter
vim.o.foldcolumn = '0' -- remove the gutter
vim.diagnostic.config {signs = false} -- remove the gutter
vim.opt.laststatus = 0 -- remove the status line entirely from all windows (!)
vim.o.tabstop = 4           -- number of visual spaces per TAB
vim.o.shiftwidth = 4        -- number of spaces to use for each step of (auto)indent
vim.opt.shadafile = 'NONE' -- don't write a shada file (contains the registers/buffers of the prev. session, but issues!)
vim.opt.formatoptions:remove('o') -- don't start a new comment when entering new line from comment

if vim.g.neovide then
	vim.g.neovide_cursor_trail_size = 1.0
	vim.g.neovide_fullscreen = true
	vim.opt.guifont = 'JetBrains Mono:h12' -- set font size in neovide, use terminal font size otherwise
end

vim.opt.updatetime = 250 -- decrease reaction time
vim.opt.timeoutlen = 250 -- this makes the which-key window pop up sooner
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.api.nvim_create_autocmd('TextYankPost', { -- Highlight when yanking (copying) text
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- NOTIFICATION SETUP
-- local notify = require('notification')
-- notify.show_notification("Hello, Neovim!")

-- LAYOUT SETUP
require('navigate')

-- LAYOUT SETUP
require('zen')

-- LSP SETUP
require('lsp-setup')

-- TREESITTER SETUP
require('treesitter-setup')

-- COLOR SCHEME (load at the end, to avoid overriding it)
vim.cmd 'colorscheme naysayer'
