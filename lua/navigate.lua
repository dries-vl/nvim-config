local function fuzzy_open()
  ---------------------------------------------------------------------------
  -- Find git repo root (or fallback to cwd)
  ---------------------------------------------------------------------------
  -- Try to get git root with `git rev-parse --show-toplevel`
  local git_handle = io.popen('git -C . rev-parse --show-toplevel 2>NUL')
  local project_dir = nil
  if git_handle then
    project_dir = git_handle:read("*l")
    git_handle:close()
  end
  if not project_dir or project_dir == "" then
    project_dir = vim.loop.cwd()
  end
  ---------------------------------------------------------------------------

  -- Use a temp file for fzf output
  local tmp   = vim.fn.tempname()
  local cmd   = string.format(
    'cmd /C "fd --type f . %q | fzf --ansi > %q"', project_dir, tmp
  )

  -- Create floating terminal buffer
  local buf = vim.api.nvim_create_buf(false, true)
  local ui  = vim.api.nvim_list_uis()[1]
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    style    = 'minimal',
    border   = 'rounded',
    width    = math.floor(ui.width  * 0.60),
    height   = math.floor(ui.height * 0.60),
    row      = math.floor(ui.height * 0.20),
    col      = math.floor(ui.width  * 0.20),
  })

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.api.nvim_win_close(win, true)
      local lines = vim.fn.readfile(tmp)
      os.remove(tmp)
      if #lines > 0 and lines[1] ~= "" then
        vim.cmd("edit " .. vim.fn.fnameescape(lines[1]))
      end
    end,
  })

  vim.api.nvim_set_current_win(win)
  vim.cmd("startinsert")
end

vim.keymap.set('n', '<leader>f', fuzzy_open, { desc = 'Fuzzy-find file in git repo' })
