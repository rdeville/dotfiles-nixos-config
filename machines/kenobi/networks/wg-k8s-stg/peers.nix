{lib, ...}: let
  readPubKeys = file: lib.removeSuffix "\n" (builtins.readFile file);
in [
  # Kenobi WM
  {
    AllowedIPs = "172.30.144.201/32";
    PublicKey = readPubKeys (../../microvms/k8s-stg/_keys/wg-k8s-stg.pub);
  }
  # Rey
  {
    AllowedIPs = "172.30.144.3/32";
    PublicKey = readPubKeys (../../../rey/_keys/wg-k8s-stg.pub);
  }
]
