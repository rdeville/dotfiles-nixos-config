<!-- BEGIN DOTGIT-SYNC BLOCK MANAGED -->
<!-- markdownlint-disable -->
# 👋 Welcome to Nixos Config Data

<center>

> ⚠️ IMPORTANT !
>
> Main repo is on [framagit.org](https://framagit.org/rdeville-private/dotfiles/nixos).
>
> On other online git platforms, they are just mirror of the main repo.
>
> Any issues, pull/merge requests, etc., might not be considered on those other
> platforms.

</center>

---

<center>

[![License: COPYRIGHT)][license_badge]][license_url]
[![Changelog][changelog_badge]][changelog_badge_url]
[![Build][build_badge]][build_badge_url]
[![Release][release_badge]][release_badge_url]

</center>

[build_badge]: https://framagit.org/rdeville-private/dotfiles/nixos/badges/main/pipeline.svg
[build_badge_url]: https://framagit.org/rdeville-private/dotfiles/nixos/-/commits/main
[release_badge]: https://framagit.org/rdeville-private/dotfiles/nixos/-/badges/release.svg
[release_badge_url]: https://framagit.org/rdeville-private/dotfiles/nixos/-/releases/
[license_badge]: https://img.shields.io/badge/License-COPYRIGHT-blue
[license_url]: https://framagit.org/rdeville-private/dotfiles/nixos/blob/main/LICENSE
[changelog_badge]: https://img.shields.io/badge/Changelog-Python%20Semantic%20Release-yellow
[changelog_badge_url]: https://github.com/python-semantic-release/python-semantic-release

Repository storing configuration for my computer and users used with NixOS and
Home-Manager

---
<!-- BEGIN DOTGIT-SYNC BLOCK EXCLUDED CUSTOM_README -->
## 🚀 Usage

In order to use this configuration, setup hosts and user configuration in folder
`configs`.

Once done, there is two scripts to help you :

* `hm`: Wrapper around Home-Manager to help build new config and switch to it
* `nixvm`: Help to start a NixOS VMs to develop my NixOS configuration

### Home Manager

```bash
# To build a new Home-Manager config
hm build
# With Impure arguments
hm build -i -- --override-input direnv ~/git/framagit.org/public/dotfiles/direnv
# To override inputs
hm build -i -- --override-input direnv ~/git/framagit.org/public/dotfiles/direnv
# To switch to new configuration
hm switch -i
```

### NixOS VMs

Simply type `nixvm` to be prompt questions to help start NixOs VMs.

<!-- END DOTGIT-SYNC BLOCK EXCLUDED CUSTOM_README -->
## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check [issues page][issues_pages].

You can also take a look at the [CONTRIBUTING.md][contributing].

[issues_pages]: https://framagit.org/rdeville-private/dotfiles/nixos/-/issues
[contributing]: https://framagit.org/rdeville-private/dotfiles/nixos/blob/main/CONTRIBUTING.md

## 👤 Maintainers

* 📧 [**Romain Deville** \<code@romaindeville.fr\>](mailto:code@romaindeville.fr)
  * Website: [https://romaindeville.fr](https://romaindeville.fr)
  * Github: [@rdeville](https://github.com/rdeville)
  * Gitlab: [@r.deville](https://gitlab.com/r.deville)
  * Framagit: [@rdeville](https://framagit.org/rdeville)

## 📝 License

Copyright © 2024
 * [Romain Deville \<code@romaindeville.fr\>](code@romaindeville.fr)

This project is under [COPYRIGHT][main_license].


[main_license]: https://framagit.org/rdeville-private/dotfiles/nixos/blob/main/LICENSE

<!-- END DOTGIT-SYNC BLOCK MANAGED -->
