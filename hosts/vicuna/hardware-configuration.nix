{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_rpi4;
  boot.extraModulePackages = [];
  boot.supportedFilesystems = lib.mkForce ["vfat" "ext4" "ntfs3" "ntfs-3g"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.end0.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
