{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      brightnessctl = {
        enable = lib.mkEnableOption "Aktiviert brightnessctl";
      };
    };
  };

  config = lib.mkIf config.xanterella.brightnessctl.enable {
    environment = {
      systemPackages = with pkgs; [
        brightnessctl
      ];
    };
  };
}
