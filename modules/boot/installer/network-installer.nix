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
      network-installer = {
        enable = lib.mkEnableOption "Aktiviert Network Manager mit automatischen Wlan Passwort";
      };
    };
  };

  config = lib.mkIf config.xanterella.network-installer.enable {
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
  };
}
