{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  options = {
    xanterella = {
      agenix = {
        enable = lib.mkEnableOption "Aktiviert agenix";
      };
    };
  };
  imports = [
    inputs.agenix.nixosModules.default
  ];

  config = lib.mkIf config.xanterella.agenix.enable {
    environment = {
      systemPackages = with pkgs; [
        inputs.agenix.packages.${pkgs.system}.default
      ];
    };
  };
}
