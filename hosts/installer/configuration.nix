{
  config,
  pkgs,
  inputs,
  ...
}: let
  secrets = import "/home/cato/nixos-config/modules/agenix/usb-secrets.nix";
in {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    ./../../profiles/installer.nix
  ];
  isoImage = {
    squashfsCompression = "zstd";
  };

  networking = {
    wireless = {
      enable = true;
      networks = {
        "${secrets.wifiSsid}" = {
          psk = secrets.wifiPassword;
        };
      };
    };
    networkmanager = {
      enable = false;
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

          ${pkgs.tailscale}/bin/tailscale up --authkey="${secrets.tailscalekey}" --unattended
        '';
      };
    };
  };
}
