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
        cfg = config.desktop.qt;
      in
      {
        options.desktop.qt = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable qt.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            xdg.config.files."qt6ct/qt6ct.conf" = {
              generator = lib.generators.toINI { };
              value = {
                Appearance = {
                  icon_theme = "WhiteSur-dark";
                  custom_palette = true;
                  standard_dialogs = "xdgdesktopportal";
                  style = "Adwaita-Dark";
                };
                Fonts = {
                  fixed = ''"monospace,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
                  general = ''"sans-serif,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
                };
              };
            };
            packages = with pkgs; [
              (symlinkJoin {
                inherit (pkgs.qt6Packages.qt6ct)
                  name
                  pname
                  version
                  meta
                  ;
                paths = [ pkgs.qt6Packages.qt6ct ];
                # remove the qt6ct .desktop file. It's not like
                # we can modify settings in there anyway.
                postBuild = ''
                  unlink $out/share/applications/qt6ct.desktop
                '';
              })
              adwaita-qt
              papirus-icon-theme
              adwaita-qt6
              whitesur-icon-theme
            ];
          };
        };
      };
  };
}
