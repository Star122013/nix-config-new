{ ... }:
{
  flake.aspects.core = {
    nixos =
      {
        pkgs,
        lib,
        ...
      }:
      {

        config = {
          nix = {
            package = pkgs.lixPackageSets.latest.lix;
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
              ];
              trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
              ];
            };
          };
          nixpkgs.flake.setNixPath = true;
          nixpkgs.overlays = lib.mkAfter [
            (_final: prev: {
              inherit (prev.lixPackageSets.latest)
                nixpkgs-review
                nix-eval-jobs
                nix-fast-build
                colmena
                ;
            })
          ];
        };
      };
  };
}
