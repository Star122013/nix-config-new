{ inputs, ... }:
{
  imports = [ inputs.git-hooks-nix.flakeModule ];
  perSystem =
    {
      config,
      pkgs,
      ...
    }:
    {
      pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
      devShells.default = pkgs.mkShell {
        name = "UwU nix shell";
        meta.description = "Shell environment for modifying this Nix configuration";
        packages = with pkgs; [
          lua
          lua-language-server
          stylua

          just
          nixd
          nil
          nixfmt-rfc-style
          nix-output-monitor
          alejandra
          statix
          deadnix
          config.pre-commit.settings.enabledPackages
        ];
        shellHook = ''
          ${config.pre-commit.installationScript}
          echo 1>&2 "🐼: $(id -un) | 🧬: $(nix eval --raw --impure --expr 'builtins.currentSystem') | 🐧: $(uname -r) "
          echo 1>&2 "Ready to work on dots!"
        '';
      };
    };
}
