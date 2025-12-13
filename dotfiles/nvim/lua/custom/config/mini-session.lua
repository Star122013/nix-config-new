local session_dir = vim.fn.stdpath 'data' .. '/sessions'

if vim.fn.isdirectory(session_dir) == 0 then
  vim.fn.mkdir(session_dir, 'p')
end

require('mini.sessions').setup {
  directory = session_dir,

  autoread = false,
  autowrite = true,
  file = 'Session.vim',
}

vim.keymap.set('n', '<leader>ps', function()
  require('mini.sessions').select()
end, { desc = 'Pick Session' })
