{ ... }:
{
  flake.aspects.core = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.core.zsh;
      in
      {
        options.core.zsh = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable core.zsh.";
          };

          package = mkOption {
            type = types.package;
            default = pkgs.zsh;
            description = "The zsh package to install.";
          };
        };

        config = mkIf cfg.enable {
          programs.zsh = {
            enable = true;
          };
          hj = {
            packages = [
              pkgs.sheldon
            ];
          };
        };
      };
  };
}
