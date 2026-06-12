{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      proxychains = {
        enable = lib.mkEnableOption "Aktiviert proxychains";
      };
    };
  };

  config = lib.mkIf config.xanterella.proxychains.enable {
    environment = {
      systemPackages = with pkgs; [
        proxychains
      ];
    };
  };
}
