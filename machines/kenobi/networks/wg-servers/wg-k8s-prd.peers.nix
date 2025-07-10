[
  # Kenobi WM
  {
    AllowedIPs = "172.30.128.201/32";
    PublicKey = ../../microvms/k8s-prd/_keys/wg-k8s-prd.pub;
  }
  # Rey
  {
    AllowedIPs = "172.30.128.3/32";
    PublicKey = ../../../rey/_keys/wg-k8s-prd.pub;
  }
]
