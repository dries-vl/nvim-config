local hl = vim.api.nvim_set_hl

-- NAYSAYER THEME
hl(0, "Normal",            { bg = "#062329", fg = "#d1b897" })
hl(0, "@comment.c",        { fg = "#44b340" })
hl(0, "@constant.c",       { fg = "#7ad0c6" })
hl(0, "@variable.c",       { fg = "#c1d1e3" })
--hl(0, "@function.body.c",  { bg = "#0b3335" })
hl(0, "@function.name.c",  { fg = "#ffffff" })
hl(0, "@property.c",       { fg = "#c1d1e3" })
hl(0, "@function.c",       { fg = "#ffffff" })
hl(0, "@keyword.c",        { fg = "#ffffff" })
hl(0, "@type.c",           { fg = "#d1b897" })
hl(0, "@string.c",         { fg = "#2ec90c" })
hl(0, "@character.c",      { fg = "#d1b897" })
hl(0, "@number.c",         { fg = "#7ad0c6" })
hl(0, "@operator.c",       { fg = "#ffffff", bold = true })
