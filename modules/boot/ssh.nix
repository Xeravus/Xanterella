{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.ssh.enable = lib.mkEnableOption "Aktiviert ssh";
  };

  config = lib.mkIf config.xanterella.ssh.enable {
    environment.systemPackages = with pkgs; [
      openssh
      kitty.terminfo
    ];
    services = {
      openssh = {
        enable = true;
        authorizedKeysFiles = lib.mkForce [
          "/etc/ssh/authorized_keys.d/%u"
          ".ssh/authorized_keys"
        ];
      };
    };
  };
}
