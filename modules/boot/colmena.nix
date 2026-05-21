{
  config,
  pkgs,
  lib,
  pkgs-new,
  ...
}: {
  options = {
    xanterella = {
      colmena = {
        enable = lib.mkEnableOption "Aktiviert colmena";
      };
    };
  };

  config = lib.mkIf config.xanterella.colmena.enable {
    environment = {
      systemPackages = with pkgs-new; [
        colmena
        nix-output-monitor
      ];
    };
  };
}
