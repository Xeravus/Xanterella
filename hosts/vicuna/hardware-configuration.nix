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

  # Boot-Kernel-Module für USB-Speicher und SD-Karten
  boot.initrd.availableKernelModules = ["xhci_pci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  # Root-Dateisystem (Standard-Label für das generische NixOS ARM Image)
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  # DEINE EXTERNE FESTPLATTE
  # Hier musst du später die echte UUID mit 'lsblk -f' ermitteln
  fileSystems."/mnt/server-data" = {
    device = "/dev/disk/by-uuid/HIER_DEINE_UUID_EINTRAGEN";
    fsType = "ext4"; # oder ntfs-3g, btrfs, etc.
    options = ["nofail" "defaults"]; # nofail verhindert Boot-Abstürze ohne Platte
  };

  # Da der Pi 5 oft von SD-Karte oder NVMe bootet, ist Swap optional
  swapDevices = [];

  # Architektur für den Raspberry Pi 5
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
