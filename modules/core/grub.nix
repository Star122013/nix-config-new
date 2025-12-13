{ inputs, ... }:
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
        cfg = config.core.grub;
      in
      {
        imports = [ inputs.grub2-themes.nixosModules.default ];

        options.core.grub = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable grub.";
          };
        };

        config = mkIf cfg.enable {
          boot.loader = {
            grub = {
              enable = true;
              device = "nodev";
              efiSupport = true;
              extraEntries = ''
                menuentry "Windows" {
                    search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
                    chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
                }
              '';
            };

            grub2-theme = {
              enable = true;
              theme = "whitesur";
              footer = true;
              screen = "2k";
            };

            efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot";
            };
          };
        };
      };
  };
}
