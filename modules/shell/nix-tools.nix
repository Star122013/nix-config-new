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

          environment.systemPackages = [ pkgs.comma-with-db ];

          programs = {
            # Nix-Index
            nix-index = {
              enable = true;
              package = pkgs.nix-index-with-db;
              enableFishIntegration = true;
            };
          };
        };
      };
  };
}
