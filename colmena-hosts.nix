{
  inputs,
  systemarch,
  taruser,
  commonSSHKeys,
  pkgs-new,
  pkgs-unstable,
  ...
}: {
  meta = {
    nixpkgs = import inputs.nixpkgs {
      system = systemarch;
      config.allowUnfree = true;
      purity = "impure";
    };
    nodeNixpkgs = {
      vicuna = import nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };
    };
    specialArgs = {inherit inputs pkgs-new pkgs-unstable;};
  };
  xeravus = {
    deployment = {
      targetHost = null;
      allowLocalDeployment = true;
      buildOnTarget = true;
    };
    imports = [
      ./profiles/ssh-keys.nix
      ./hosts/xeravus/configuration.nix
    ];
  };
  xorus = {
    deployment = {
      targetHost = "192.168.178.69";
      targetUser = taruser;
      buildOnTarget = false;
      keys = commonSSHKeys;
    };
    imports = [
      ./profiles/ssh-keys.nix
      ./hosts/xorus/configuration.nix
    ];
  };
  vicuna = {
    deployment = {
      targetHost = "192.168.178.30";
      targetUser = taruser;
      buildOnTarget = false;
      keys = commonSSHKeys;
    };
    imports = [
      ./profiles/ssh-keys.nix
      inputs.nixos-hardware.nixosModules.raspberry-pi-5
      ./hosts/vicuna/configuration.nix
    ];
  };
}
