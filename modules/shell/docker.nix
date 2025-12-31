{ ... }:
{
  flake.aspects.shell = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.shell.docker;
      in
      {
        options.shell.docker = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable docker.";
          };

          package = mkOption {
            type = types.package;
            default = pkgs.docker;
            description = "The docker package to install.";
          };
        };

        config = mkIf cfg.enable {
          virtualisation.docker = {
            enable = true;
            package = cfg.package;
          };
        };
      };
  };
}
