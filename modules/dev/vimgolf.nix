{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      vimgolf = {
        enable = lib.mkEnableOption "Aktiviert vimgolf";
      };
    };
  };

  config = lib.mkIf config.xanterella.vimgolf.enable {
    environment = {
      systemPackages = with pkgs; [
        vimgolf
      ];
    };
  };
}
