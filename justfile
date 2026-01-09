update:
    nix flake update --option access-tokens "github.com=$(gh auth token)"
reboot:
    nh os boot . --show-trace --ask && reboot
push:
    git add . && gitmoji -c && git push
switch:
    nh os switch . --show-trace --ask
renc:
  nix run .#vaultix.app.x86_64-linux.renc
