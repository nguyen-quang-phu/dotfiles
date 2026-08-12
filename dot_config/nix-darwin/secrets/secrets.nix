let
  keynold = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINdjYsihZsFgs5NfhhIO0vNLFjIGi7pchc8DpZd6jE4C";
  users = [ keynold ];

  # system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJDyIr/FSz1cJdcoW69R+NrWzwGK/+3gJpqD1t8L2zE";
  # system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  # systems = [ system1 system2 ];
in
{
  "mcp.age".publicKeys = users;
}
