{ inputs, self, ... }:
{
  flake.nixosConfigurations.Moon = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit
        self # Required
        inputs
        ;
    };
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
