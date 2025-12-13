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
        inherit (lib) mkOption types;
        cfg = config.core.kernel;
        kernelType =
          if cfg.type == "latest" then
            pkgs.linuxPackages_latest
          else if cfg.type == "lts" then
            pkgs.linuxPackages
          else if cfg.type == "zen" then
            pkgs.linuxKernel.packages.linux_zen
          else if cfg.type == "xanmod" then
            pkgs.linuxKernel.packages.linux_xanmod_latest
          else if cfg.type == "lqx" then
            pkgs.linuxKernel.packages.linux_lqx
          else if cfg.type == "rc" then
            pkgs.linuxPackages_testing
          else
            throw "Unsupported kernel type.";
      in
      {
        options.core.kernel = {
          type = mkOption {
            type = types.enum [
              "latest"
              "zen"
              "xanmod"
              "lqx"
              "lts"
              "rc"
            ];
            default = "latest";
            description = "Selects which kernel to use";
          };
        };
        config = {
          boot.kernelPackages = kernelType; # Set kernel based on selection
        };
      };
  };
}
