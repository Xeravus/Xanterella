{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot-server.nix
    ./../../profiles/essentials.nix
    ./../../profiles/server.nix
  ];

  networking.hostName = "vicuna";

  # Die fileSystems Deklaration ist jetzt sauber in die hardware-configuration.nix ausgelagert.
}
