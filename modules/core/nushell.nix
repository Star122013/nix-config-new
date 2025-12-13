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
        cfg = config.core.nushell;
      in
      {
        options.core.nushell = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable nushell.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = [
              pkgs.nushell
            ];
            files.".config/nushell".source = ./../../dotfiles/nushell;
          };
        };
      };
  };
}
