{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.swww;
in {
  options = {
    xanterella = {
      swww = {
        enable = lib.mkEnableOption "Aktiviert Swww";
      };
    };
  };
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        swww
      ];
    };
  };
}
