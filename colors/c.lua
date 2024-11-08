-- C COLORS
local hl = vim.api.nvim_set_hl

local function set_colors_c()
  if vim.opt.background:get() == "light" then

	-- VERSION 1
	hl(0, "Normal", { bg = "#0050a0", fg = "#ffffff" })
	hl(0, "@comment.c", { fg = "#003080" })
	hl(0, "@constant.c", { fg = "#ffffff", bg = "#0080d0" })
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
  else

	-- VERSION 2
	hl(0, "Normal", { bg = "#ffffff", fg = "#000000" })
	hl(0, "@comment.c", { fg = "#d5d5d5"--[[, bg = "#d5d5d5"--]] })
	hl(0, "@constant.c", { fg = "#0050a0", bold = true })
	hl(0, "@variable.c", { fg = "#800000" })
	hl(0, "@property.c", { fg = "#000000" })
	hl(0, "@function.c", { fg = "#000000" })
	hl(0, "@keyword.c", { fg = "#0080d0", bold = true })
	hl(0, "@type.c", { fg = "#000000", bold = true })
	hl(0, "@string.c", { fg = "#00a1a1" })
	hl(0, "@character.c", { fg = "#00a1a1" })
	hl(0, "@number.c", { fg = "#00a1a1" })
	hl(0, "@operator.c", { fg = "#0070c1", bold = true })
  end
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.c", "*.h" },  -- Multiple patterns in a table
    callback = set_colors_c
})

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = { "*.c", "*.h" },  -- Multiple patterns in a table
    callback = set_colors_c
})
vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = function()
        local ft = vim.bo.filetype
        if ft == "c" or ft == "h" then
            set_colors_c()
        end
    end
})
