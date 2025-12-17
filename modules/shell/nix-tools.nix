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
        cfg = config.shell.nix-tools;
        username = config.core.username;
      in
      {
        options.shell.nix-tools = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable nix-tools.";
          };
        };

        config = mkIf cfg.enable {
          system.tools = {
            nixos-option.enable = true;
            nixos-version.enable = false;
            nixos-generate-config.enable = false;
          };

          programs.nix-ld = {
            enable = true;
            libraries = with pkgs; [
              stdenv.cc.cc
            ];
          };

          programs.nh = {
            enable = true;
            flake = "/home/${username}/nix-config";
            clean = {
              dates = "weekly";
              enable = false;
              extraArgs = "--keep 5 --keep-since 3d";
            };
          };

          nix.gc.automatic = true;
          services.angrr = {
            enable = true;
            period = "2weeks";
          };

          environment.systemPackages = [ pkgs.comma-with-db ];

          programs = {
            # Nix-Index
            nix-index = {
              enable = true;
              package = pkgs.nix-index-with-db;
            };
            direnv = {
              enable = true;
              silent = true;
              nix-direnv = {
                enable = true;
              };
            };
          };
        };
      };
  };
}
