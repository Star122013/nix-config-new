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
        cfg = config.desktop.niri;
      in
      {
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
          };

          hj.packages = with pkgs; [
            xdg-desktop-portal
            xdg-desktop-portal-gtk
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
