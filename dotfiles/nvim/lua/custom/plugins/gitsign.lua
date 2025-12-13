return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    -- Rose-Pine Dawn 在浅色背景下，粗线条比符号看起来更整洁
    signs = {
      add = { text = '▎' }, -- 这种竖线比 '|' 更厚实一点，看起来很有质感
      change = { text = '▎' },
      delete = { text = ' ' }, -- 删除时不显示符号，或者用下划线 '_'
      topdelete = { text = '‾' },
      changedelete = { text = '▎' },
      untracked = { text = '┆' }, -- 虚线表示未追踪
    },

    signcolumn = true, -- 显示左侧指示列
    numhl = false, -- 不高亮行号（浅色主题下高亮行号会显得太花）
    linehl = false, -- 不高亮整行背景（保持代码背景纯净）
    word_diff = false, -- 默认关闭行内单词差异（需要时手动开，不然太乱）

    current_line_blame = true, -- 开启
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol': 在行尾显示 | 'right_align': 右对齐
      delay = 500, -- 500ms 延迟：快速移动光标时不闪烁，停下思考时才显示
      ignore_whitespace = false,
    },
    -- 这是一个小技巧：让 blame 的文字颜色稍微淡一点，不要抢代码的风头
    -- 如果你不设置，Rose-Pine 默认的灰色可能有点深
    current_line_blame_formatter = '<author>, <author_time:%R> • <summary>',

    preview_config = {
      border = 'rounded', -- 圆角窗口，更柔和
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },

    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- 导航：跳转到上一个/下一个修改处
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end)

      -- 常用操作
      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview Hunk' }) -- 预览当前块
      map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = 'Toggle Blame' }) -- 开关 blame
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff This' }) -- 与暂存区对比
    end,
  },
}
