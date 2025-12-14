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
        cfg = config.desktop.helix;
      in
      {
        options.desktop.helix = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable helix.";
          };

          package = mkOption {
            type = types.package;
            default = pkgs.helix;
            description = "The helix package to install.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = [
              cfg.package
            ];
            files.".config/helix".source = ./../../../dotfiles/helix;
          };
        };
      };
  };
}
