{ ... }:
{
  flake.aspects.desktop = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.shell.yazi;
      in
      {
        options.shell.yazi = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable yazi.";
          };
        };

        config = mkIf cfg.enable {
          hj.packages = with pkgs; [
            (yazi.override {
              _7zz = _7zz-rar; # Support for RAR extraction
            })
          ];
          hj.files.".config/yazi".source = ./../../dotfiles/yazi;
        };
      };
  };
}
