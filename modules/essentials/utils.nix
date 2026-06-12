{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    xanterella = {
      utils = {
        enable = lib.mkEnableOption "Aktiviert Utilities";
      };
    };
  };

  config = lib.mkIf config.xanterella.utils.enable {
    environment = {
      systemPackages = with pkgs; [
        pciutils
        usbutils
      ];
    };
  };
}
