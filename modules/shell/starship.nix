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
        cfg = config.shell.starship;
      in
      {
        options.shell.starship = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable starship.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = [
              pkgs.starship
            ];
            files.".config/starship.toml".source = ./../../dotfiles/starship/starship.toml;
          };
        };
      };
  };
}
