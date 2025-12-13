{ inputs, ... }:
{
  flake.nixosConfigurations.Moon = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      with inputs.self.modules.nixos;
      [
        core
        desktop
        network
        shell
        overlays
      ]
      ++ [
        ./Moon/_file-system.nix
        ./Moon/_cfg.nix
      ];
  };
}
