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
        cfg = config.desktop.foot;
      in
      {
        options.desktop.foot = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable foot.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = [
              pkgs.foot
            ];
            files.".config/foot".source = ./../../dotfiles/foot;
          };
        };
      };
  };
}
