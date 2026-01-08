{ inputs, ... }:
{
  flake.aspects.shell = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.shell.tools;
      in
      {
        options.shell.tools = {
          enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable tools.";
          };

        };

        config = mkIf cfg.enable {
          hj = {
            packages = with pkgs; [
              fzf
              fd
              jq
              ripgrep
              eza
              zoxide
              tmux

              inputs.devbox.packages.${pkgs.stdenv.hostPlatform.system}.default
              nix-tree
              nixfmt-rfc-style
              nixd
              statix
              deadnix

              mise
              bat
              btop
              htop

              fastfetch
            ];
            files.".config/eza/theme.yml".source = ./../../dotfiles/eza/theme.yml;
            files.".config/bat".source = ./../../dotfiles/bat;
            files.".config/fastfetch".source = ./../../dotfiles/fastfetch;
          };
        };
      };
  };
}
