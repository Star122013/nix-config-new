return {
  'stevearc/conform.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {},
  config = function()
    require 'custom.config.conform'
  end,
}
