return {
  'drop-stones/im-switch.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('im-switch').setup {
      linux = {
        enabled = true, -- Set to true if you are on Linux
        default_im = 'keyboard-us', -- or your preferred input method
        get_im_command = { 'fcitx5-remote', '-n' }, -- { "ibus", "engine" }
        set_im_command = { 'fcitx5-remote', '-s' }, -- { "ibus", "engine" }
      },
    }
  end,
}
