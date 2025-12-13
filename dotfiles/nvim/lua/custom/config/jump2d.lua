local jump2d = require 'mini.jump2d'
jump2d.setup {
  -- 这里放你上面的配置，通常保持默认即可
  labels = 'tniseriahodywfpzbjlxgqvuck', --根据按键频率优化过的顺序
  mappings = {
    start_jumping = '',
  },
}

-- 基础跳转（全屏任意跳）
vim.keymap.set({ 'n', 'v' }, '<leader>s', function()
  jump2d.start(jump2d.builtin_opts.default)
end, { desc = 'Jump to char' })

-- 行首跳转（快速跳到任意行）
vim.keymap.set({ 'n', 'v' }, '<leader>j', function()
  jump2d.start(jump2d.builtin_opts.line_start)
end, { desc = 'Jump to line' })

-- 单词跳转
vim.keymap.set({ 'n', 'v' }, '<leader>w', function()
  jump2d.start(jump2d.builtin_opts.word_start)
end, { desc = 'Jump to word' })

-- 查字符跳转 (类似 f/t 功能，但全屏生效)
vim.keymap.set({ 'n', 'v' }, 'f', function()
  jump2d.start(jump2d.builtin_opts.single_character)
end, { desc = 'Jump to specific char' })
