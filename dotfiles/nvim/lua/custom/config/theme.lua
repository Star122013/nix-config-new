require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  transparent_background = true, -- disables setting the background color.
  float = {
    transparent = true, -- enable transparent floating windows
    solid = false, -- use solid styling for floating windows, see |winborder|
  },
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = 'dark',
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { 'italic' }, -- Change the style of comments
    conditionals = { 'italic' },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Uncomment to turn off hard-coded styles
  },
  lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
    virtual_text = {
      errors = { 'italic' },
      hints = { 'italic' },
      warnings = { 'italic' },
      information = { 'italic' },
      ok = { 'italic' },
    },
    underlines = {
      errors = { 'underline' },
      hints = { 'underline' },
      warnings = { 'underline' },
      information = { 'underline' },
      ok = { 'underline' },
    },
    inlay_hints = {
      background = true,
    },
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  auto_integrations = true,

  -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
}

-- setup must be called before loading
vim.cmd.colorscheme 'catppuccin' -- 定义红色
vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#E06C75' }) -- 使用一个柔和的红色

-- 定义黄色
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#E5C07B' }) -- 柔和的黄色

-- 定义蓝色
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#61AFEF' }) -- 柔和的蓝色

-- 定义青色
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#56B6C2' }) -- 柔和的青色

-- 定义橙色
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#D19A66' }) -- 柔和的橙色

-- 定义绿色
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#98C379' }) -- 柔和的绿色

-- 定义紫色
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#C678DD' }) -- 柔和的紫色
