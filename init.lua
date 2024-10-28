vim.g.mapleader = 't'
vim.g.maplocalleader = 't'
vim.keymap.set('n', 'e', '5k')
vim.keymap.set('v', 'e', '5k')
vim.keymap.set('n', 'n', '5j')
vim.keymap.set('v', 'n', '5j')
vim.keymap.set('n', ';', 'n')
vim.keymap.set('v', ';', 'n')
vim.keymap.set('n', '<C-a>', 'ggVG') -- allow ctrl+a to select the entire file
vim.keymap.set('n', '<M-c>', ':e $MYVIMRC<CR>') --set shortcut to go to this config quickly
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true }) -- ensure correct goto definition behavior
vim.api.nvim_set_option('clipboard', 'unnamed')
vim.keymap.set('n', 'y', '"+y') -- make yank copy to system cliboard
vim.keymap.set('n', 'p', '"+p') -- make paste also paste the system clipboard
vim.api.nvim_set_keymap('i', '<C-n>', '<C-x><C-o>', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':! RUN.bat<CR>', { noremap = true, silent = false })
vim.o.wrap = false
vim.opt.guifont = 'Consolas:h12' -- only works for setting font size in neovide, in terminal the terminal font size is always used
vim.opt.foldenable = false
vim.o.number = false
vim.o.relativenumber = false
vim.opt.cmdheight = 0 -- put status bar at bottom instead of at offset
vim.o.signcolumn = 'no' -- remove the gutter
vim.o.foldcolumn = '0' -- remove the gutter
vim.diagnostic.config {signs = false} -- remove the gutter

require('zen')

local notify = require('notification')
notify.show_notification("Hello, Neovim!")

-- vim.g.neovide_transparency = 0.9
-- vim.g.neovide_fullscreen = true

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

-- LSP SETUP (in lua/lsp.lua)
require('lsp')

-- TREESITTER SETUP (in lua/treesitter.lua)
require('treesitter')

-- COLOR SCHEME (in colors/rust_rover.lua) (load at the end, to avoid overriding it)
vim.cmd 'colorscheme dvl-colors'





