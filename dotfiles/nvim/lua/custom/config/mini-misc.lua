local misc = require 'mini.misc'
misc.setup()
misc.setup_restore_cursor() -- 自动恢复光标
misc.setup_auto_root() -- 自动设根目录

vim.keymap.set('n', '<leader>z', misc.zoom, { desc = 'Zoom Window' })
