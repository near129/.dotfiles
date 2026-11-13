-- Picker to switch the tab-local directory to another worktree of the current git repository

local M = {}

---@return { path: string, branch: string }[]
local function list()
  local root = Snacks.git.get_root()
  if not root then
    error('Not in a git repository')
  end
  local res = vim.system({ 'git', '-C', root, 'worktree', 'list', '--porcelain' }, { text = true }):wait()
  if res.code ~= 0 then
    error('git worktree list failed: ' .. res.stderr)
  end

  local entries = {}
  for block in vim.gsplit(res.stdout, '\n\n', { plain = true, trimempty = true }) do
    local entry = { path = '', branch = '(detached)' }
    for line in vim.gsplit(block, '\n', { plain = true, trimempty = true }) do
      local path = line:match('^worktree (.+)$')
      local ref = line:match('^branch (.+)$')
      if path then
        entry.path = path
      elseif ref then
        entry.branch = ref:gsub('^refs/heads/', '')
      elseif line == 'bare' then
        entry.branch = '(bare)'
      end
    end
    table.insert(entries, entry)
  end
  return entries
end

function M.pick()
  local entries = list()
  local current = vim.uv.cwd()
  Snacks.picker.pick({
    source = 'worktrees',
    title = 'Git Worktrees',
    items = vim.tbl_map(function(e)
      return {
        file = e.path,
        text = e.branch .. ' ' .. e.path,
        dir = true,
        branch = e.branch,
        current = e.path == current,
      }
    end, entries),
    format = function(item)
      return {
        { item.current and '* ' or '  ', 'SnacksPickerSpecial' },
        { item.branch, 'SnacksPickerGitBranch' },
        { '  ' },
        { vim.fn.fnamemodify(item.file, ':~'), 'SnacksPickerDir' },
      }
    end,
    preview = 'directory',
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.cmd.tcd(item.file)
      end
    end,
  })
end

return M
