{
  config,
  pkgs,
  lib,
  ...
}: let
  secrets = import "/home/cato/nixos-config/agenix/usb-secrets.nix";
in {
  options = {
    xanterella = {
      tailscale = {
        enable = lib.mkEnableOption "Aktiviert tailscale";
      };
      tailscale-installer = {
        enable = lib.mkEnableOption "Aktiviert Tailscale für dne Installer mit autoconnect";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.tailscale.enable {
      environment.systemPackages = with pkgs; [
        tailscale
      ];
      services = {
        tailscale = {
          enable = true;
        };
        resolved = {
          enable = true;
        };
      };
      networking = {
        nameservers = [
          "100.100.100.100"
          "1.1.1.1"
          "1.0.0.1"
          "8.8.8.8"
        ];
        search = [
          "gute-nessie.ts.net"
        ];
      };
    })
    (lib.mkIf config.xanterella.tailscale-installer.enable {
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
    })
  ];
}
