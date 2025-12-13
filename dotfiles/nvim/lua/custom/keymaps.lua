vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- 在插入模式下使用 Ctrl + h/j/k/l 进行光标移动
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, silent = true, desc = 'Move Left' })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true, silent = true, desc = 'Move Down' })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true, silent = true, desc = 'Move Up' })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true, desc = 'Move Right' })
-- [[ 撤销 ]]
-- 使用 Ctrl + z 进行撤销
vim.keymap.set('n', '<C-z>', 'u', { noremap = true, silent = true, desc = 'Undo' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = 'Focus window left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = 'Focus window down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = 'Focus window up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = 'Focus window right' })

-- vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true, desc = "files_explorer" })
-- vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "buffers_explorer" })
-- vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { silent = true, desc = "diagnostics_explorer" })

-- mini keybinds
vim.keymap.set('n', '<leader>mf', '<cmd>:lua MiniFiles.open()<cr>', { desc = 'Open file explorer(default)' })
vim.keymap.set('n', '<leader>pf', '<cmd>Pick files<cr>', { desc = 'Open file pick' })
vim.keymap.set('n', '<leader>pg', "<cmd>:Pick files tool='git'<cr>", { desc = 'Open file explorer(git)' })
vim.keymap.set('n', '<leader>pb', '<cmd>:Pick buffers<cr>', { desc = 'Open buffers explorer' })
vim.keymap.set('n', '<leader>pd', '<cmd>:Pick diagnostic<cr>', { desc = 'Open diagnostic explorer' })
vim.keymap.set('n', '<leader>pe', '<cmd>:Pick explorer<cr>', { desc = 'Open explorer' })
vim.keymap.set('n', '<leader>pr', '<cmd>:Pick grep_live<cr>', { desc = 'Open grep_live explorer' })
vim.keymap.set('n', '<leader>ph', '<cmd>:Pick help<cr>', { desc = 'Open help explorer' })

vim.keymap.set('n', '<leader>bc', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Delete Buffer' })

-- diagnostics
vim.keymap.set('n', '<leader>de', '<cmd>TinyInlineDiag enable<cr>', { desc = 'Enable diagnostics' })
vim.keymap.set('n', '<leader>dd', '<cmd>TinyInlineDiag disable<cr>', { desc = 'Disable diagnostics' })
vim.keymap.set('n', '<leader>dt', '<cmd>TinyInlineDiag toggle<cr>', { desc = 'Toggle diagnostics' })
