return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require 'custom.config.mini'
    require 'custom.config.jump2d'
    require 'custom.config.mini-picker'
    require 'custom.config.mini-clue'
    require 'custom.config.mini-misc'
    require 'custom.config.mini-session'
    require 'custom.config.mini-indentscope'
    require 'custom.config.mini-starter'
    require 'custom.config.mini-statusline'
    require 'custom.config.mini-tabline'
    require 'custom.config.mini-diff'
  end,
}
