{ ... }:
{
  flake.aspects.shell = {
    nixos =
      {
        config,
        lib,
        ...
      }:
      let
        inherit (lib) mkOption types mkIf;
        cfg = config.shell.ssh;
      in
      {
        options.shell.ssh = {
          enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable shell.ssh.";
          };
        };

        config = mkIf cfg.enable {
          programs.ssh = {
            extraConfig = ''
              Host github.com
                IdentityFile ${config.vaultix.secrets."gh-ssh".path}
                IdentitiesOnly yes
            '';
          };
        };
      };
  };
}
