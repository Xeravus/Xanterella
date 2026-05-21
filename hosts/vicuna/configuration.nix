{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot-server.nix
    ./../../profiles/essentials.nix
    ./../../profiles/server.nix
  ];
  networking = {
    hostName = "vicuna";
  };
  xanterella = {
    boot = {
      enable = lib.mkForce false;
    };
  };
  fileSystems = {
    "/mnt/server-data" = {
      device = "/dev/disk/by-uuid/1046B06546B04CEA";
      fsType = "ntfs";
      options = [
        "defaults"
        "nofail"
        "x-systemd.device-timeout=5s"
      ];
    };
  };
  system = {
    stateVersion = "25-11";
  };
}
