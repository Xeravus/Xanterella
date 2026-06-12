{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    xanterella = {
      power-profiles-daemon = {
        enable = lib.mkEnableOption "Aktiviert Power Profiles Daemon";
      };
    };
  };

  config = lib.mkIf config.xanterella.power-profiles-daemon.enable {
    services = {
      power-profiles-daemon = {
        enable = true;
      };
    };
  };
}
