{config, ...}: {
  # Firewall configurations
  allowedUDPPorts = [
    # Cilium Port
    # See: https://docs.cilium.io/en/stable/operations/system_requirements/
    8472 # Cilium VXLan Overlay
    51871 # Cilium Wireguard
  ];
  allowedTCPPorts =
    [
      6443 # Kube API
      # Cilium Port
      # See: https://docs.cilium.io/en/stable/operations/system_requirements/
      9965 # Hubble metrics
      4222 # Hubble health
      4245 # Hubble relay
      4240 # Cilium health
      10250 # Cilium metrics
    ]
    ++ (
      if config.services.k3s.role == "server"
      then [
        2379 # Kube ETCD
        2380 # Kube ETCD
      ]
      else []
    );
  # See: https://github.com/cilium/cilium/issues/27900#issuecomment-2572253315
  trustedInterfaces = [
    "cilium_wg*"
    "cilium_net*"
    "cilium_host*"
    "cilium_vxlan"
    "lxc*"
  ];
}
