require('mini.statusline').setup {
  use_icons = true,
  content = {
    active = function()
      -- =======================
      -- 1. 准备数据 & 图标
      -- =======================
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local git = MiniStatusline.section_git { trunc_width = 40 }
      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local filename = vim.fn.expand '%:t'
      if filename == '' then
        filename = '[No Name]'
      end

      -- 获取文件图标 (核心需求：保留这个)
      local icon = ''
      local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
      if has_devicons then
        local ext = vim.fn.expand '%:e'
        -- 获取图标和图标颜色
        local file_icon, file_icon_color = devicons.get_icon_color(filename, ext, { default = true })
        -- 我们用 highlight 组来保留原本图标的颜色，而不是强制白色
        local hl_group = 'MiniStatuslineFileIcon'
        vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color, bg = 'NONE' })
        icon = string.format('%%#%s#%s%%*', hl_group, file_icon) .. ' '
      end

      -- 获取当前模式的图标 (美化 Mode 显示)
      -- 你可以根据喜好改成其他图标，比如  (Neovim logo) 或  (Vim logo)
      local mode_map = {
        ['n'] = ' ',
        ['i'] = ' ',
        ['v'] = ' ',
        ['V'] = ' ',
        ['\22'] = ' ',
        ['c'] = ' ',
        ['R'] = ' ',
        ['t'] = ' ',
      }
      local mode_code = vim.api.nvim_get_mode().mode
      local mode_icon = mode_map[mode_code] or ' '

      -- 获取位置
      local line_col = string.format('%d:%d', vim.fn.line '.', vim.fn.col '.')

      -- LSP & CWD
      local function get_lsp()
        local msg = 'No LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')

      -- =======================
      -- 2. 颜色定义 (透明背景)
      -- =======================
      local blue = '#89b4fa'
      local green = '#a6e3a1'
      local yellow = '#f9e2af'
      local red = '#f38ba8'
      local white = '#cdd6f4'
      local grey = '#585b70'

      -- Mode 高亮：文字带颜色，背景透明
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = blue, bg = 'NONE', bold = true })
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = green, bg = 'NONE', bold = true })
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = yellow, bg = 'NONE', bold = true })
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = red, bg = 'NONE', bold = true })
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = red, bg = 'NONE', bold = true })

      -- 其他文字高亮
      vim.api.nvim_set_hl(0, 'StatusMeta', { fg = white, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'StatusGrey', { fg = grey, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'StatusBlue', { fg = blue, bg = 'NONE', bold = true })

      -- 辅助拼接
      local function hl(group, txt)
        return string.format('%%#%s#%s%%*', group, txt)
      end

      -- =======================
      -- 3. 布局拼接
      -- =======================

      -- [左侧]
      -- 模式图标 + 模式名称 (例如:  NORMAL)
      local mode_str = hl(mode_hl, mode_icon .. string.upper(mode))

      -- 文件图标 + 文件名 (保留了 DevIcons 的原色)
      local file_str = '  ' .. icon .. hl('StatusMeta', filename)

      -- Git
      local git_str = ''
      if git and git ~= '' then
        git_str = hl('StatusGrey', '  ' .. git)
      end

      -- [右侧]
      -- 诊断 (mini自带颜色)
      local diag_str = diagnostics

      -- LSP (图标 + 名字)
      local lsp_str = hl('StatusGrey', '   ' .. get_lsp())

      -- 路径 (图标 + 路径)
      local cwd_str = hl('StatusBlue', '   ' .. cwd)

      -- 位置
      local loc_str = hl('StatusGrey', '  ' .. line_col)

      return mode_str .. file_str .. git_str .. '%=' .. diag_str .. lsp_str .. cwd_str .. loc_str
    end,
  },
}

-- 再次确保全局状态栏透明
vim.cmd [[
  highlight StatusLine   guibg=NONE ctermbg=NONE guifg=#cdd6f4
  highlight StatusLineNC guibg=NONE ctermbg=NONE guifg=#585b70
]]
