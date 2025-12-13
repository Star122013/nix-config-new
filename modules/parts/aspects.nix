{ inputs, ... }:
{
  systems = [
    "x86_64-linux"
  ];
  imports = [
    inputs.flake-aspects.flakeModule
  ];
}
