{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      apps-xeravus = {
        enable = lib.mkEnableOption "Aktiviert die Apps für Xeravus";
      };
      apps-xorus = {
        enable = lib.mkEnableOption "Aktiviert die Apps für Xorus";
      };
      apps-crylia = {
        enable = lib.mkEnableOption "Aktiviert die Apps für Crylia";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.apps-xeravus.enable {
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
        fastfetch = {
          enable = true;
        };
        gparted = {
          enable = true;
        };
        nitch = {
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
    })
    (lib.mkIf config.xanterella.apps-xorus.enable {
      xanterella = {
        browser = {
          librewolf = {
            enable = true;
          };
        };
        fastfetch = {
          enable = true;
        };
        nitch = {
          enable = true;
        };
        pomodoro = {
          enable = true;
        };
        reddit = {
          enable = true;
        };
      };
    })
    (lib.mkIf config.xanterella.apps-crylia.enable {
      xanterella = {
        fastfetch = {
          enable = true;
        };
        nix-setup = {
          enable = true;
        };
        browser = {
          librewolf = {
            enable = true;
          };
        };
      };
    })
  ];
}
