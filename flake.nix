{
  description = "Meine NixOs Systeme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-25-11.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-programs.url = "github:TheGoatPrime234/Nixos_programs/stable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    p10k-src = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-programs,
    colmena,
    ...
  } @ inputs: let
    systemarch = "x86_64-linux";
    taruser = "root";
    pkgs-25-11 = import inputs.nixpkgs-25-11 {
      system = systemarch;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      xeravus = nixpkgs.lib.nixosSystem {
        system = systemarch;
        specialArgs = {inherit inputs pkgs-25-11;};
        modules = [
          ./hosts/xeravus/configuration.nix
        ];
      };
      "vicuna-image" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs pkgs-25-11;};
        modules = [
          # Holt sich die Pi 5 spezifischen Treiber und Bootloader
          inputs.nixos-hardware.nixosModules.raspberry-pi-5

          # Das NixOS Basis-Modul zum Erstellen eines SD-Karten-Images
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"

          # Deine fertige Server-Konfiguration!
          ./hosts/vicuna/configuration.nix

          ({
            lib,
            pkgs,
            ...
          }: {
            nixpkgs.config.allowUnfree = true;
            boot.supportedFilesystems = lib.mkForce ["vfat" "ext4" "ntfs3" "ntfs-3g"];

            # WICHTIG: Erzwingt den RPi Vendor-Kernel.
            # (In NixOS 24.11 deckt 'rpi4' auch den Raspberry Pi 5 ab!)
            boot.kernelPackages = lib.mkForce pkgs.linuxPackages_rpi4;

            boot.initrd.availableKernelModules = lib.mkForce [
              "xhci_pci" # USB 3.0
              "usb_storage" # USB-Sticks/Festplatten
              "usbhid" # Tastatur/Maus
              "sd_mod" # SD-Karten-Leser
              "pcie_brcmstb" # Der PCIe-Controller des Raspberry Pi 5
              "nvme" # Wichtig, falls du später eine NVMe-SSD an den Pi 5 hängst
            ];
            sdImage.firmwareSize = 1024;

            xanterella.boot.enable = lib.mkForce false;
          })
        ];
      };
    };
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = systemarch;
          config.allowUnfree = true;
          purity = "impure";
        };
        specialArgs = {inherit inputs pkgs-25-11;};
      };
      xeravus = {
        deployment = {
          targetHost = null;
          allowLocalDeployment = true;
          buildOnTarget = true;
        };
        imports = [
          ./hosts/xeravus/configuration.nix
        ];
      };
      xorus = {
        deployment = {
          targetHost = "192.168.178.69";
          targetUser = taruser;
          buildOnTarget = false;
          keys = {
            "id_ed25519" = {
              keyFile = "/home/cato/.ssh/id_ed25519";
              destDir = "/etc/ssh";
              user = "root";
              group = "root";
              permissions = "0600";
            };
          };
        };
        imports = [
          ./hosts/xorus/configuration.nix
        ];
      };
      vicuna = {
        deployment = {
          targetHost = "192.168.178.78";
          targetUser = taruser;
          buildOnTarget = false;
          keys = {
            "id_ed25519" = {
              keyFile = "/home/cato/.ssh/id_ed25519";
              destDir = "/etc/ssh";
              user = "root";
              group = "root";
              permissions = "0600";
            };
          };
        };
        nodeNixpkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
        imports = [
          inputs.nixos-hardware.nixosModules.raspberry-pi-5
          ./hosts/vicuna/configuration.nix
        ];
      };
    };
  };
}
