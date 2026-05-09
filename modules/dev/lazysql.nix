{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.lazysql.enable = lib.mkEnableOption "Aktiviert lazysql";
  };

  config = lib.mkIf config.xanterella.lazysql.enable {
    environment.systemPackages = with pkgs; [
      lazysql
    ];
  };
}
