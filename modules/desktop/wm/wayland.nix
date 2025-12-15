{ ... }:
{
  flake.aspects.desktop = {
    nixos =
      { pkgs, ... }:
      {
        environment = {
          systemPackages = [ pkgs.kdePackages.polkit-kde-agent-1 ];
          sessionVariables = {
            QT_QPA_PLATFORMTHEME = "qt6ct";
            QT_QPA_PLATFORM = "wayland";
            GTK_THEME = "Papirus";
            MOZ_ENABLE_WAYLAND = "1";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
            NIXOS_OZONE_WL = "1";
            EDITOR = "nvim";
            XCURSOR_SIZE = "24";
          };
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
          wantedBy = [ "graphical-session.target" ];
          wants = [ "graphical-session.target" ];
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
}
