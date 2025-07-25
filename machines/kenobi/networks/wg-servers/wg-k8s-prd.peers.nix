[
  # KENOBI WM
  {
    AllowedIPs = "172.30.128.201/32";
    PublicKey = ../../microvms/k8s-prd/_keys/wg-k8s-prd.pub;
  }
  # REY
  {
    AllowedIPs = "172.30.128.3/32";
    PublicKey = ../../../rey/_keys/wg-k8s-prd.pub;
  }
  # LILITH
  {
    AllowedIPs = "172.30.128.21/32";
    PublicKey = ../../../lilith/_keys/wg-k8s-prd.pub;
  }
  # MAYA
  {
    AllowedIPs = "172.30.128.22/32";
    PublicKey = ../../../maya/_keys/wg-k8s-prd.pub;
  }
  # AVA
  {
    AllowedIPs = "172.30.128.23/32";
    PublicKey = ../../../ava/_keys/wg-k8s-prd.pub;
  }
]
