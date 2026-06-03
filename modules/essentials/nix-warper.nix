{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      nix-warper = {
        enable = lib.mkEnableOption "Aktiviert nix-warper";
      };
    };
  };

  config = lib.mkIf config.xanterella.nix-switcher.enable {
    environment = {
      systemPackages = [
        inputs.nix-programs.packages.${pkgs.system}.warper
      ];
    };
  };
}
