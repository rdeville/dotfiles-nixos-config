{inputs, ...}: let
  pkgsForSystem = system:
    import nixpkgs {
      inherit system;
      overlays = [nixgl.overlay];
      config = {
        allowUnfree = true;
      };
    };

  mkDebug = data: builtins.trace (builtins.toJSON data);

  mkImportDir = dir:
    if builtins.pathExists dir
    then
      builtins.map (
        file: "${dir}/${file}"
      ) (builtins.attrNames (builtins.readDir dir))
    else [];

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
          # TODO: Move this inputs to another folder
          # direnv.homeManagerModules.direnv
        ]
        ++ userCfg.modules;
      extraSpecialArgs = {
        mkLib = lib;
        inherit pkgs userCfg colors;
      };
    };

  nixGLWrap = pkg: cfg: let
    pkgs = pkgsForSystem cfg.system;
  in
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${pkgs.lib.getExe' pkgs.nixgl.auto.nixGLDefault "nixGL"} $bin \"\$@\"" > $wrapped_bin
      chmod +x $wrapped_bin
      done
    '';

  lib = {
    inherit
      mkDebug
      mkImportDir
      mkHomeConfigs
      mkHomeConfiguration
      mkRepos
      pkgsForSystem
      nixGLWrap
      ;
  };
in
  lib
