[
  # Kenobi WM
  {
    AllowedIPs = "172.30.160.201/32";
    PublicKey = ../../microvms/k8s-dev/_keys/wg-k8s-dev.pub;
  }
  # Rey VM
  {
    AllowedIPs = "172.30.160.203/32";
    PublicKey = ../../../rey/microvms/k8s-dev/_keys/wg-k8s-dev.pub;
  }
  # Rey
  {
    AllowedIPs = "172.30.160.3/32";
    PublicKey = ../../../rey/_keys/wg-k8s-dev.pub;
  }
]
