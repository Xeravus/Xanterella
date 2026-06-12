{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      hydra = {
        enable = lib.mkEnableOption "Aktiviert hydra";
      };
    };
  };

  config = lib.mkIf config.xanterella.hydra.enable {
    environment = {
      systemPackages = with pkgs; [
        thc-hydra
      ];
    };
  };
}
