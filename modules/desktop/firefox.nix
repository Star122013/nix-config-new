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
        cfg = config.desktop.firefox;
      in
      {
        options.desktop.firefox = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable firefox.";
          };

          package = mkOption {
            type = types.package;
            default = pkgs.firefox;
            description = "The firefox package to install.";
          };
        };

        config = mkIf cfg.enable {
          programs.firefox = {
            enable = true;
          };
        };
      };
  };
}
