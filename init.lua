vim.g.mapleader = 't'
vim.g.maplocalleader = 't'
vim.o.scrolloff = 5
vim.opt.path:append("**") -- allow :find to be a fuzzy finder, :b can also fuzzy find for buffers out of the box
vim.g.netrw_liststyle = 3  -- tree view for :Ex or :edit .
-- ctags -> vim automatically reads -> ctrl-] jumps to def, ctrl-n autocompletes names
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
--vim.api.nvim_set_keymap('i', '<C-n>', '<C-x><C-o>', { noremap = false, silent = true })
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
vim.api.nvim_create_autocmd("FileType", { pattern = "*", command = "setlocal formatoptions-=cro" })

if vim.g.neovide then
	vim.g.neovide_cursor_trail_size = 1.0
	vim.g.neovide_fullscreen = true
	vim.opt.guifont = 'JetBrains Mono:h12' -- set font size in neovide, use terminal font size otherwise
end

-- find and replace in file
vim.keymap.set('v', '<leader>r', function()
  -- Yank the selection to the " register
  vim.cmd('normal! ""y')
  local selection = vim.fn.getreg('"')
  -- Ask for the replacement
  local replacement = vim.fn.input('Replace with: ')
  -- Escape special characters for Vim patterns and replacement
  selection = vim.fn.escape(selection, '\\/.*$^~[]')
  replacement = vim.fn.escape(replacement, '\\/')
  -- Do the substitution in the whole file, case-insensitive
  vim.cmd(string.format('%%s/%s/%s/gI', selection, replacement))
end, { noremap = true, silent = false })

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

