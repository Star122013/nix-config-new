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
        cfg = config.desktop.emacs;
      in
      {
        options.desktop.emacs = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable desktop.emacs.";
          };

          package = mkOption {
            type = types.package;
            default = pkgs.emacs;
            description = "The emacs package to install.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = [
              pkgs.emacs
            ];
          };
        };
      };
  };
}
