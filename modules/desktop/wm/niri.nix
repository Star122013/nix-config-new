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
        cfg = config.desktop.niri;
      in
      {
        imports = [ inputs.niri-flake.nixosModules.niri ];
        options.desktop.niri = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable niri.";
          };
        };

        config = mkIf cfg.enable {
          programs.niri = {
            enable = true;
            package = pkgs.niri-unstable;
          };

          nixpkgs.overlays = lib.mkAfter [
            inputs.niri-flake.overlays.niri
          ];

          hj.packages = with pkgs; [
            xdg-desktop-portal
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
            xwayland-satellite
            nautilus
            swww
            cliphist
            kdePackages.polkit-kde-agent-1
          ];

          hj.files.".config/niri".source = ./../../../dotfiles/niri;
        };
      };
  };
}
