{ inputs, ... }:
{
  flake.aspects.desktop = {
    nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      let
        vicinae = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;
        cfg = config.desktop.wayland;
      in
      {
        options.desktop.wayland = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable wayland.";
          };
        };
        config = lib.mkIf cfg.enable {
          environment = {
            systemPackages = with pkgs; [
              kdePackages.polkit-kde-agent-1
              kdePackages.qtbase
              kdePackages.qtwayland
              inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];
            sessionVariables = {
              QT_QPA_PLATFORMTHEME = "qt6ct";
              QT_QPA_PLATFORM = "wayland";
              GTK_THEME = "WhiteSur-Dark";
              MOZ_ENABLE_WAYLAND = "1";
              ELECTRON_OZONE_PLATFORM_HINT = "auto";
              NIXOS_OZONE_WL = "1";
              EDITOR = "nvim";
              XCURSOR_SIZE = "24";
            };
          };

          hj = {
            packages = [
              vicinae
            ];
          };

          services.greetd = {
            enable = true;
            settings = {
              default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet --cmd mango";
                user = "kiana";
              };
            };
            useTextGreeter = true;
          };

          systemd.user.services.polkit-kde-authentication-agent-1 = {
            description = "polkit-kde-authentication-agent-1";
            wantedBy = [ "default.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
              Type = "simple";
              ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
              Restart = "on-failure";
              RestartSec = 1;
              TimeoutStopSec = 10;
            };
          };
        };
      };
  };
}
