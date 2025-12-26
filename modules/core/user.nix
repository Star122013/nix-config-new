{ inputs, ... }:
{
  flake.aspects.core = {
    nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      let
        inherit (lib) mkOption types;
        inherit (lib.modules) mkAliasOptionModule;
        inherit (config.core) username;
        cfg = config.core.hjem;
      in
      {
        options.core.username = mkOption {
          type = types.str;
          default = "kiana";
          description = "Sets the username for the system.";
        };
        options.core.hjem = mkOption {
          type = types.bool;
          default = true;
          description = "Enable hjem.";
        };
        imports = [
          inputs.hjem.nixosModules.default
          # Allow using `hj` in configuration to
          # easily configure hjem in any file.
          # This pretty much makes or breaks my config.
          (mkAliasOptionModule [ "hj" ] [ "hjem" "users" username ])
        ];
        config = {
          hjem = lib.mkIf cfg {
            clobberByDefault = true;
            linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
            users.${username} = {
              enable = true;
              # These are available no matter the host.
              packages = with pkgs; [
                nheko
                npins
                loupe
                wget
                ffmpeg
                imagemagick
                mate.atril
                nix-tree
                gcc
                vesktop
                dwt1-shell-color-scripts
              ];
            };
          };
          users.users.${username} = {
            isNormalUser = true;
            # so you can login the first time.
            # PLEASE change this after logging in :prayge:
            home = "/home/${username}";
            extraGroups = [
              "wheel"
              "video"
              "seat"
              "networkmanager"
              "docker"
            ];
            shell = pkgs.nushell;
            ignoreShellProgramCheck = true;
          };
          xdg.mime.defaultApplications = {
            "application/pdf" = "atril.desktop";

            "image/png" = "org.gnome.Loupe.desktop";
            "image/jpeg" = "org.gnome.Loupe.desktop";
            "image/jpg" = "org.gnome.Loupe.desktop";
            "image/gif" = "org.gnome.Loupe.desktop";
            "image/webp" = "org.gnome.Loupe.desktop";
            "image/bmp" = "org.gnome.Loupe.desktop";
            "image/tiff" = "org.gnome.Loupe.desktop";
            "image/svg+xml" = "org.gnome.Loupe.desktop";
          };
          environment.sessionVariables = {
            XDG_CONFIG_HOME = "$HOME/.config";
            XDG_DATA_HOME = "$HOME/.local/share";
            XDG_CACHE_HOME = "$HOME/.cache";
            XDG_STATE_HOME = "$HOME/.local/state";
          };
        };
      };
  };
}
