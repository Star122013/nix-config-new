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
        cfg = config.core.security;
      in
      {
        options.core.security = {
          enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable security.";
          };
        };

        config = mkIf cfg.enable {
          security.rtkit.enable = true;
          security.sudo-rs.enable = true;
          security.sudo-rs.execWheelOnly = true;
        };
      };
  };
}
