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
        cfg = config.desktop.game;
      in
      {
        options.desktop.game = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable game.";
          };
        };

        config = mkIf cfg.enable {
          programs.steam = {
            enable = true;
            package = pkgs.steam.override {
              extraEnv = {
                MANGOHUD = true;
                OBS_VKCAPTURE = true;
                RADV_TEX_ANISO = 16;
              };
              extraLibraries =
                p: with p; [
                  atk
                ];
            };
          };
        };
      };
  };
}
