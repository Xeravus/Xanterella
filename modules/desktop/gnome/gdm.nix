{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      gdm = {
        enable = lib.mkEnableOption "Aktiviert gdm";
      };
    };
  };

  config = lib.mkIf config.xanterella.gdm.enable {
    services = {
      xserver = {
        enable = true;
        desktopManager = {
          gnome = {
            enable = true;
          };
        };
        displayManager = {
          gdm = {
            enable = true;
          };
        };
      };
    };
  };
}
