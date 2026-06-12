{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    xanterella = {
      ani-cli = {
        enable = true;
      };
      browser = {
        zen = {
          enable = true;
        };
        firefox = {
          enable = true;
        };
        librewolf = {
          enable = true;
        };
      };
      brightnessctl = {
        enable = true;
      };
      fastfetch = {
        enable = true;
      };
      gparted = {
        enable = true;
      };
      nitch = {
        enable = true;
      };
      soomfon = {
        enable = true;
      };
      pomodoro = {
        enable = true;
      };
      reddit = {
        enable = true;
      };
      spicetify = {
        enable = true;
      };
    };
  };
}
