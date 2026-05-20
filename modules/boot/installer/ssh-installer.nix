{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      ssh-installer = {
        enable = lib.mkEnableOption "Aktiviert Openssh für den Installer";
      };
    };
  };

  config = lib.mkIf config.xanterella.ssh-installer.enable {
    services = {
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "yes";
        };
      };
    };
  };
}
