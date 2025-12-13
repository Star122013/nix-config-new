{ ... }:
{
  flake.aspects.core = {
    nixos =
      {
        config,
        lib,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.core.network;
      in
      {
        options.core.network = {
          enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable network.";
          };

          network-manager = mkOption {
            type = types.bool;
            default = true;
            description = "Enable network-manager.";
          };

          hostname = mkOption {
            type = types.str;
            default = "NixOS";
            description = "Hostname";
          };
        };

        config = mkIf cfg.enable {
          networking = {
            hostName = cfg.hostname;
            networkmanager.enable = cfg.network-manager;
          };
        };
      };
  };
}
