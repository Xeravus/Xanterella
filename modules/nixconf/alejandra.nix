{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  inputs,
  ...
}: {
  options = {
    xanterella = {
      alejandra = {
        enable = lib.mkEnableOption "Aktiviert Alejandra";
      };
    };
  };

  config = lib.mkIf config.xanterella.alejandra.enable {
    environment = {
      systemPackages = with pkgs-unstable; [
        inputs.alejandra.defaultPackage.${pkgs.system}
      ];
    };
  };
}
