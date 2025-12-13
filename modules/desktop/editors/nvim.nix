{ ... }:
{
  flake.aspects.desktop = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.desktop.nvim;
      in
      {
        options.desktop.nvim = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable nvim.";
          };
        };

        config = mkIf cfg.enable {
          programs.neovim = {
            enable = true;
            withPython3 = true;
            withNodeJs = true;
          };

          hj.packages = [
            pkgs.tree-sitter
          ];
        };
      };
  };
}
