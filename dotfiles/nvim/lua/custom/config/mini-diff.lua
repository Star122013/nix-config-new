if true then
  return {}
end

local colors = {
  green = '#a6e3a1', -- Add
  yellow = '#f9e2af', -- Change
  red = '#f38ba8', -- Delete
  blue = '#89b4fa', -- Change (备选)
}

local function setup_diff_highlights()
  vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = colors.green })
  vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = colors.yellow })
  vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = colors.red })

  vim.api.nvim_set_hl(0, 'MiniDiffOverAdd', { bg = '#1e3020', fg = colors.green }) -- 深绿背景
  vim.api.nvim_set_hl(0, 'MiniDiffOverChange', { bg = '#302d20', fg = colors.yellow }) -- 深黄背景
  vim.api.nvim_set_hl(0, 'MiniDiffOverContext', { bg = '#1e1e2e' }) -- 上下文背景
  vim.api.nvim_set_hl(0, 'MiniDiffOverDelete', { bg = '#381e24', fg = colors.red }) -- 深红背景
end

setup_diff_highlights()
vim.api.nvim_create_autocmd('ColorScheme', { callback = setup_diff_highlights })

require('mini.diff').setup {
  view = {
    style = 'sign', -- 默认显示在侧边栏 (sign column)
    priority = 199, -- 优先级

    signs = {
      add = '▎',
      change = '▎',
      delete = '', -- 删除位置用一个小箭头提示
    },
  },

  mappings = {
    apply = 'gh', -- Apply hunk (应用/暂存当前块)
    reset = 'gH', -- Reset hunk (重置/撤销当前块)

    textobject = 'gh', -- 文本对象 (例如 daih 删除一个 hunk)

    -- 跳转
    goto_first = '[H',
    goto_prev = '[c',
    goto_next = ']c',
    goto_last = ']H',
  },

  -- 选项
  options = {
    wrap_goto = false, -- 跳转循环
  },
}
-- <leader>go = Git Overlay
vim.keymap.set('n', '<leader>go', function()
  require('mini.diff').toggle_overlay()
end, { desc = 'Toggle Git Overlay' })
