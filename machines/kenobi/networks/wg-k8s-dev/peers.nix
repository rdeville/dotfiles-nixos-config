{lib, ...}: let
  readPubKeys = file: lib.removeSuffix "\n" (builtins.readFile file);
in [
  # Kenobi WM
  {
    AllowedIPs = "172.30.160.201/32";
    PublicKey = readPubKeys (../../microvms/k8s-dev/_keys/wg-k8s-dev.pub);
  }
  # Rey VM
  {
    AllowedIPs = "172.30.160.203/32";
    PublicKey = readPubKeys (../../../rey/microvms/k8s-dev/_keys/wg-k8s-dev.pub);
  }
  # Rey
  {
    AllowedIPs = "172.30.160.3/32";
    PublicKey = readPubKeys (../../../rey/_keys/wg-k8s-dev.pub);
  }
]
