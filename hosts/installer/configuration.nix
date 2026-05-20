{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  secrets = import "/home/cato/nixos-config/modules/agenix/usb-secrets.nix";
in {
  imports = [
    ./../../modules
    ./../../profiles/installer.nix
    ./../../profiles/gnome.nix
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  isoImage = {
    squashfsCompression = "zstd";
  };
}
