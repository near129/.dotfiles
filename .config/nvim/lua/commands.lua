-- File path copy commands
-- With a range (e.g. from visual mode), `:<start>-<end>` is appended

local buffer_path = require('buffer_path')

---@param name string
---@param desc string
---@param format fun(path: string): string
---@param with_lines boolean
local function copy_command(name, desc, format, with_lines)
  vim.api.nvim_create_user_command(name, function(opts)
    local path, err = buffer_path.absolute(0)
    if not path then
      vim.notify(err, vim.log.levels.ERROR)
      return
    end
    local text = format(path) .. (with_lines and buffer_path.line_suffix(opts) or '')
    vim.fn.setreg('+', text)
    vim.notify('Copied: ' .. text)
  end, { desc = desc, range = with_lines })
end

copy_command('CopyPath', 'Copy absolute file path to clipboard', function(path)
  return path
end, true)

copy_command('CopyRelativePath', 'Copy relative file path to clipboard', function(path)
  return vim.fn.fnamemodify(path, ':.')
end, true)

copy_command('CopyFilename', 'Copy filename to clipboard', function(path)
  return vim.fn.fnamemodify(path, ':t')
end, true)

copy_command('CopyDirPath', 'Copy directory path to clipboard', function(path)
  return vim.fn.fnamemodify(path, ':h')
end, false)
