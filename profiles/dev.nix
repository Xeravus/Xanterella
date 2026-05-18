{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      lazysql.enable = true;
      nix-review.enable = true;
      nodejs.enable = true;
      vimgolf.enable = true;
      vscode.enable = true;
    };
  };
}
