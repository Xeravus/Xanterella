{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.nodejs.enable = lib.mkEnableOption "Aktiviert nodejs";
  };

  config = lib.mkIf config.xanterella.nodejs.enable {
    environment.systemPackages = with pkgs; [
      nodejs
    ];
  };
}
