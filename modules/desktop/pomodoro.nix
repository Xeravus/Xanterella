{
  config,
  pkgs,
  lib,
  pkgs-25-11,
  inputs,
  ...
}: let
  pomo = pkgs-25-11.buildGoModule {
    pname = "pomo";
    version = "latest";
    src = inputs.pomo-src;
    vendorHash = "sha256-kbTYq4Xc86bcmNMhInq1rwYTbGRmu2TEXT2e7bqT5YY=";
  };
in {
  options = {
    xanterella.pomodoro.enable = lib.mkEnableOption "Aktiviert pomodoro";
  };

  config = lib.mkIf config.xanterella.pomodoro.enable {
    environment.systemPackages = [
      pkgs.pom
      pomo
    ];
  };
}
