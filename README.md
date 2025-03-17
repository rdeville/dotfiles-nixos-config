<!-- BEGIN DOTGIT-SYNC BLOCK MANAGED -->
<!-- markdownlint-disable -->
# 👋 Welcome to NixOS Configuration

<center>

> ⚠️ IMPORTANT !
>
> Main repo is on [framagit.org](https://framagit.org/rdeville-public/dotfiles/nixos-config).
>
> On other online git platforms, they are just mirror of the main repo.
>
> Any issues, pull/merge requests, etc., might not be considered on those other
> platforms.

</center>

---

<center>

[![Licenses: (MIT OR BEERWARE)][license_badge]][license_url]
[![Changelog][changelog_badge]][changelog_badge_url]
[![Build][build_badge]][build_badge_url]
[![Release][release_badge]][release_badge_url]

</center>

[build_badge]: https://framagit.org/rdeville-public/dotfiles/nixos-config/badges/main/pipeline.svg
[build_badge_url]: https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commits/main
[release_badge]: https://framagit.org/rdeville-public/dotfiles/nixos-config/-/badges/release.svg
[release_badge_url]: https://framagit.org/rdeville-public/dotfiles/nixos-config/-/releases/
[license_badge]: https://img.shields.io/badge/Licenses-MIT%20OR%20BEERWARE-blue
[license_url]: https://framagit.org/rdeville-public/dotfiles/nixos-config/blob/main/LICENSE
[changelog_badge]: https://img.shields.io/badge/Changelog-Python%20Semantic%20Release-yellow
[changelog_badge_url]: https://github.com/python-semantic-release/python-semantic-release

Repository storing my NixOS and Home Manager configurations

---
<!-- BEGIN DOTGIT-SYNC BLOCK EXCLUDED CUSTOM_README -->
## 📌 Prerequisites

In order to use this repos, you must either be :

* On a [NixOS](https://nixos.org/) system to use NixOS configurations or
  Home-Manager configurations.
* On any Linux OS with [Nix](https://nixos.org/download/) installed with
  [Home-Manager](https://nix-community.github.io/home-manager/).

Optionally, to automate the setup of this repository, you can use following
packages :

* [direnv](https://github.com/direnv/direnv)
* [devbox](https://www.jetify.com/devbox)

## 🚀 Usage

If using automation, this will automatically allow to access following tooling
scripts (theses are also in folder `scripts/`):

* `hm`: wrapper to manage Home-Manager config
* `iso`: wrapper to manage ISOs config
* `os`: wrapper to manage NixOS config
* `vm`: wrapper to manage VMs config

Those scripts will allow to build/switch configurations/VMs/ISOs for specific
machines (in `machines/` folder) or user configurations (in case of HM, in
`machines/*/` folder).

Each scripts provide an help with the `-h` options for more information.

For instance:

```bash
os build -H dev-min
```

Will build NixOS configuraitons for machines `dev-min` configurations defined in
folder `machines/dev-min`.

This repository host my public NixOS and Home-Manager configurations. Those
configurations are assembled through "flavors" that can be activated and
configured on demande.

It also provide one NixOS module `os` and one Home-Manager module `hm` to
configure flavors.

### ✨ NixOS Flavors

If you want to use OS flavors, add following lines in your files:

* `flake.nix`
```nix
{
  inputs = {
    # Replace by the one you use
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixos = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    [...]
  }

  outputs = inputs @ {self, ...}: {
    # NIXOS
    # ------------------------------------------------------------------------
    nixosConfigurations = {
      your-hostname = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          # NixOS module for this repo
          inputs.nixos.nixosModules.os
          # Your other modules here
          [...]
          # Finally, your configuration.nix here:
          ({ ...}: {
            os = {
              flavors = {
                # Deactivate _core flavors which is activated by default
                _core = {
                  enable = false;
                };
                # Activate k3s flavors
                k3s = {
                  enable = true;
                };
                # Add other flavors if you want
              };
            };
          })
        ];
      };
    };
  };
}
```

### ✨ Home-Manager Flavors

If you want to use HM flavors, add following lines in your files:

* `flake.nix`
```nix
{
  inputs = {
    # Replace by the one you use
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    [...]
  }

  outputs = inputs @ {self, ...}: {
    # HOME MANAGER
    # ------------------------------------------------------------------------
    homeConfigurations = {
      "user@hostname" =inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          # HM module for this repo
          inputs.nixos.HomeManagerModules.hm
          # Your other modules here
          [...]
          # Finally, your home.nix here:
          ({ ...}: {
            hm = {
              flavors = {
                # Deactivate _core flavors which is activated by default
                _core = {
                  enable = false;
                };
                # Activate kubernetes-client flavors
                kubernetes-client = {
                  enable = true;
                };
                # Add other flavors if you want
              };
            };
          })
        ];
      };
    };
  };
}
```

<!-- END DOTGIT-SYNC BLOCK EXCLUDED CUSTOM_README -->
## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check [issues page][issues_pages].

You can also take a look at the [CONTRIBUTING.md][contributing].

[issues_pages]: https://framagit.org/rdeville-public/dotfiles/nixos-config/-/issues
[contributing]: https://framagit.org/rdeville-public/dotfiles/nixos-config/blob/main/CONTRIBUTING.md

## 👤 Maintainers

* 📧 [**Romain Deville** \<code@romaindeville.fr\>](mailto:code@romaindeville.fr)
  * Website: [https://romaindeville.fr](https://romaindeville.fr)
  * Github: [@rdeville](https://github.com/rdeville)
  * Gitlab: [@r.deville](https://gitlab.com/r.deville)
  * Framagit: [@rdeville](https://framagit.org/rdeville)

## 📝 License

Copyright © 2023 - 2025
 * [Romain Deville \<code@romaindeville.fr\>](code@romaindeville.fr)

This project is under following licenses (**OR**) :

* [MIT][main_license]
* [BEERWARE][beerware_license]

[main_license]: https://framagit.org/rdeville-public/dotfiles/nixos-config/blob/main/LICENSE
[beerware_license]: https://framagit.org/rdeville-public/dotfiles/nixos-config/blob/main/LICENSE.BEERWARE
<!-- END DOTGIT-SYNC BLOCK MANAGED -->
