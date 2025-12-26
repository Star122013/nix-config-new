{ inputs, ... }:
{
  flake.aspects.desktop = {
    nixos =
      { pkgs, ... }:
      let
        vicinae = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;
      in
      {
        environment = {
          systemPackages = with pkgs; [
            kdePackages.polkit-kde-agent-1
            kdePackages.qtbase
            kdePackages.qtwayland
          ];
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
          enable = true;
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
}
