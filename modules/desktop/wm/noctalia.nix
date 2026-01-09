{ inputs, ... }:
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
        cfg = config.desktop.noctalia;
      in
      {
        options.desktop.noctalia = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable noctalia.";
          };

        };

        config = mkIf cfg.enable {
          environment = {
            systemPackages = [ inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default ];
            # files.".config/noctalia".source = ./../../../dotfiles/noctalia;
          };
        };
      };
  };
}
