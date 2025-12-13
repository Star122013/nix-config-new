update:
    nix flake update --option access-tokens "github.com=$(gh auth token)"
rebuild:
    nh os switch --show-trace --ask
push:
    git add . && gitmoji -c && git push
