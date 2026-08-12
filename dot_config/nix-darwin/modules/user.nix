{
pkgs,
...
}: {
  users.users.dev = {
    description = "dev user";
    home = "/Users/dev";
    shell = pkgs.zsh;
  };
}
