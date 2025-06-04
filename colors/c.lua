-- Clear existing highlights and reset syntax
vim.cmd("highlight clear")
vim.cmd("syntax reset")

-- Custom todo highlight
vim.api.nvim_set_hl(0, "@todo", { fg = "#FF0000", bold = true })
vim.api.nvim_set_hl(0, "@comment.info", { fg = "#00FFFF", bold = true })
vim.api.nvim_set_hl(0, "@comment-asterisk", { fg = "#FFFFFF", bg = "#002080", bold = true })
vim.api.nvim_set_hl(0, "@comment-minus", { fg = "#888822", bold = true })
-- Make sure floating windows follow the same style
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#FFFFFF', fg = '#000000' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#FFFFFF', fg = '#000000' })
-- Lsp error/warning/info highlights
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#745454", bg = "#e5d2d2", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#FF9999" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#747454", bg = "#e5e5d2", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#FFD1A6" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#545474", bg = "#d2d2e5", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#99CCFF" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#548484", bg = "#d2e9e9", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#CCE5FF" })

local hl = vim.api.nvim_set_hl
hl(0, "Normal", { bg = "#0050a0", fg = "#ffffff" })
hl(0, "@comment.c", { fg = "#20d020" })
hl(0, "@constant.c", { fg = "#ffffff", bold = true })
hl(0, "@variable.c", { fg = "#ffffff" })
hl(0, "@function.body.c", { bg = "#004090" })
hl(0, "@function.name.c", { link = "Normal" })
hl(0, "@property.c", { fg = "#ffffff" })
hl(0, "@function.c", { fg = "#ffffff" })
hl(0, "@keyword.c", { fg = "#ffffff" })
hl(0, "@type.c", { fg = "#ffffff" })
hl(0, "@string.c", { fg = "#ffffff" })
hl(0, "@character.c", { fg = "#ffffff" })
hl(0, "@number.c", { fg = "#ffffff" })
hl(0, "@operator.c", { fg = "#ffffff", bold = true })
