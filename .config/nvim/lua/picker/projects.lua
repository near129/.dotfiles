-- Custom finder for Snacks.picker.projects
-- Same as snacks' `recent_projects`, but fd runs with --no-ignore so ignored directories are listed too.

---@type snacks.picker.finder
return function(opts, ctx)
  local fd = require('snacks.picker.source.files').get_fd()
  if not fd then
    error('`fd` or `fdfind` is required for projects')
  end

  local args = {
    '-H',
    '-t',
    'f',
    '-t',
    's',
    '-t',
    'd',
    '--max-depth',
    tostring(opts.max_depth),
    '--no-ignore',
    '--follow',
    '--absolute-path',
    '-g',
    '{' .. table.concat(opts.patterns, ',') .. '}',
  }
  for _, pattern in ipairs(opts.exclude) do
    vim.list_extend(args, { '--exclude', pattern })
  end
  local dev = type(opts.dev) == 'string' and { opts.dev } or opts.dev
  vim.list_extend(args, vim.tbl_map(svim.fs.normalize, dev))

  local proc = require('snacks.picker.source.proc').proc({ cmd = fd, args = args, notify = false }, ctx)

  ---@async
  ---@param cb async fun(item: snacks.picker.finder.Item)
  return function(cb)
    local seen = {} ---@type table<string, boolean>
    ---@async
    local function add(dir)
      if dir and not seen[dir] then
        seen[dir] = true
        cb({ file = dir, text = dir, dir = true })
      end
    end

    if opts.recent then
      for _, file in ipairs(vim.v.oldfiles) do
        file = svim.fs.normalize(vim.fn.fnamemodify(file, ':p'), { _fast = true, expand_env = false })
        if ctx.filter:match({ file = file, text = '' }) and vim.uv.fs_stat(file) then
          add(Snacks.git.get_root(file))
        end
      end
    end

    vim.tbl_map(add, opts.projects)

    ---@async
    proc(function(item)
      local path = svim.fs.normalize(item.text)
      path = path:sub(-1) == '/' and path:sub(1, -2) or path
      path = vim.fs.dirname(path)
      if ctx.filter:match({ file = path, text = path }) then
        add(path)
      end
    end)
  end
end
