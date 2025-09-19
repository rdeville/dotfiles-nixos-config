{lib, ...}: {
  imports = [
    ./_core
    ./audio
    ./display-manager
    ./docker
    ./k3s
    ./openbao
    ./printing
    ./ssh-server
    ./steam
    ./window-manager
    ./network
  ];
}
