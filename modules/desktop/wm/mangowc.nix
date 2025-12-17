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
        cfg = config.desktop.mangowc;
      in
      {
        imports = [ inputs.mango.nixosModules.mango ];

        options.desktop.mangowc = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable mangowc.";
          };
        };

        config = mkIf cfg.enable {
          programs.mango.enable = true;
          hj = {
            packages = with pkgs; [
              kdePackages.qt5compat
              wl-clip-persist
              wl-clipboard
              cliphist
              grim
              swappy
              slurp
              xdg-desktop-portal
              xdg-desktop-portal-wlr
              xdg-desktop-portal-gtk
            ];
            files.".config/mango".source = ./../../../dotfiles/mango;
            files.".config/swappy/config".text = ''
              [Default]
              save_dir=$HOME/Pictures/Screenshots
              save_filename_format=screenshot-%Y%m%d-%H%M%S.png
              show_panel=false
              line_size=3
              text_size=15
              text_font=sans-serif
              paint_mode=brush
              early_exit=false
              fill_shape=false
              auto_save=false
              custom_color=rgba(255,0,0,1)
              transparent=false
              transparency=50
            '';
          };
        };
      };
  };
}
