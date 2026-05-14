{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.audiobookshelf.enable = lib.mkEnableOption "Aktiviert audiobookshelf";
  };

  config = lib.mkIf config.xanterella.audiobookshelf.enable {
    environment.systemPackages = with pkgs; [
      audiobookshelf
    ];
    fileSystems."/var/lib/audiobookshelf" = {
      device = "/mnt/server-data/nix/audiobookshelf";
      options = ["bind"];
      # Sagt NixOS, dass es erst die Hauptfestplatte mounten muss, bevor dieser Mount passiert
      depends = ["/mnt/server-data"];
    };
    services = {
      audiobookshelf = {
        enable = true;
        host = "0.0.0.0";
        port = 13378;
        openFirewall = true;
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [
          13378
        ];
      };
    };
  };
}
