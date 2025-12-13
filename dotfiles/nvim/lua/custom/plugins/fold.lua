return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  opts = {
    foldtext = {
      enabled = true,
      padding = 3,
      lineCount = {
        template = '↗ %d lines', -- `%d` is replaced with the number of folded lines
        hlgroup = 'Comment',
      },
      diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
      gitsignsCount = true, -- requires `gitsigns.nvim`
      disableOnFt = { 'snacks_picker_input' }, ---@type string[]
    },
  }, -- needed even when using default config

  -- recommended: disable vim's auto-folding
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
