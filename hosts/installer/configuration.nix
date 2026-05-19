{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  secrets = import "/home/cato/nixos-config/modules/agenix/usb-secrets.nix";
in {
  imports = [
    inputs.disko.nixosModules.disko
    ./../../modules
    ./../../profiles/installer.nix
    ./../../profiles/gnome.nix
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  isoImage = {
    squashfsCompression = "zstd";
  };

  networking = {
    wireless = {
      enable = false;
    };
    networkmanager = {
      enable = true;
      ensureProfiles = {
        profiles = {
          "${secrets.wifiSsid}" = {
            connection = {
              id = secrets.wifiSsid;
              type = "wifi";
            };
            wifi = {
              mode = "infrastructure";
              ssid = secrets.wifiSsid;
            };
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = secrets.wifiPassword;
            };
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
              method = "auto";
            };
          };
        };
      };
    };
  };
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
    tailscale = {
      enable = true;
    };
  };

  systemd = {
    services = {
      tailscale-autoconnect = {
        description = "Automatische Verbindung für Remote Install";
        after = [
          "tailscaled.service"
          "network-online.target"
        ];
        wants = [
          "tailscaled.service"
          "network-online.target"
        ];
        wantedBy = [
          "multi-user.target"
        ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          until ${pkgs.curl}/bin/curl -s https://login.tailscale.com > /dev/null; do
          sleep 1
          done

          ${pkgs.tailscale}/bin/tailscale up --auth-key "${secrets.tailscalekey}"
        '';
      };
    };
  };
}
