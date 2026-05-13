{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.pomodoro.enable = lib.mkEnableOption "Aktiviert pomodoro";
  };

  config = lib.mkIf config.xanterella.pomodoro.enable {
    environment.systemPackages = with pkgs; [
      pom
    ];
  };
}
