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

              xdg-desktop-portal
              xdg-desktop-portal-wlr
              xdg-desktop-portal-gtk
            ];
            files.".config/mango".source = ./../../../dotfiles/mango;
          };
        };
      };
  };
}
