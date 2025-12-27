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
        inherit (lib) mkOption types mkIf;
        cfg = config.core.fonts;
        jetbrains-maple-mono = pkgs.callPackage ../../packages/JetBrainsMapleMono.nix { };
      in
      {
        options.core.fonts = {
          enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable fonts.";
          };
        };

        config = mkIf cfg.enable {
          fonts = {
            fontDir.enable = true;
            enableDefaultPackages = false;
            packages = with pkgs; [
              jetbrains-maple-mono
              noto-fonts # Base Noto Fonts
              noto-fonts-cjk-sans
              noto-fonts-cjk-serif
              noto-fonts-color-emoji
              material-symbols
              nerd-fonts.symbols-only
              nerd-fonts.jetbrains-mono
              lxgw-wenkai-screen
              maple-mono.NF-CN
            ];
            fontconfig = {
              defaultFonts = lib.mkForce {
                # XXX: Qt solely uses the first 255 fonts from fontconfig:
                # https://bugreports.qt.io/browse/QTBUG-80434
                # So put emoji font here.
                sansSerif = [
                  "JetBrains Maple Mono"
                  "LXGW WenKai Screen"
                ];
                serif = [
                  "JetBrains Maple Mono"
                  "LXGW WenKai Screen"
                ];
                monospace = [
                  "JetBrains Maple Mono"
                ];
                emoji = [
                  "Noto Color Emoji"
                ];
              };
              subpixel.rgba = "rgb";
              cache32Bit = true;
              localConf = ''
                <match target="pattern">
                    <test name="lang" compare="contains">
                      <string>zh</string>
                    </test>
                    <edit name="family" mode="append" binding="strong">
                      <string>JetBrains Maple Mono</string>
                    </edit>
                  </match>'';
            };
          };
        };
      };
  };
}
