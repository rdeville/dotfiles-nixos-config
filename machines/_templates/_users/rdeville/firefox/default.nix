{config, ...}: let
  profile =
    if config.hm.isWork
    then "pro"
    else "perso";
in {
  imports = [
    ./plugins/envmarker.nix
    ./plugins/sidebery.nix
  ];

  programs = {
    firefox = {
      profiles = {
        ${profile} = {
          extensions = {
            force = true;
          };
        };
      };
    };
  };
}
