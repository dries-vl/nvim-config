-- lua/notification.lua
local M = {}

-- Call this function to create a notification
function M.show_notification(msg)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg })

    local width = #msg + 4
    local height = 1
    local opts = {
        style = "minimal",
		border = "double",
        relative = "editor",
        width = width,
        height = height,
        row = 1,
        col = 1,
        border = "rounded",
        focusable = false,
        noautocmd = true,
  }

    local win = vim.api.nvim_open_win(buf, false, opts)
	
	-- Set the styling of the floating windows if necessary
    --vim.api.nvim_win_set_option(win, 'winhl', 'NormalFloat:Normal,FloatBorder:Normal')
	
	-- Close the window after a certain amount of ms
    vim.defer_fn(function()
        vim.api.nvim_win_close(win, true)
    end, 10000)
end

return M
