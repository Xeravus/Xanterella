{
  config,
  pkgs,
  lib,
  pkgs-new,
  ...
}: {
  options = {
    xanterella = {
      quickshell = {
        enable = lib.mkEnableOption "Aktiviert quickshell";
      };
    };
  };

  config = lib.mkIf config.xanterella.quickshell.enable {
    environment = {
      systemPackages = with pkgs-new; [
        quickshell
      ];
    };
    environment = {
      variables = {
        QML_XHR_ALLOW_FILE_READ = "1";
      };
    };
  };
}
