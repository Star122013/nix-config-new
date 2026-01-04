{ inputs, ... }:
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
        cfg = config.desktop.hyprland;
      in
      {
        options.desktop.hyprland = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable hyprland.";
          };
        };

        config = mkIf cfg.enable {
          programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage =
              inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          };

          hj.files.".config/hypr".source = ../../../dotfiles/hyprland;
        };
      };
  };
}
