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
        cfg = config.desktop.fcitx;
      in
      {
        options.desktop.fcitx = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable CHANGEME.";
          };
        };

        config = mkIf cfg.enable {
          i18n = {
            # Fcitx 5
            inputMethod = {
              enable = true;
              type = "fcitx5";
              fcitx5 = {
                waylandFrontend = true;
                addons = with pkgs; [
                  librime
                  fcitx5-pinyin-moegirl
                  fcitx5-pinyin-zhwiki
                  fcitx5-rose-pine
                  catppuccin-fcitx5
                  # Rime
                  (fcitx5-rime.override {
                    rimeDataPkgs = [
                      rime-wanxiang
                    ];
                  })
                ];
              };
            };
          };
          hj = {
            files.".local/share/fcitx5/rime/default.custom.yaml".text = ''
                    patch:
              __include: wanxiang_suggested_default:/
            '';
          };
        };
      };
  };
}
