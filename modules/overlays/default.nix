{ inputs, ... }:
{
  flake.aspects.overlays = {
    nixos = {
      nixpkgs.overlays = [
        inputs.nix-index-database.overlays.nix-index
        (_final: _prev: {
          qq = _prev.qq.override {
            commandLineArgs = [
              "--enable-features=UseOzonePlatform"
              "--ozone-platform=wayland"
              "--ozone-platform-hint=auto"
              "--enable-wayland-ime"
              "--wayland-text-input-version=3"
            ];
          };
        })
      ];
      nixpkgs.config = {
        allowUnfree = true;
      };
    };
  };
}
