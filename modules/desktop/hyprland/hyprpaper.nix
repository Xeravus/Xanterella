{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.hyprpaper;
in {
  options = {
    xanterella = {
      hyprpaper = {
        enable = lib.mkEnableOption "Aktiviert Hyprpaper";
      };
    };
  };
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        hyprpaper
      ];
    };
  };
}
