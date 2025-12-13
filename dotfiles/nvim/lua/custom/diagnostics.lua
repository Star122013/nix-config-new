vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = false,
  underline = true,
  update_in_insert = true,
  -- signs = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lazy',
  callback = function(args)
    -- 针对 lazy 缓冲区禁用 virtual_lines
    vim.diagnostic.config({
      virtual_lines = false,
    }, args.buf)
  end,
})
