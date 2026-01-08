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
        cfg = config.desktop.flatpak;
      in
      {
        options.desktop.flatpak = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable desktop.flatpak.";
          };
        };

        config = mkIf cfg.enable {
          services.flatpak = {
            enable = true;
            package = pkgs.flatpak;
          };
        };
      };
  };
}
