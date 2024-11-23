{inputs, ...}: let
  home-manager = inputs.home-manager;
  sops-nix = inputs.sops-nix;
  colors = import ../colors;

  pkgsForSystem = (import ./. {inherit inputs;}).pkgsForSystem;
  mkDebug = (import ./. {inherit inputs;}).mkDebug;
  mkImportDir = (import ./. {inherit inputs;}).mkImportDir;

  option = name: item:
    if "${name}" ? item
    then {"${name}" = item.${name};}
    else {};

  mkRepos = repos:
    builtins.mapAttrs (name: repo: {
      enable = repo.enable;
      source = builtins.fetchGit {url = repo.url;} // (option "ref" repo) // (option "rev" repo);
      target =
        if "target" ? repo
        then repo.target
        else name;
    })
    repos;

  mkHomeUsers = cfg: hostname:
    builtins.map (username: {
      name = "${username}@${hostname}";
      value = cfg.hosts.${hostname}.users.${username};
    }) (builtins.attrNames cfg.hosts.${hostname}.users);

  # Convert hosts config from ./config.nix into a home-manager format such as:
  # {
  #   user@hostname = {
  #     username = username
  #     hostname = hostname
  #     configuration
  #   };
  # };
  mkHomeConfigs = cfg:
    builtins.listToAttrs (
      builtins.foldl' (acc: elem: acc ++ elem) [] (
        builtins.map (hostname: mkHomeUsers cfg hostname) (builtins.attrNames cfg.hosts)
      )
    );

  mkHomeConfiguration = userCfg:
    home-manager.lib.homeManagerConfiguration rec {
      pkgs = pkgsForSystem userCfg.system;
      modules =
        [
          # External Modules
          sops-nix.homeManagerModules.sops
          # Internal Modules
          ../home-manager
        ]
        ++ userCfg.modules;
      extraSpecialArgs = {
        mkLib = lib;
        inherit pkgs userCfg colors;
      };
    };

  lib = {
    inherit
      mkDebug
      mkImportDir
      mkHomeConfigs
      mkHomeConfiguration
      mkRepos
      pkgsForSystem
      ;
  };
in
  lib
