{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.remote-install;
  remote-install = pkgs.writeShellScriptBin "remote-install" ''
    if [ -z "$1" ]; then
      echo "Fehler: Bitte die Tailscale-IP des USB-Sticks angeben!"
      echo "Benutzung: ./install-remote.sh 100.x.y.z"
      exit 1
    fi

    TARGET_IP=$1

    cd
    cd nixos-config
    echo "Starte Installation auf $TARGET_IP..."
    ssh root@$TARGET_IP 'echo "unsetopt nomatch" > ~/.zshenv'
    notify-send "Starte Remote-Install"
    sleep 3
    nix run github:numtide/nixos-anywhere -- --flake .#crylia root@$TARGET_IP
    notify-send "Beendet Remote-Install"
  '';
in {
  options = {
    xanterella = {
      remote-install = {
        enable = lib.mkEnableOption "Aktiviert das Remote-Install Script";
      };
    };
  };
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        remote-install
      ];
    };
  };
}
