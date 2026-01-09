{ inputs, ... }:
{
  flake.aspects.core = {
    nixos =
      { ... }:
      {
        imports = [ inputs.vaultix.nixosModules.vaultix ];
        vaultix = {
          settings = {
            hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSZ/+M4siGV1Se7Br3smH2pkvkiCNd6G2J0RRe4mtE2 root@Moon"; # required
          };
          secrets = {
            gh-ssh = {
              file = ./../sercet/secrets/github.age;
              owner = "kiana";
            };
          };
        };
      };
  };
}
