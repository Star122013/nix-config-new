require('conform').setup {
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    cpp = { 'clang-format' },
    c = { 'clang-format' },
    typst = { 'typstyle' },
    nix = { 'nixfmt' },
    markdown = { 'mdformat' },
    -- kdl = { "kdlfmt" },
    -- Conform will run multiple formatters sequentially
    python = { 'isort', 'black' },
    qml = { 'qmlformat' },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { 'rustfmt', lsp_format = 'fallback' },
    -- Conform will run the first available formatter
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
  },
}
