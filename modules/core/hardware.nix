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
        inherit (lib) mkOption types;
        cfg = config.core.hardware;
      in
      {
        options.core.hardware = {
          bluetooth = mkOption {
            type = types.bool;
            default = true;
            description = "Enable CHANGEME.";
          };
          pipewire = mkOption {
            type = types.bool;
            default = true;
            description = "Enable pipewire.";
          };
        };

        config = {
          hardware.bluetooth.enable = cfg.bluetooth;

          services = {
            pulseaudio.enable = !cfg.pipewire;
            # Pipewire
            pipewire = {
              enable = cfg.pipewire;
              alsa.enable = true;
              alsa.support32Bit = true;
              pulse.enable = true;
              # If you want to use JACK applications, uncomment this
              jack.enable = true;
            };
          };
        };
      };
  };
}
