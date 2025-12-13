local indentscope = require 'mini.indentscope'

indentscope.setup {
  -- 符号风格：可以是 '│', '┆', '┊', '╎'
  symbol = '│',

  -- 选项
  options = {
    -- 尝试把线画在边界上（更紧凑）
    try_as_border = true,
  },

  -- 动画效果
  draw = {
    delay = 100, -- 延迟毫秒数，避免光标快速移动时闪烁

    -- 动画函数：none(), linear(), quadratic(), cubic(), quartic(), quintic()
    -- animation = indentscope.gen_animation.none(),
    -- 喜欢动画，用这个：
    animation = indentscope.gen_animation.quadratic { easing = 'out' },
  },

  -- 映射文本对象
  mappings = {
    -- 选中当前缩进块（不含边界）
    object_scope = 'ii',
    -- 选中当前缩进块（含边界）
    object_scope_with_border = 'ai',

    -- 上一个/下一个同级缩进范围
    goto_top = '[i',
    goto_bottom = ']i',
  },
}

local ignore_filetypes = {
  'help',
  'alpha',
  'dashboard',
  'ministarter',
  'neo-tree',
  'Trouble',
  'lazy',
  'mason',
  'notify',
  'toggleterm',
  'lazyterm',
}
-- 【关键配置】在特定文件类型中禁用 indentscope
vim.api.nvim_create_autocmd('FileType', {
  pattern = ignore_filetypes,
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
  vim.b.miniindentscope_disable = true
end
