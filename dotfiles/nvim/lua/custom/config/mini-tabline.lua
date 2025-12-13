-- 1. 颜色定义 (提亮版)
local colors = {
  active_fg = '#89b4fa', -- 激活：亮蓝色
  inactive_fg = '#bac2de', -- 未激活：亮淡紫 (高对比度)
  red = '#f38ba8', -- 修改状态
  none = 'NONE', -- 透明
}

require('mini.tabline').setup {
  -- 1. 关键修复：tabpage_section 必须是字符串
  tabpage_section = 'right',

  -- 2. 关闭自带图标 (我们手动处理放到文件名右边)
  show_icons = false,
  set_vim_settings = true,

  -- 3. 自定义格式化 (文件列表)
  format = function(buf_id, label)
    local is_current = (buf_id == vim.api.nvim_get_current_buf())
    local is_modified = vim.bo[buf_id].modified
    local mod_str = is_modified and ' ●' or ''

    -- 确保 label 不为空
    local filename = label or '[No Name]'

    -- 手动获取图标 (放到右边)
    local icon = ''
    local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
    if has_devicons then
      -- 使用 buffer 的名字来获取扩展名
      local name = vim.api.nvim_buf_get_name(buf_id)
      local ext = vim.fn.fnamemodify(name, ':e')
      icon = devicons.get_icon(filename, ext, { default = true }) or ''
    end

    -- 拼接: [ 文件名 图标 圆点 ]
    local final_label = filename .. ' ' .. icon .. mod_str

    if is_current then
      return ' [ ' .. final_label .. ' ] '
    else
      return '   ' .. final_label .. '   '
    end
  end,
}

-- =======================
-- 4. 样式修复 (全透明 + 提亮)
-- =======================

-- 辅助函数
local function set_hl(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

-- [Fill] 填充层：必须透明
set_hl('MiniTablineFill', { bg = colors.none })

-- [Current] 当前激活文件：亮蓝 + 粗体
set_hl('MiniTablineCurrent', { fg = colors.active_fg, bg = colors.none, bold = true })

-- [Visible/Hidden] 其他文件：亮淡紫 (确保看得清)
set_hl('MiniTablineVisible', { fg = colors.inactive_fg, bg = colors.none })
set_hl('MiniTablineHidden', { fg = colors.inactive_fg, bg = colors.none })

-- [Modified] 修改状态：红色
set_hl('MiniTablineModifiedCurrent', { fg = colors.red, bg = colors.none, bold = true })
set_hl('MiniTablineModifiedVisible', { fg = colors.red, bg = colors.none })
set_hl('MiniTablineModifiedHidden', { fg = colors.red, bg = colors.none })

-- [Tabpages] 右侧标签页序号 (1, 2, 3...)
-- 设为跟普通文件一样的颜色，保持统一
set_hl('MiniTablineTabpagesection', { fg = colors.active_fg, bg = colors.none, bold = true })
