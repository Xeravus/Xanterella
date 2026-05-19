{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./../../modules
    ./../../profiles/boot.nix
    ./../../profiles/essentials.nix
  ];
  networking.hostName = "willma";
  system.stateVersion = "25.11"; # Did you read the comment?
}
