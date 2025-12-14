{ inputs, ... }:
{
  systems = [
    "x86_64-linux"
  ];
  debug = true;
  imports = [
    inputs.flake-aspects.flakeModule
  ];
}
