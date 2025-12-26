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
        cfg = config.desktop.kitty;
      in
      {
        options.desktop.kitty = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable kitty.";
          };

          package = mkOption {
            type = types.package;
            default = pkgs.kitty;
            description = "The kitty package to install.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = [ cfg.package ];
            files.".config/kitty".source = ./../../dotfiles/kitty;
          };
        };
      };
  };
}
