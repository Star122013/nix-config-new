-- 1. 前置工作：必须把原生的虚拟文本关掉！
-- 否则你会看到原生的文字和这个插件的漂亮气泡挤在一起
vim.diagnostic.config {
  virtual_text = false, -- 核心：关闭原生虚拟文本
  virtual_lines = false, -- 如果你装了 lsp_lines，也关掉

  -- 保持侧边栏图标开启
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

-- 2. 设置侧边栏图标 (Catppuccin 风格)
-- ==========================================
-- 侧边栏诊断图标：极简圆点风格
-- ==========================================

-- 1. 定义圆点和对应的 Catppuccin 颜色
local signs = {
  Error = { text = '●', color = '#f38ba8' }, -- 红色
  Warn = { text = '●', color = '#f9e2af' }, -- 黄色
  Hint = { text = '●', color = '#94e2d5' }, -- 青色 (或者用 #cba6f7 紫色)
  Info = { text = '●', color = '#89b4fa' }, -- 蓝色
}

-- 2. 循环应用设置
for type, config in pairs(signs) do
  local hl = 'DiagnosticSign' .. type

  -- 强制设置高亮：前景色为对应颜色，背景色为透明 (NONE)
  -- 这样圆点会悬浮在背景上，没有方块底色
  vim.api.nvim_set_hl(0, hl, { fg = config.color, bg = 'NONE' })

  -- 定义侧边栏图标
  vim.fn.sign_define(hl, {
    text = config.text,
    texthl = hl,
    numhl = hl,
  })
end
-- 3. tiny-inline-diagnostic 核心配置
require('tiny-inline-diagnostic').setup {
  -- 风格预设: 'modern', 'classic', 'minimal', 'powerline', 'ghost', 'simple'
  -- 推荐 'powerline' 或 'classic'，因为你的 Tmux 是方块风格的
  -- 'ghost' 是透明背景风格，可能符合你追求的“透明感”，但有时候会看不清字
  preset = 'classic',
  transparent_bg = true,
  options = {
    -- 是否显示来源 (例如 [lua_ls])
    show_source = true,

    -- 是否使用图标
    use_icons_from_diagnostic = true,

    -- 如果一行有多个错误，是否全部显示
    add_messages = true,

    -- 如果错误信息太长，是否允许换行显示
    multilines = true,

    -- 只有当光标在报错行附近时才完全展开，平时只显示简短信息
    -- 这样代码界面会非常干净
    show_all_diags_on_cursorline = true,

    -- 性能优化：打字时不显示，停下来才显示
    enable_on_insert = false,
    throttle = 20,

    -- 溢出处理：如果报错太长超出屏幕，这就很有用
    overflow = {
      mode = 'wrap',
    },

    -- 格式化显示内容
    format = function(diagnostic)
      return diagnostic.message
    end,
  },

  -- 颜色混合：让背景色不那么刺眼，稍微融合一点背景
  -- factor 越大，颜色越深/越亮
  blend = {
    factor = 0.2,
  },
}
