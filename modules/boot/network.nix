{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.network.enable = lib.mkEnableOption "Aktiviert network";
  };

  config = lib.mkIf config.xanterella.network.enable {
    networking = {
      networkmanager = {
        enable = true;
        insertNameservers = [
          "1.1.1.1"
          "1.0.0.1"
          "8.8.8.8"
        ];
      };
    };
  };
}
