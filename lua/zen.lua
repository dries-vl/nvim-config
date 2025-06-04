vim.opt.laststatus = 0 -- remove the status line entirely from all windows (!)

--[[
-- Save the current window ID (right window)
local right_win = vim.api.nvim_get_current_win()

-- Create a vertical split to the left without changing focus
vim.cmd('leftabove vsplit')

-- Get the window ID of the window currently on the left (the new window)
local left_win = vim.fn.win_getid(vim.fn.winnr('h'))

-- Set up the left window
vim.api.nvim_set_current_win(left_win)
vim.cmd('enew')  -- Create a new empty buffer
vim.bo.buftype = 'nofile'     -- Set buffer as scratch
vim.bo.bufhidden = 'wipe'     -- Wipe buffer when unloaded
vim.bo.swapfile = false       -- Don't use swapfile
vim.bo.buflisted = false      -- Don't list buffer
vim.api.nvim_win_set_width(left_win, 10)  -- Set the width of the whitespace we want

-- Remove the separator line and tildes in the left window
vim.api.nvim_win_set_option(left_win, 'fillchars', 'eob: ,vert: ')

-- Remove the status bar in the left window
vim.api.nvim_win_set_option(left_win, 'statusline', ' ')
vim.api.nvim_win_set_option(left_win, 'winhl', 'StatusLine:Normal')

-- Autocmd to prevent focus from staying on the left window
-- We need to use a callback here, because switching here directly won't work, as the first focus switch seems to be async later too
vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
    callback = function()
        if vim.api.nvim_get_current_win() == left_win and vim.api.nvim_win_is_valid(right_win) then
            vim.api.nvim_set_current_win(right_win)
        end
    end
})

-- Function to check if only non-floating windows are left
local function last_non_floating()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative == '' and win ~= vim.api.nvim_get_current_win() then
            return false
        end
    end
    return true
end

-- Close the left window always if it is left, to avoid staying in there when closing neovim
-- Auto-close the left window if it's the last non-floating window
vim.api.nvim_create_autocmd({"BufLeave", "WinEnter"}, {
    callback = function()
        if last_non_floating() and vim.bo.buftype == "nofile" then
            vim.cmd("quit!")
        end
    end
})
]]

-- Function to toggle a centered floating window
local centered_win = nil

function ToggleCenter()
  if centered_win and vim.api.nvim_win_is_valid(centered_win) then
    vim.api.nvim_win_close(centered_win, true)
    centered_win = nil
  else
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2 - 1)
    local col = math.floor((vim.o.columns - width) / 2)
    centered_win = vim.api.nvim_open_win(0, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = row,
      col = col,
      style = 'minimal',
      border = 'single',
    })
  end
end

-- Keybinding to toggle centered view (e.g., <leader>z)
vim.api.nvim_set_keymap('n', 'zz', ':lua ToggleCenter()<CR>', { noremap = true, silent = true })
