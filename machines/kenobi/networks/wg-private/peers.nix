{lib, ...}: let
  readPubKeys = file: lib.removeSuffix "\n" (builtins.readFile file);
in [
  {
    AllowedIPs = "172.18.0.3/32";
    PublicKey = readPubKeys (../../../rey/_keys/wg-private.pub);
  }
]
