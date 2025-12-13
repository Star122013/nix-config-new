local leet_arg = 'leetcode.nvim'

return {
  'kawre/leetcode.nvim',
  -- lazy = 'VeryLazy',
  lazy = leet_arg ~= vim.fn.argv(0, -1),
  opts = { arg = leet_arg },
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    -- configuration goes here
    cn = { -- leetcode.cn
      enabled = true, ---@type boolean
      translator = true, ---@type boolean
      translate_problems = true, ---@type boolean
    },
  },
}
