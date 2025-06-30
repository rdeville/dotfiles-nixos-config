{lib, ...}: {
  imports = [
    ./_core
    ./audio
    ./display-manager
    ./docker
    ./k3s
    ./printing
    ./ssh-server
    ./steam
    ./window-manager
  ];

  options = {
    os = {
      flavors = lib.mkOption {
        type = lib.types.submodule {};
        description = "Install NixOS flavors.";
        default = {};
      };
    };
  };
}
