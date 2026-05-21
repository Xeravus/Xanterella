{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot.nix
    ./../../profiles/essentials.nix
    ./../../profiles/apps.nix
    ./../../profiles/desktop.nix
    ./../../profiles/hyprland.nix
    ./../../profiles/dev.nix
    ./../../profiles/vault.nix
    ./../../profiles/cybersec.nix
    ./../../profiles/creative.nix
    ./../../profiles/gaming.nix
  ];
  xanterella = {
    apps-xeravus = {
      enable = true;
    };
  };
  boot = {
    binfmt = {
      emulatedSystems = ["aarch64-linux"];
    };
  };
  networking = {
    hostName = "xeravus";
  };
  system = {
    stateVersion = "25.11"; # Did you read the comment?
  };
}
