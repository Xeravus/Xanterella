{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      soomfon = {
        enable = lib.mkEnableOption "Aktiviert soomfon";
      };
    };
  };

  config = lib.mkIf config.xanterella.soomfon.enable {
    environment = {
      systemPackages = with pkgs; [
        streamcontroller
      ];
    };
    programs = {
      streamdeck-ui = {
        enable = true;
        autoStart = true; # optional
      };
    };
    services = {
      udev = {
        extraRules = ''
          SUBSYSTEM=="usb", ATTR{idVendor}=="5376", ATTR{idProduct}=="12289", MODE="0666", GROUP="plugdev"
        '';
      };
    };
  };
}
