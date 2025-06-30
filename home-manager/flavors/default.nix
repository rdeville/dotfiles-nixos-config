{lib, ...}: {
  imports = [
    ./_accounts
    ./_core
    ./_gui
    ./audio
    ./bluetooth
    ./discord
    ./docker
    ./gh
    ./glab
    ./kubernetes-client
    ./latex
    ./nextcloud-client
    ./ollama
    ./opentofu
    ./podman
    ./spotify-player
    ./ssh-client
    ./terraform
    ./terragrunt
    ./vscode
  ];

  options = {
    hm = {
      flavors = lib.mkOption {
        type = lib.types.submodule {};
        description = "Install Home-Manager flavors.";
        default = {};
      };
    };
  };
}
