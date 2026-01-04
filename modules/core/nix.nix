{ inputs, ... }:
{
  flake.aspects.core = {
    nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      let
        inherit (lib) mkOption mkIf types;
        cfg = config.core.nix;
      in
      {
        options.core.nix = {
          enableDix = mkOption {
            type = types.bool;
            default = false;
            description = "dix package";
          };
          enableLix = mkOption {
            type = types.bool;
            default = false;
            description = "enable lix eval";
          };
        };

        config = {
          nix = {
            package =
              if cfg.enableDix then
                inputs.determinate.packages.${pkgs.stdenv.hostPlatform.system}.default
              else if cfg.enableLix then
                pkgs.lixPackageSets.latest.lix
              else
                pkgs.nix;
            channel.enable = false;
            settings = {
              max-jobs = "auto";
              auto-optimise-store = true;
              experimental-features = [
                "nix-command"
                "flakes"
              ];
              trusted-users = [ "@wheel" ];

              substituters = [
                "https://mirrors.ustc.edu.cn/nix-channels/store?priority=10"
                "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store?priority=10"
                "https://nix-community.cachix.org?priority=20"
                "https://cache.garnix.io?priority=30"
                "https://cache.nixos.org?priority=30"
                "https://hyprland.cachix.org"
              ];
              trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
              ];
            };
          };
          nixpkgs.flake.setNixPath = true;
          nixpkgs.overlays = mkIf cfg.enableLix (
            lib.mkAfter [
              (_final: prev: {
                inherit (prev.lixPackageSets.latest)
                  nixpkgs-review
                  nix-eval-jobs
                  nix-fast-build
                  colmena
                  ;
              })
            ]
          );
        };
      };
  };
}
