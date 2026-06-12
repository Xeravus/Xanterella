{
  config,
  pkgs-unstable,
  lib,
  ...
}: {
  options = {
    xanterella = {
      reddit = {
        enable = lib.mkEnableOption "Aktiviert reddit";
      };
    };
  };

  config = lib.mkIf config.xanterella.reddit.enable {
    environment = {
      systemPackages = with pkgs-unstable; [
        reddit-tui
      ];
    };
  };
}
