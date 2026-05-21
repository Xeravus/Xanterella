{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      audiobookshelf = {
        enable = true;
      };
      caddy = {
        enable = true;
      };
      grafana = {
        enable = true;
      };
      pihole = {
        enable = true;
      };
      syncthing = {
        enable = true;
      };
      vaultwarden = {
        enable = true;
      };
      fastfetch = {
        enable = true;
      };
    };
  };
}
