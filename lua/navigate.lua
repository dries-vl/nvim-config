-- FIND A FILE
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


-- FIND IN FILES
local function fuzzy_grep()
  -- Find git repo root, or fallback to cwd
  local git_handle = io.popen('git -C . rev-parse --show-toplevel 2>NUL')
  local root = git_handle and git_handle:read("*l") or vim.loop.cwd()
  if git_handle then git_handle:close() end
  if not root or root == "" then root = vim.loop.cwd() end

  -- Prompt for search term
  local word = vim.fn.input("Grep for: ")
  if word == "" then return end

  -- Use ripgrep + fzf to pick a line from the results
  local tmp = vim.fn.tempname()
  local cmd = string.format(
    'cmd /C "rg --column --line-number --no-heading --color=always %q %q | fzf --ansi > %q"', word, root, tmp
  )

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
      if #lines == 0 or lines[1] == "" then return end
      -- Extract file, line number from result like: path:line:col:...
      local result = lines[1]
      local file, lnum, col = result:match("^([^:]+):(%d+):(%d+):")
      if file and lnum then
        vim.cmd("edit " .. vim.fn.fnameescape(file))
        vim.api.nvim_win_set_cursor(0, {tonumber(lnum), tonumber(col or 1)-1})
      end
    end,
  })
  vim.api.nvim_set_current_win(win)
  vim.cmd("startinsert")
end

vim.keymap.set('n', '<leader>g', fuzzy_grep, { desc = 'Fuzzy grep in git repo/cwd' })


-- SWITCH BETWEEN BUFFERS
local BSwitch = { win=nil, buf=nil, list={}, idx=1, timer=nil, timeout=200 }

local function stop_timer()
  if BSwitch.timer then
    BSwitch.timer:stop()
    BSwitch.timer:close()
    BSwitch.timer = nil
  end
end

local function restart_timer()
  stop_timer()
  BSwitch.timer = vim.loop.new_timer()
  BSwitch.timer:start(
    BSwitch.timeout, 0,
    vim.schedule_wrap(function()
      stop_timer()
      BSwitch.confirm()
    end))
end

function BSwitch.show()
  -- ❶ Build most-recent-used buffer list
  local infos = vim.fn.getbufinfo({buflisted=1})
  table.sort(infos, function(a,b) return a.lastused > b.lastused end)
  BSwitch.list = vim.tbl_map(function(x) return x.bufnr end, infos)

  -- ❷ Pre-select *previous* buffer when possible
  BSwitch.idx = (#BSwitch.list >= 2) and 2 or 1

  -- ❸ Render lines with “>” marker
  local lines = {}
  for i, bn in ipairs(BSwitch.list) do
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bn), ':t')
    if name == '' then name = '[No Name]' end
    lines[i] = ((i==BSwitch.idx) and '> ' or '  ') .. name
  end

  -- ❹ Popup window
  if BSwitch.win and vim.api.nvim_win_is_valid(BSwitch.win) then
    vim.api.nvim_win_close(BSwitch.win, true)
  end
  BSwitch.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(BSwitch.buf, 0, -1, false, lines)

  local UI = vim.api.nvim_list_uis()[1]
  local w,h = 40, math.min(#lines,10)
  BSwitch.win = vim.api.nvim_open_win(BSwitch.buf, true, {
    relative='editor', style='minimal', border='single',
    width=w, height=h,
    row=math.floor((UI.height-h)/2),
    col=math.floor((UI.width -w)/2),
  })

  -- ❺ Mappings **inside popup**
  local map = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, {buffer=BSwitch.buf, nowait=true, silent=true, noremap=true})
  end
  map('<C-Tab>',   function() BSwitch.move( 1) end)
  map('<C-S-Tab>', function() BSwitch.move(-1) end)
  map('<Esc>',     BSwitch.cancel)
  map('<C-q>',     BSwitch.cancel)

  restart_timer()       -- first arm
end

function BSwitch.redraw()
  local lines = {}
  for i, bn in ipairs(BSwitch.list) do
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bn), ':t')
    if name == '' then name = '[No Name]' end
    lines[i] = ((i==BSwitch.idx) and '> ' or '  ') .. name
  end
  vim.api.nvim_buf_set_lines(BSwitch.buf, 0, -1, false, lines)
end

function BSwitch.move(delta)
  restart_timer()
  local n = #BSwitch.list
  BSwitch.idx = ((BSwitch.idx -1 + delta) % n) + 1
  BSwitch.redraw()
end

function BSwitch.confirm()
  if not (BSwitch.win and vim.api.nvim_win_is_valid(BSwitch.win)) then return end
  local target = BSwitch.list[BSwitch.idx]
  BSwitch.cancel()
  if target then vim.cmd('buffer ' .. target) end
end

function BSwitch.cancel()
  stop_timer()
  if BSwitch.win and vim.api.nvim_win_is_valid(BSwitch.win) then
    pcall(vim.api.nvim_win_close, BSwitch.win, true)
  end
  BSwitch.win, BSwitch.buf, BSwitch.list = nil, nil, {}
end

vim.keymap.set('n', '<C-Tab>', BSwitch.show, {noremap=true, silent=true})
