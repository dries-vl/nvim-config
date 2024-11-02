-- Set the background to light
vim.o.background = "light"

-- Clear existing highlights and reset syntax
vim.cmd("highlight clear")
vim.cmd("syntax reset")

-- Custom todo highlight
vim.api.nvim_set_hl(0, "@comment.todo", { fg = "#FF0000", bold = true })
-- Make sure floating windows follow the same style
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#FFFFFF', fg = '#000000' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#FFFFFF', fg = '#000000' })
-- Lsp error/warning/info highlights
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { bg = "#000000" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { bg = "#000000" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { bg = "#000000" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { bg = "#000000" })

-- Execute the two language-specific color schemes
dofile(vim.fn.stdpath('config') .. '/colors/rust.lua')
dofile(vim.fn.stdpath('config') .. '/colors/c.lua')
dofile(vim.fn.stdpath('config') .. '/colors/lua.lua')

-- Command to see the treesitter highlight group of something under the cursor
-- Inspect (actually just better than the below)
-- lua print(vim.inspect(vim.treesitter.get_captures_at_cursor(0)))

--[[
		All possible values to add
		fg: color name or "#RRGGBB", see note.
		bg: color name or "#RRGGBB", see note.
		sp: color name or "#RRGGBB"
		blend: integer between 0 and 100
		bold: boolean
		standout: boolean
		underline: boolean
		undercurl: boolean
		underdouble: boolean
		underdotted: boolean
		underdashed: boolean
		strikethrough: boolean
		italic: boolean
		reverse: boolean
		nocombine: boolean
		link: name of another highlight group to link to, see :hi-link.
		default: Don't override existing definition :hi-default
		ctermfg: Sets foreground of cterm color ctermfg
		ctermbg: Sets background of cterm color ctermbg
		cterm: cterm attribute map, like highlight-args. If not set, cterm attributes will match those from the attribute map documented above.
		force: if true force update the highlight group when it exists. 
--]]
