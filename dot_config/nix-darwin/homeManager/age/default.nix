{
config,
pkgs,
...
}: {
  age = {
    identityPaths = [ "/Users/dev/.ssh/id_rsa" ];
    secrets = {
      mcp.file = ../../secrets/mcp.age;
    };
  };
}
