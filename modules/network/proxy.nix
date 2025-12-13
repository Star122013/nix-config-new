{ ... }:
{
  flake.aspects.network = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.network.proxy;
      in
      {
        options.network.proxy = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable proxy.";
          };

          withGui = mkOption {
            type = types.package;
            default = pkgs.throne;
            description = "The proxy package to install.";
          };
        };

        config = mkIf cfg.enable {
          services.dae.enable = true;
          services.dae.configFile = "/etc/dae/config.dae";
          hj.packages = [ cfg.withGui ];
          environment.etc."/dae/config.dae" = {
            source = ./../../dotfiles/dae/dae.dae;
            mode = "0600";
          };
        };
      };
  };
}
