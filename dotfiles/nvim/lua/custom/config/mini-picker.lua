local function pick_tabs()
  local pick = require 'mini.pick'

  local tabs = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local items = {}

  for i, tab_handle in ipairs(tabs) do
    local win = vim.api.nvim_tabpage_get_win(tab_handle)
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    local label = name ~= '' and vim.fn.fnamemodify(name, ':~:.') or '[No Name]'
    local prefix = (tab_handle == current_tab) and '*' or ' '

    table.insert(items, {
      text = string.format('%s %d: %s', prefix, i, label),
      handle = tab_handle,
      bufnr = buf,
    })
  end

  pick.start {
    source = {
      name = 'Tabs',
      items = items,
      choose = function(item)
        -- [关键修复] 使用 vim.schedule 延迟执行
        -- 确保 mini.pick 完全关闭后再切换 Tab，防止焦点被抢回
        vim.schedule(function()
          if vim.api.nvim_tabpage_is_valid(item.handle) then
            vim.api.nvim_set_current_tabpage(item.handle)
          end
        end)
      end,
      preview = function(buf_id, item)
        pick.default_preview(buf_id, item)
      end,
    },
  }
end

vim.keymap.set('n', '<leader>pt', pick_tabs, { desc = 'Pick Tabs' })
