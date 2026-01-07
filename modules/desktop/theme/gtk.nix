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
        cfg = config.desktop.gtk;
      in
      {
        options.desktop.gtk = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable gtk.";
          };
        };

        config = mkIf cfg.enable {
          hj.packages = with pkgs; [
            papirus-icon-theme
            arc-theme
            whitesur-gtk-theme
            rose-pine-gtk-theme
            rose-pine-icon-theme
          ];
          hj.files.".gtkrc-2.0".text = ''
            gtk-cursor-theme-name = "Bibata-Modern-Ice"
            gtk-cursor-theme-size = 24
            gtk-font-name = "Maple Mono NF CN"
            gtk-icon-theme-name = "WhiteSur"
            gtk-theme-name = "WhiteSur-Dark"
            gtk-can-change-accels = 1
            gtk-sound-theme-name = "ocean"
            gtk-enable-animations = 1
            gtk-primary-button-warps-slider = 1
            gtk-toolbar-style = 3
            gtk-menu-images = 1
            gtk-button-images = 1          
          '';
          hj.files.".config/gtk-3.0/settings.ini".source = ./../../../dotfiles/gtk/gtk3.ini;
          hj.files.".config/gtk-4.0/settings.ini".source = ./../../../dotfiles/gtk/gtk4.ini;
        };
      };
  };
}
