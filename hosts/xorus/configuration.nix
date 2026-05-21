{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot.nix
    ./../../profiles/essentials.nix
    ./../../profiles/apps.nix
    ./../../profiles/desktop.nix
    ./../../profiles/gnome.nix
    ./../../profiles/dev.nix
    ./../../profiles/vault.nix
  ];

  xanterella = {
    apps-xorus = {
      enable = true;
    };
  };
  networking = {
    hostName = "xorus";
  };
  system = {
    stateVersion = "25.11"; # Did you read the comment?
  };
}
