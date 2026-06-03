{
  config,
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
    ./disko.nix
  ];
  xanterella = {
    apps-crylia = {
      enable = true;
    };
  };
  networking = {
    hostName = "crylia";
  };
  system = {
    stateVersion = "25.11"; # Did you read the comment?
  };
}
