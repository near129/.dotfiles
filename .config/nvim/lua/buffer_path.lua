-- Resolve the real file path behind a buffer, including codediff.nvim buffers

local M = {}

---Absolute path of the file a buffer shows.
---codediff:// buffers (the revision side of a diff) map to the file in the work tree.
---@param buf integer
---@return string? path
---@return string? err
function M.absolute(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name:match('^codediff://') then
    local git_root, _, filepath = require('codediff.core.virtual_file').parse_url(name)
    if not git_root then
      return nil, 'Unrecognized codediff buffer: ' .. name
    end
    return vim.fs.joinpath(git_root, filepath)
  end
  if name == '' or vim.bo[buf].buftype ~= '' then
    return nil, 'Buffer is not a file'
  end
  return vim.fn.fnamemodify(name, ':p')
end

---`:<start>` or `:<start>-<end>` for a command range, '' when no range was given.
---@param opts vim.api.keyset.create_user_command.command_args
---@return string
function M.line_suffix(opts)
  if opts.range == 0 then
    return ''
  end
  if opts.line1 == opts.line2 then
    return ':' .. opts.line1
  end
  return ':' .. opts.line1 .. '-' .. opts.line2
end

return M
