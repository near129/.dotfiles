-- Open the file under the cursor in the codediff explorer once the cursor stops moving.
-- Replaces codediff's `auto_open_on_cursor`, which opens the diff synchronously on every j/k
-- and blocks while the keys pile up.

local M = {}

local DELAY_MS = 150

---@param tabpage integer
local function open_under_cursor(tabpage)
  local explorer = require('codediff.ui.lifecycle').get_panel_view(tabpage)
  if not explorer or not explorer.tree or not vim.api.nvim_buf_is_valid(explorer.bufnr) then
    return
  end
  local node = explorer.tree:get_node()
  if not node or not node.data or node.data.type == 'group' or node.data.type == 'directory' then
    return
  end
  local selected = explorer.data.current_selection or {}
  if selected.path ~= node.data.path or selected.group ~= node.data.group then
    explorer.on_file_select(node.data)
  end
end

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'codediff-explorer',
    callback = function(ev)
      -- FileType can fire more than once for the same buffer
      if vim.b[ev.buf].codediff_follow_cursor then
        return
      end
      vim.b[ev.buf].codediff_follow_cursor = true
      local timer = assert(vim.uv.new_timer())
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = ev.buf,
        callback = function()
          local tabpage = vim.api.nvim_get_current_tabpage()
          timer:stop()
          timer:start(
            DELAY_MS,
            0,
            vim.schedule_wrap(function()
              -- Skip if the user left the explorer before the delay ran out
              if vim.api.nvim_get_current_buf() == ev.buf then
                open_under_cursor(tabpage)
              end
            end)
          )
        end,
      })
      vim.api.nvim_create_autocmd('BufWipeout', {
        buffer = ev.buf,
        once = true,
        callback = function()
          timer:stop()
          timer:close()
        end,
      })
    end,
  })
end

return M
