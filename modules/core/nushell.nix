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
        cfg = config.core.nushell;
      in
      {
        options.core.nushell = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable nushell.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = [
              pkgs.nushell
              pkgs.carapace
              pkgs.carapace-bridge
            ];
            files.".config/nushell/config.nu".source = ./../../dotfiles/nushell/config.nu;
            files.".config/nushell/catppuccin.nu".source = ./../../dotfiles/nushell/catppuccin.nu;
            files.".config/nushell/alias.nu".source = ./../../dotfiles/nushell/alias.nu;
          };
        };
      };
  };
}
