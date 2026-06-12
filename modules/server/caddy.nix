{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      caddy = {
        enable = lib.mkEnableOption "Aktiviert caddy";
      };
    };
  };

  config = lib.mkIf config.xanterella.caddy.enable {
    environment = {
      systemPackages = with pkgs; [
        caddy
      ];
    };
    services = {
      caddy = {
        enable = true;
        virtualHosts = {
          "vicuna.gute-nessie.ts.net" = {
            extraConfig = ''
                        handle /audiobookshelf* {
              reverse_proxy localhost:13378 # Audiobookshelf
                        }
                 handle /* {
              reverse_proxy localhost:8222 # Vaultwarden(Zumindest bald)
                        }
            '';
          };
        };
      };
      tailscale = {
        permitCertUid = "caddy";
      };
    };
  };
}
