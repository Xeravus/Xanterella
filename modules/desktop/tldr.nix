{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      tldr = {
        enable = lib.mkEnableOption "Aktiviert tldr";
      };
    };
  };

  config = lib.mkIf config.xanterella.tldr.enable {
    environment = {
      systemPackages = with pkgs; [
        tldr
      ];
    };
  };
}
