{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      gnome = {
        enable = lib.mkEnableOption "Aktiviert gnome";
      };
    };
  };

  config = lib.mkIf config.xanterella.gnome.enable {
    environment = {
      systemPackages = with pkgs; [
        gnome-tweaks
        gnome-extension-manager
      ];
    };
    environment = {
      gnome = {
        excludePackages = with pkgs; [
          gnome-tour
          geary
          epiphany
        ];
      };
    };
    services = {
      libinput = {
        enable = true;
      };
    };
  };
}
