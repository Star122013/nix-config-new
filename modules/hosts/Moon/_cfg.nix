{
  pkgs,
  ...
}:
{
  core = {
    fonts.enable = true;
    hjem = true;
    grub.enable = true;
    hardware.bluetooth = true;
    hardware.pipewire = true;
    kernel.type = "zen";
    network.hostname = "Moon";
    network.network-manager = true;
    security.enable = true;
    username = "kiana";
    nushell.enable = true;
  };

  desktop = {
    qt.enable = true;
    gtk.enable = true;
    firefox.enable = true;
    mangowc.enable = true;
    niri.enable = true;
    noctalia.enable = true;
    nvim.enable = true;
    foot.enable = true;
    fcitx.enable = true;
    helix.enable = true;
    kitty.enable = true;
    game.enable = true;
  };

  shell = {
    tools.enable = true;
    starship.enable = true;
    git.enable = true;
    git.name = "kiana";
    git.email = "hyy122013@outlook.com";
    nix-tools.enable = true;
    yazi.enable = true;
  };

  network = {
    proxy.enable = true;
    proxy.withGui = pkgs.throne;
  };

  hj.packages = with pkgs; [
    qq
    go-musicfox
    ayugram-desktop
    google-chrome
    codex
    (pkgs.symlinkJoin {
      name = "typora-wrapped";
      paths = [ pkgs.typora ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/typora \
          --add-flags "--enable-wayland-ime --wayland-text-input-version=3" 
      '';
    })
  ];

}
