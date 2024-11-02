-- LUA COLORS
local hl = vim.api.nvim_set_hl
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.lua" },  -- Multiple patterns in a table
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "#e0e0e0", fg = "#000000" })
    end
})
