{lib, ...}: let
  readPubKey = path: lib.removeSuffix "\n" (builtins.readFile path);
in [
  # WARNING ID = "1" IS RESERVED
  # Indeed, this ID will be used for peers IPs of the form "1.2.3.ID/32", but
  # wireguard server will have IP "1.2.3.1/24"
  {
    id = "1.11";
    pubKey = readPubKey ./peers/rey.pub;
  }
]
