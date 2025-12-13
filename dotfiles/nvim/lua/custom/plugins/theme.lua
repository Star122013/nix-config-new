return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require 'custom.config.theme'
  end,
  -- 'rose-pine/neovim',
  -- name = 'rose-pine',
  -- priority = 1000,
  -- config = function()
  --   require 'custom.config.theme'
  -- end,
}
