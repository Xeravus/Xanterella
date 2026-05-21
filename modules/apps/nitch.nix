{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      nitch = {
        enable = lib.mkEnableOption "Aktiviert nitch";
      };
    };
  };

  config = lib.mkIf config.xanterella.nitch.enable {
    environment = {
      systemPackages = with pkgs; [
        nitch
      ];
    };
  };
}
