{ ... }:
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
        cfg = config.shell.git;
      in
      {
        options.shell.git = {
          enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable git.";
          };
          name = mkOption {
            type = types.str;
            default = false;
            description = "Sets your username for git.";
          };
          email = mkOption {
            type = types.str;
            default = false;
            description = "Sets your email for git.";
          };
        };

        config = mkIf cfg.enable {
          hj = {
            packages = with pkgs; [
              git
              lazygit
              gitmoji-cli
            ];
          };
          programs.git = {
            enable = true;
            config = {
              user = {
                inherit (cfg) name email;
              };
              init = {
                defaultBranch = "main";
              };
              url = {
                "https://github.com/" = {
                  insteadOf = [
                    "gh:"
                    "github:"
                  ];
                };
                "https://gitlab.com/" = {
                  insteadOf = [
                    "gl:"
                    "gitlab:"
                  ];
                };
              };
            };
          };
        };
      };
  };
}
