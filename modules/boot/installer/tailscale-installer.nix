{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = import "/home/cato/nixos-config/agenix/usb-secrets.nix";
in {
  options = {
    xanterella = {
      tailscale-installer = {
        enable = lib.mkEnableOption "Aktiviert Tailscale autoconnect";
      };
    };
  };

  config = lib.mkIf config.xanterella.tailscale-installer.enable {
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
  };
}
