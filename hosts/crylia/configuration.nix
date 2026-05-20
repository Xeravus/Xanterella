{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./../../modules
    ./../../profiles/boot.nix
    ./../../profiles/essentials.nix
    ./../../profiles/desktop.nix
    ./disko.nix
  ];
  networking.hostName = "crylia";
  system.stateVersion = "25.11"; # Did you read the comment?
}
