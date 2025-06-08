-- NAYSAYER THEME
local hl = vim.api.nvim_set_hl
-- Custom groups
hl(0, "cUserFunction",        { fg = "#ffffff", bold = true })
hl(0, "cUserFunctionPointer", { fg = "#b7ecff", bold = true, italic = true })

-- Vim groups
hl(0, "Normal",         { bg = "#062329", fg = "#d1b897" })
hl(0, "Comment",        { fg = "#44b340" })
hl(0, "cCommentL",      { fg = "#44b340" })
hl(0, "cCommentStart",  { fg = "#44b340" })
hl(0, "Error",          { fg = "#d1b897" })

hl(0, "Type",           { fg = "#c1d1e3" })
hl(0, "Structure",      { fg = "#ffbbbb" })
hl(0, "StorageClass",   { fg = "#c1d1e3" })

hl(0, "Statement",      { fg = "#c1d1e3" })
hl(0, "Conditional",    { fg = "#c1d1e3" }) -- if else
hl(0, "Label",          { fg = "#c1d1e3" }) -- case in switches
hl(0, "UserLabel",      { fg = "#c1d1e3" }) -- ie. goto start <- the label

hl(0, "PreProc",        { fg = "#d1b897" }) -- #pragma, ...
hl(0, "cIncluded",      { fg = "#c1d1e3" }) -- <stdio.h>
hl(0, "Include",        { fg = "#d1b897" }) -- #include
hl(0, "PreCondit",      { fg = "#148310" }) -- #ifdef
hl(0, "cDefine",        { fg = "#d1b897" }) -- #define

hl(0, "Number",         { fg = "#7ad0c6" })
hl(0, "Float",          { fg = "#7ad0c6" })
hl(0, "Octal",          { fg = "#7ad0c6" })
hl(0, "Character",      { fg = "#7ad0c6" })

hl(0, "String",         { fg = "#2ec90c" })
hl(0, "SpecialChar",    { fg = "#44b3ff" }) -- special chars like \n
hl(0, "cFormat",        { fg = "#d1b897", bold = true }) -- format specifiers like %d (default links to special char)

-- Terminal ANSI groups
hl(0, "NormalFloat",       { bg = "#032026", fg = "#d1b897" })
vim.g.terminal_color_0  = "#163339" -- Black       (theme background)
vim.g.terminal_color_1  = "#44b340" -- Red         (comment green, fits as a "muted red")
vim.g.terminal_color_2  = "#2ec90c" -- Green       (string green)
vim.g.terminal_color_3  = "#d1b897" -- Yellow      (type/character)
vim.g.terminal_color_4  = "#7ad0c6" -- Blue        (constant/number)
vim.g.terminal_color_5  = "#ffffff" -- Magenta     (function/keyword/operator)
vim.g.terminal_color_6  = "#c1d1e3" -- Cyan        (property/variable)
vim.g.terminal_color_7  = "#d1b897" -- White       (same as yellow/type for bright white)
vim.g.terminal_color_8  = "#0b3335" -- Bright Black (slightly lighter bg)
vim.g.terminal_color_9  = "#44b340" -- Bright Red   (same as normal comment green)
vim.g.terminal_color_10 = "#2ec90c" -- Bright Green (string green)
vim.g.terminal_color_11 = "#d1b897" -- Bright Yellow (type)
vim.g.terminal_color_12 = "#7ad0c6" -- Bright Blue   (constant)
vim.g.terminal_color_13 = "#ffffff" -- Bright Magenta (function/keyword)
vim.g.terminal_color_14 = "#c1d1e3" -- Bright Cyan    (variable)
vim.g.terminal_color_15 = "#ffffff" -- Bright White   (pure white)
