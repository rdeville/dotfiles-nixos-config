{
  self,
  inputs,
  config,
  lib,
  ...
}: let
  isProd = config.os.isProd;
  parentName = config.os.hostName;
  vmName = "vm-${parentName}-${builtins.baseNameOf ./.}";
  imports =
    if isProd
    then [
      inputs.nixos-stable.nixosModules.os
    ]
    else [
      inputs.nixos.nixosModules.os
    ];
in {
  imports = [
    ./host
  ];

  microvm = {
    vms = {
      ${vmName} = {
        specialArgs = {
          inherit inputs lib self;
        };

        config = {config, ...}: {
          imports =
            [
              inputs.sops-nix.nixosModules.sops
              inputs.nix-topology.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              ./configuration.nix
              ./topology.nix
              ./networks.nix
            ]
            ++ imports;

          os = {
            inherit isProd parentName;
            hostName = vmName;
          };
        };
      };
    };
  };
}
