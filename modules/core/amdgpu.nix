{ ... }:
{
  flake.aspects.core = {
    nixos =
      {
        config,
        lib,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.core.amdgpu;
      in
      {
        options.core.amdgpu = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable amdgpu.";
          };
        };

        config = mkIf cfg.enable {
          hardware.graphics = {
            enable = true;
            enable32Bit = true;
          };
        };
      };
  };
}
