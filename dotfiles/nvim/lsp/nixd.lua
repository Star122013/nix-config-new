---@type vim.lsp.Config
return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import <nixpkgs> { }',
      },
      formatting = {
        command = { 'nixfmt' },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake ("git+file://" + toString ~/nix-config/.)).nixosConfigurations.Moon.options',
        },
        home_manager = {
          expr = '(builtins.getFlake (builtins.toString ~/nix-config/.)).nixosConfigurations.Moon.options.home-manager.users.type.getSubOptions []',
        },
      },
    },
  },
}
