<!-- markdownlint-disable-file -->
# CHANGELOG

## v0.10.1 (2025-02-23)

### 🩹 Patch

  * ⬆️(devbox): Update devbox.lock by Romain Deville ([`b9461a2`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b9461a2a75fe46018e863e3862ce53e3e3f4d376)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`a6f97f8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a6f97f85dc7c3e5ce62a359ec546f4003e768501)) 🔏
  * 🔧 Update flavors used in config, remove zshrc from inputs (!46) by Romain Deville ([`592d1fb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/592d1fb9bc474fb2dbfdd33cd8a5798db65f2c9b))
  * 🔧(nixos/hm): Set useGlobalPkgs to false to let user set nixpkg config by Romain Deville ([`99ef4d1`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/99ef4d16d3636a2d708be7ec30394f679230b54a)) 🔏
  * 🔧(machines/rey): Add latex and terragrunt HM flavors by Romain Deville ([`a02c68f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a02c68f63805f42552b47e62276572ae98ddd0c7)) 🔏
  * 🔧(machines/FBLP-181): Add terragrunt flavors by Romain Deville ([`e1f5e2a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e1f5e2afafd60d6c3593b9ea31b1722c933e8586)) 🔏
  * 🔧(machines/darth-maul): Update flavors used by Romain Deville ([`9b08007`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9b080073d5a1bbbeff3ea76ce074875883dd7295)) 🔏

### 🔊 Others

  * 🔥(flake): Remove zshrc from inputs by Romain Deville ([`57a9be2`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/57a9be238dcf3e8e8e59bd96c662251ae5573a36)) 🔏
  * 🔥(scripts): Remove zshrc inputs from local_inputs by Romain Deville ([`f6a080e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f6a080ed77ecf4a2f7a1e7f47635d83b68df1f68)) 🔏
  * 🔥(hm): Remove use of my zshrc flake by Romain Deville ([`731dc9b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/731dc9be5c57f1f351d10d7d3a6f014753fcb7a1)) 🔏

## v0.10.0 (2025-02-20)

### ✨ Minor

  * ✨(machines): Add luke machines NixOS and HM Configurations by Romain Deville ([`b0b5080`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b0b5080b90996adcea7b28e53cefc64949a42a8a)) 🔏

### 🩹 Patch

  * ⚡️(hm/scripts): Add my auto-type script based on ydotool by Romain Deville ([`c9e0fd8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c9e0fd8f673a45ed99c9b02ffc9e764d7ee45957)) 🔏
  * ⚡️(os): Add use of facter for NixOS by Romain Deville ([`6d39eb8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6d39eb84d7e769610ec77893f29d9216c6b01696)) 🔏
  * ➕ Update flake.nix by Romain Deville ([`b16d267`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b16d267d5a80303a15463580447d171336a6e6fe)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2d21a39`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2d21a39925ec9a916c79bec460b594ebda6b8f80)) 🔏
  * 🔧 Mainly update darth-maul config and add luke config (!45) by Romain Deville ([`51e6b04`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/51e6b04a921a7e29c9f2d535724e5277f6d8a3cb))
  * 🔧(sops): Add luke machine with user to .sops.yaml by Romain Deville ([`634d851`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/634d85185265bdf7d0eb022f14caae0c490eae16)) 🔏
  * 🔧(machines/darth-maul): Update to use facter by Romain Deville ([`470bf37`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/470bf37fdea3c6aca6fc226398f21dea5e5bdaab)) 🔏
  * 🔧(machines/darth-maul): Add dconf and ydotool to OS configuration by Romain Deville ([`9a9246d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9a9246d53780f042ca5ef91cf328953520299170)) 🔏
  * 🔧(machines/darth-maul): Temporary deactivate wayland by Romain Deville ([`4b6eed1`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4b6eed18603eaef53dae5902e521379e5d5b38fb)) 🔏
  * 🔧(machins/FBLP-181): Update kitty configuration for MacOS by Romain Deville ([`9b7f26f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9b7f26fbb5d83c705e9c1e3b6c4adc6a8060cb51)) 🔏

### 🔊 Others

  * 🔨(scripts): Fix dev scripts missing function and typos by Romain Deville ([`e67c345`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e67c345276fad635831a0f4fcc9181a1e1890a31)) 🔏
  * 🔨(devbox): Add devbox script that show available command wrapper by Romain Deville ([`77546c9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/77546c9eb1530c10e31e6183a6703e572686350c)) 🔏

## v0.9.3 (2025-02-11)

### 🩹 Patch

  * 🐛(machines/FBLP-181): Fix machines darwin support (!44) by Romain Deville ([`170ef59`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/170ef59b047f29873ccb1b082f4b7ef169797f07))
  * 🐛(machines/FBLP-181): Fix machines darwin support by Romain Deville ([`c606b7a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c606b7a1ac8214e7142c4f063cdb496c7f77f7c6)) 🔏

## v0.9.2 (2025-02-09)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`a996acb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a996acba27e88e59a66b7b2f2ecd39711cb34397)) 🔏

## v0.9.1 (2025-02-09)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`57cf4e7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/57cf4e74d526398035f956c40980dcbbac4b22c9)) 🔏
  * 🔧(machines): Enable terraform and switch to discord flavors (!43) by Romain Deville ([`5e40cfb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5e40cfbb3b5cadd0c3fdbe3b0727366cfdc15c98))
  * 🔧(machines/rey): Enable terraform and discord flavors by Romain Deville ([`c628698`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c628698924759fe9ccfe051d1c891f492508b3a4)) 🔏
  * 🔧(machines/darth-maul): Enable discord and terraform flavors by Romain Deville ([`9065f88`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9065f886c01038811e46bc993fa6ed923aae5401)) 🔏

## v0.9.0 (2025-02-08)

### ✨ Minor

  * ✨ Add new tooling scripts and refacto configuration folderk (!41) by Romain Deville ([`8cc8a70`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8cc8a709a5825d40fc5f7628759842c24f465e25))

### 🩹 Patch

  * ✏️(hm): Fix typo in home-manager.nix by Romain Deville ([`aa88d17`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/aa88d172fdcdc034ac5337b4743966bc4f951731)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2be3e2d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2be3e2d2d8502b980898d94d06fb566557138767)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`03d2b19`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/03d2b195df0125fe4b5cf92f1bef9d9850b510b1)) 🔏
  * 🍱(assets): Restore fastfetch logo by Romain Deville ([`b7e7de4`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b7e7de4e62b4f29a7352bf65cb8573085db93483)) 🔏
  * 👽️(hosts): Update default git profiles due to new module structure by Romain Deville ([`5b09b89`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5b09b89023df867cfab0b57c0cc4ca844981bf03)) 🔏
  * 👽️(hosts/palpatine): Update git commented profiles due to new module structure by Romain Deville ([`bc166a6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/bc166a605ad4561de2924d3311d0f792c168d4bd)) 🔏
  * 🔧 Update hosts config and scripts management (!42) by Romain Deville ([`cfbb836`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/cfbb836ee725f22c3f83695b0d3307a8d2635a9d))
  * 🔧(accounts): Deactivate khal since build fail by Romain Deville ([`3a7cdaa`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3a7cdaab628052216173bc483126cef3cb8b6472)) 🔏
  * 🔧(machines): Upgrade all machines to new config, now able to build all by Romain Deville ([`89910ad`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/89910adbdd2c175fa488c1632e84c8f7d0b027d3)) 🔏
  * 🔧(darth-maul/rdeville): Add luarocks and go pkgs by Romain Deville ([`0330fbe`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/0330fbe2c40bf9e023b38b02e246c5703f642047)) 🔏
  * 🔧(hm/darth-maul/rdeville): Deactivate hyprspace &amp; hyprexpo since unable to build by Romain Deville ([`d1c1691`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d1c16913ef3b3c8657d181e0542e1e15a0b38a76)) 🔏
  * 🔧(host/darth-maul): Remove useless comment by Romain Deville ([`f397913`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f3979131be3854c14f3de947145720a9ed9b6e7b)) 🔏

### 🔊 Others

  * ♻️ Update imports path due to new structure by Romain Deville ([`8e5efba`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8e5efbadf20bd123270c891afb0aadc0b54c111a)) 🔏
  * 🔥 Remove useless code and useless flakes inputs by Romain Deville ([`4e4e8c8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4e4e8c8ad6f8bf278727214d3a12eb0f0d327a9b)) 🔏
  * 🔥(pubkeys): Remove now useless old public keys by Romain Deville ([`74662c4`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/74662c45325d01a8a2289cf714a97253daf603ab)) 🔏
  * 🔨(devbox): Drop devenv support to only use devbox with local scripts by Romain Deville ([`15ca325`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/15ca3253dbd286e4e7330379abf39f8bcf36bfe8)) 🔏
  * 🔨(scripts): Remove script now in my nixos flake and package them by Romain Deville ([`7be20e7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7be20e799dae9a9e0e9b9b1ea748d1d6a3893637)) 🔏
  * 🔨(devenv): Integrate new scripts to devenv by Romain Deville ([`9aa6d29`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9aa6d29288417c5b401a2f0164793b8c77602e60)) 🔏
  * 🔨(scripts): Refacto and normalize scripts with a &#34;fake&#34; CLI by Romain Deville ([`95e079a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/95e079a108bba3599fce8dde8e0e3c65df60aa35)) 🔏
  * 🚚(assets): Flatten configs/assets to assets by Romain Deville ([`3028254`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3028254d2b5ef24c7d35d6e1fba68aa043e7b2c8)) 🔏
  * 🚚(accounts): Flatten configs/accounts to accounts by Romain Deville ([`feea41b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/feea41b56348d0f3ff9c48de0d33f349252123ea)) 🔏
  * 🚚(hosts): Move configs/hosts to machines to flatten structure by Romain Deville ([`bf58f63`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/bf58f63caf9a2f93cc0fd2661076df7fd15530ba)) 🔏

## v0.8.0 (2025-01-24)

### ✨ Minor

  * ✨ Add hyprland module to darth-maul and dev machine (!40) by Romain Deville ([`16f9947`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/16f994720660ce5f1014da67048c68000f342a93))

### 🩹 Patch

  * ⚡️(scripts): Improve scripts behaviour and logging by Romain Deville ([`2083be3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2083be30153e627734e811790c5551497fb182b5)) 🔏
  * ➕ Update flake.nix by Romain Deville ([`99c2533`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/99c253324e9d70a43b659e602a501adf88dc15a4)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`ce3db4d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ce3db4da0bcac550b646b7f4ea1887b7e3d02ca6)) 🔏
  * 🐛(cfg/hosts/darth-maul): Use nvidia stable instead of latest by Romain Deville ([`74a2d19`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/74a2d19b4407b064a6e88eb5b7ef2807d800e12c)) 🔏
  * 🔧(cfg/hosts/darth-maul): Deactivate discord autoupdate with config by Romain Deville ([`ced89e8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ced89e8fcd11016334cc10112a7729aca0c66c28)) 🔏
  * 🔧(sops): Add dev machine with user to .sops.yaml by Romain Deville ([`b662cd0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b662cd0d1440e5b49d1dde9c946cb8567d3505b5)) 🔏
  * 🔧(cfg/host/usb-amd64): Update OS usb-amd64 config by Romain Deville ([`e464831`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e46483154b8648f7453ccdf9d4b53dc36e9a45ce)) 🔏
  * 🔧(cfg/host/dev): Update OS dev config by Romain Deville ([`894e717`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/894e71757082f57d1758347e054692a7a4260a0d)) 🔏
  * 🔧(cfg/host/dev): Update HM dev:root config by Romain Deville ([`2e1342d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2e1342d8b0c1ec3d3b58d3d668175d5a1a5f8d4d)) 🔏
  * 🔧(cfg/host/dev): Update HM dev:nixos config by Romain Deville ([`d26f846`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d26f8468eb14bc8cdc242accc4e5c95862363041)) 🔏
  * 🔧(cfg/host/darth-maul): Update OS darth-maul config by Romain Deville ([`e3713af`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e3713afbb258925641572bf088c5e8c38f61096a)) 🔏
  * 🔧(cfg/host/darth-maul): Update HM darth-maul:root config by Romain Deville ([`7a84702`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7a847028794002fb52fbe69a8de12c5d733ab17f)) 🔏
  * 🔧(cfg/host/darth-maul): Update HM darth-maul:rdeville config by Romain Deville ([`0574a08`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/0574a0829e1a4a564717169a8bd50a442f37f594)) 🔏

### 🔊 Others

  * ♻️ Refacto way HM modules are managed with nixosConfiguration by Romain Deville ([`482431d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/482431d75699afdc09715041cb45c24d63816433)) 🔏
  * 🔐(common): Rotate spotify.enc.yaml by Romain Deville ([`15cc6dc`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/15cc6dc89a9c2be318661b6277a5cb0c8178593b)) 🔏
  * 🔐(cfg/host/usb-amd64): Update OS age &amp; ssh usb-amd64 key by Romain Deville ([`8139373`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/813937301a901998d3949735b5d33bcad93ced26)) 🔏
  * 🔐(cfg/host/usb-amd64): Update HM age &amp; ssh usb-amd64:root key by Romain Deville ([`4c423de`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4c423de90b589dca34d1323cbc9999adcf76d809)) 🔏
  * 🔐(cfg/host/usb-amd64): Update HM age &amp; ssh usb-amd64:nixos key by Romain Deville ([`362eebd`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/362eebd67a60a4acef2a6aa6070087721dfcb1ea)) 🔏
  * 🔐(cfg/host/rey): Update OS rey secret by Romain Deville ([`c0b3fc0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c0b3fc08f47a448f0a91dc601c707e795e1de46f)) 🔏
  * 🔐(cfg/host/rey): Update OS age &amp; ssh rey key by Romain Deville ([`f0a070c`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f0a070ca1f11f180ae16da4edf1a82a03b70e942)) 🔏
  * 🔐(cfg/host/rey): Update HM age &amp; ssh rey:root key by Romain Deville ([`88359a3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/88359a3ad04b0029553945265d2ecac78bbe8e0d)) 🔏
  * 🔐(cfg/host/rey): Update HM age &amp; ssh rey:rdeville key by Romain Deville ([`97646a9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/97646a9bec173b31274efdb7ed33ac982c95e303)) 🔏
  * 🔐(cfg/host/palpatine): Update OS age &amp; ssh palpatine key by Romain Deville ([`8ba21a1`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8ba21a19470d0438405121ac2c22043cfb8f2e14)) 🔏
  * 🔐(cfg/host/palpatine): Update HM age &amp; ssh palpatine:romaindeville key by Romain Deville ([`f065b89`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f065b8999b1154c10804e115e66589fc9e91a9ee)) 🔏
  * 🔐(cfg/host/FBLP-181): Update OS age &amp; ssh FBLP-181 key by Romain Deville ([`854b047`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/854b047e5af10677a455e6644550ccf36c2df00f)) 🔏
  * 🔐(cfg/host/FBLP-181): Update HM age &amp; ssh FBLP-181:romaindeville key by Romain Deville ([`ba630fa`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ba630faf7d6a205cdf29bb12beac096465e64a55)) 🔏
  * 🔐(cfg/host/dev): Update OS age &amp; ssh dev key by Romain Deville ([`92cb3d5`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/92cb3d5f561873de9c710e8c1f2ccc97397172ea)) 🔏
  * 🔐(cfg/host/dev): Update HM age &amp; ssh dev:root key by Romain Deville ([`d86008e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d86008ea522d39a6c91915b8f8b16e47c58a6728)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update OS age &amp; ssh darth-plagueis key by Romain Deville ([`5e97f65`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5e97f65c838bcbb7dbe75fb7159d34089d6396de)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update HM age &amp; ssh darth-plagueis:root key by Romain Deville ([`3ba7cf8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3ba7cf8bd3dd73bace179ac4577b1ddf7e0ca016)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update HM age &amp; ssh darth-plagueis:rdeville key by Romain Deville ([`b730c70`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b730c70621da3e243b2b32ae4a0db0c609d3a5e0)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS darth-maul secret by Romain Deville ([`f358000`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f358000dc9ed67df2422801665ddb91207435a92)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS age &amp; ssh darth-maul key by Romain Deville ([`8ebbed8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8ebbed86ad87c40e2d157377b049dd40c234d455)) 🔏
  * 🔐(cfg/host/darth-maul): Update HM age &amp; ssh darth-maul:root key by Romain Deville ([`627bb47`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/627bb471871ae72e0ecaaa599fae63a7bf7192a9)) 🔏
  * 🔐(cfg/host/darth-maul): Update HM age &amp; ssh darth-maul:rdeville key by Romain Deville ([`05e0379`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/05e0379ed61f6a4246ba5d0ab6bf00686ef7ba5f)) 🔏
  * 🔥(direnv): Remove call to source .envrc.local.post() by Romain Deville ([`6d908ff`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6d908ff176703c6691313ca31b38e53732abea73)) 🔏

## v0.7.0 (2025-01-16)

### ✨ Minor

  * ✨ Add sets of script and configuration to ease key/secrets rotations (!39) by Romain Deville ([`c3a4cab`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c3a4cab9d04609de492ecbb549495a01ed0d1220))

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`7d9e97d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7d9e97d222c9af14f9a8da34693cc92775e97e38)) 🔏
  * 👽️(configs): Remove use of hm.flavors._packages with home.packages by Romain Deville ([`8a23516`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8a23516892b9d8de7326c29801416e5cd98c9257)) 🔏
  * 🔒️(common_secrets): Add spotify common secrets by Romain Deville ([`4fbf216`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4fbf2162227f1f84df976436e14429f4130bd639)) 🔏
  * 🔧(cfg/host/rey): Update OS rey config by Romain Deville ([`7784dcb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7784dcb543369cbb3a054f208eddbf0b499572a2)) 🔏
  * 🔧(cfg/host/darth-maul): Update OS darth-maul config by Romain Deville ([`5dd1644`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5dd1644b22eb23cb6c095e1158e95d578108d186)) 🔏
  * 🔧(cfg/host/rey): Update OS rey config by Romain Deville ([`c054ddb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c054ddbe95646c449a653c52f34b178b2ed23e73)) 🔏
  * 🔧(cfg/host/palpatine): Update OS palpatine config by Romain Deville ([`bce2782`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/bce2782aeeac345dedcbda03a8b78396f7cb3cce)) 🔏
  * 🔧(cfg/host/FBLP-181): Update OS FBLP-181 config by Romain Deville ([`d2cab0a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d2cab0aaf68a96adc57ee1e2d2b3a7c8b42cec66)) 🔏
  * 🔧(cfg/host/darth-maul): Update OS darth-maul config by Romain Deville ([`287ae99`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/287ae99007858a10dd6e4a615a80ab53a6336c55)) 🔏
  * 🔧(cfg/hosts): Add base.nix for all hosts by Romain Deville ([`fae54f7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/fae54f788b60b410706b8cf947914bf212cc9f99)) 🔏
  * 🔧(sops): Update .sops.yaml config by Romain Deville ([`2a44da6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2a44da6bf8c8dc396e4dd792821a4b67564f20a2)) 🔏

### 🔊 Others

  * 🔐(cfg/accounts): Update contact@romaindeville.ovh secrets by Romain Deville ([`dd2382e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/dd2382edf2ceff8847ecc1a38da540c28eb248d4)) 🔏
  * 🔐(cfg/accounts): Update contact@romaindeville.fr secrets by Romain Deville ([`e501d12`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e501d12416977a12a496b8d92c693dbd4e8cf986)) 🔏
  * 🔐(cfg/host/usb-amd64): Update HM nixos@usb-amd64 keys by Romain Deville ([`a8f3eb1`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a8f3eb1191bbdae86751b14f43439aa0fcd2d36b)) 🔏
  * 🔐(cfg/host/usb-amd64): Update OS usb-amd64 secrets by Romain Deville ([`5b3b61c`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5b3b61c3973ff02a4c7db022cfd4a93ef660143a)) 🔏
  * 🔐(cfg/host/usb-amd64): Update OS usb-amd64 keys by Romain Deville ([`10cce07`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/10cce078ae44f28e00e97f428b3b99569affde05)) 🔏
  * 🔐(cfg/host/rey): Update HM rdeville@rey keys by Romain Deville ([`9fdbd47`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9fdbd479b4c81551899db3b9019b108f319cbb5e)) 🔏
  * 🔐(cfg/host/rey): Update OS rey secrets by Romain Deville ([`b907e50`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b907e5001b6954a02ef9c878070cb3e7d35f6430)) 🔏
  * 🔐(cfg/host/rey): Update OS rey keys by Romain Deville ([`061a960`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/061a960b0e2e7310a3ebaf1b88d0b6edbffaa472)) 🔏
  * 🔐(cfg/host/palpatine): Update HM romaindeville@palpatine keys by Romain Deville ([`10b2987`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/10b29875a81d56a5d925d0b1c6ea9cc98e53c2c1)) 🔏
  * 🔐(cfg/host/palpatine): Update OS palpatine secrets by Romain Deville ([`3f308ce`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3f308cef0a59c4cc0616672450e0dceed63282fe)) 🔏
  * 🔐(cfg/host/palpatine): Update OS palpatine keys by Romain Deville ([`a3b08c8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a3b08c8def195362d013cb6203e9e76257bd18e9)) 🔏
  * 🔐(cfg/host/FBLP-181): Update HM romaindeville@FBLP-181 keys by Romain Deville ([`9ac6436`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9ac643610f7f44181e3578edad5f1a770f52f55e)) 🔏
  * 🔐(cfg/host/FBLP-181): Update OS FBLP-181 secrets by Romain Deville ([`59d2f06`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/59d2f06a933c13f1a3977a8ddc7e6c8bb4dcc054)) 🔏
  * 🔐(cfg/host/FBLP-181): Update OS FBLP-181 keys by Romain Deville ([`3feb0c5`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3feb0c525af0b72ea128cf755d2d290816dfdd0e)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update HM rdeville@darth-plagueis keys by Romain Deville ([`d3ac0ce`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d3ac0cea6960ef6f849cc40a0cfa4b1758462c1c)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update OS darth-plagueis secrets by Romain Deville ([`7ceb8b0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7ceb8b0493886b77a41eedc043a78f6349d7422a)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update OS darth-plagueis keys by Romain Deville ([`9890c97`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9890c97db74e352ced7c4ba6efc84b795836ba9d)) 🔏
  * 🔐(cfg/host/darth-maul): Update HM rdeville@darth-maul keys by Romain Deville ([`95e1954`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/95e19541893c8ec2d36b977181f410ca831a5001)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS darth-maul secrets by Romain Deville ([`725ce08`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/725ce08ac26800eb7361cf09e6b4013c4d130e74)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS darth-maul keys by Romain Deville ([`84bf451`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/84bf4519c3bccc134fbb39c005b9479c1dbbf031)) 🔏
  * 🔥(lib): Remove useless code in default.nix by Romain Deville ([`92f2ba7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/92f2ba7ab1d220255d3f1bfa7ddb900f8f793a2f)) 🔏
  * 🔨(scripts): Add commit.sh to to batch commit update of hosts by Romain Deville ([`f1e09c9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f1e09c95a6b1536305194ed7965c66a28c746b89)) 🔏
  * 🔨(scripts): Improve sops.sh script by Romain Deville ([`0598891`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/05988913d961986e41684a955f290c8a5c8f297a)) 🔏
  * 🔨(scripts): Improve keys.sh script by Romain Deville ([`81be55b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/81be55bcb5f9d0940ee630dd93aea592a683e298)) 🔏
  * 🔨(devbox): Update devbox.json and init_hook scripts location by Romain Deville ([`edb1781`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/edb1781d1143a67245167b91bd7670bcc49b5c0c)) 🔏
  * 🔨(direnv): Update .envrc with .envrc.local.post by Romain Deville ([`a252eb2`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a252eb2f29ee7dfc9ceaa80b34ce9c328ce65bed)) 🔏

## v0.6.2 (2025-01-14)

### 🩹 Patch

  * 🐛(cfg/hosts/darth-maul): Add config as param to rdeville user (!38) by Romain Deville ([`d24baa9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d24baa948a4e0f2c1bef58d3ff0246e6e0e95423))
  * 🐛(cfg/hosts/darth-maul): Add config as param to rdeville user by Romain Deville ([`8e1c5f3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8e1c5f31ae000d68f102d553cc6fa3cdc3008d56)) 🔏
  * 🔧(cfg/hosts/darth-maul): Add yubikey-manager pkgs to user rdeville by Romain Deville ([`0644179`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/064417934102a3270e2fee45eef0ee806f28516a)) 🔏

### 🔊 Others

  * 🔨(scripts): Remove `nix fmt .` from hm.sh and nixos.sh by Romain Deville ([`2352848`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2352848fcf40bd93559bb48ecfa74002ab3e71be)) 🔏
  * 🔨(scripts): Restore local_inputs.sh to empty table by Romain Deville ([`d6c5b5e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d6c5b5ea469c9753f10f955db218902a9bb260cc)) 🔏

## v0.6.1 (2025-01-14)

### 🩹 Patch

  * 🍱(cfg/assets/fastfetch): Add dougs.txt ascii logo by Romain Deville ([`17d5ea3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/17d5ea3f271db5c380e453c0c0f7371ab77d6e6e)) 🔏
  * 🐛(cfg/hosts/rey): Fix user rdeville spotify client_id_command by Romain Deville ([`7a663fa`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7a663fa85d117840b1a8174aa817b633c47dee69)) 🔏
  * 🐛(cfg/hosts/darth-maul): Fix user rdeville spotify client_id_command by Romain Deville ([`04c0e46`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/04c0e46237e7464d47c1978201c7440be9590731)) 🔏
  * 🔧 Mainly add workstation config, fix minor bugs (!37) by Romain Deville ([`7d32dda`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7d32dda77fd8b2bbe19e3d264a1391106f096abb))
  * 🔧(cfg/hosts/FBLP-181): Add user rdeville HM configuration by Romain Deville ([`db1085c`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/db1085c003453f7e67c5a83281d3e158afb7205a)) 🔏
  * 🔧(cfg/hosts): Add FBLP-181 OS configuration (pro workstation) by Romain Deville ([`57f4fb7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/57f4fb74c91cf95a7a13f940e7a4fffc74b593d3)) 🔏
  * 🔧(cfg/hosts/palpatine): Add user rdeville configuration by Romain Deville ([`f716b60`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f716b604782a172696f6b7990d189ecef07e454f)) 🔏
  * 🔧(cfg/hosts): Add Palpatine OS minimal configuration by Romain Deville ([`35b4c12`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/35b4c12d2c2d554e9111607d4ce4be5fc974436d)) 🔏
  * 🔧(sops): Update sops public keys and rules by Romain Deville ([`16fd077`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/16fd0772e2428e5266d6e91c4909f1cf6108e3e2)) 🔏

### 🔊 Others

  * 🎨(scripts/sops.sh): Improve output when using `sops.sh -u` by Romain Deville ([`6213182`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/62131823f2e71a8db55ff776015c378782b00e69)) 🔏
  * 🔐(cfg/hosts/FBLP-181): Update user romaindeville secrets by Romain Deville ([`34e9eb4`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/34e9eb4475380c32bae3d2ff81c36e15acc46880)) 🔏
  * 🔐(cfg/hosts/palpatine): Update user romaindeville secrets by Romain Deville ([`33cec51`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/33cec51ae24f98fbb32cb5925f160713ca873b64)) 🔏

## v0.6.0 (2025-01-14)

### ✨ Minor

  * ✨ Add multiples scripts, update secrets and prepare new vm-hosts (!36) by Romain Deville ([`3ef6cc0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3ef6cc0e04e4dc8208bb0dc2b8f2eb1a98f4e335))
  * ✨(os): Add local nixos module with home-manager support by Romain Deville ([`c395e4d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c395e4df9ee77d37fe50ef78ffbdc27b9a5dc290)) 🔏

### 🩹 Patch

  * ⚡️(cfg/accounts): Make use of `home` module instead of `hm` by Romain Deville ([`14b3c92`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/14b3c92d3445bf04aee24301d7ab48438d781b0b)) 🔏
  * ⚡️(hm): Improve `hm` module by removing `hm` arg by Romain Deville ([`93ebdef`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/93ebdef4bcb5158fa48ca219bf331e6ab8659195)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2d3463c`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2d3463c7f4ecb0c9454c5e1b389fe72cee799932)) 🔏
  * 📦️(cfg/hosts/darth-maul): Add viddy pkgs to user rdeville by Romain Deville ([`76e7444`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/76e744487614d27dcfe134ce8636b5058495b0e5)) 🔏
  * 🔧(cfgs/hosts): Add usb-amd64 build to cread bootable USB or VMs by Romain Deville ([`843c81a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/843c81a5b3824c2b49640e2f24fd28fe99a56450)) 🔏
  * 🔧(cfg/hosts/rey): Update rey config to use new modules by Romain Deville ([`d02a849`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d02a849bb9117ba26e0e91f55fdddace6e9dc51b)) 🔏
  * 🔧(cfg/hosts/darth-maul): Update `os` and `hm` to be nix modules. by Romain Deville ([`512a008`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/512a0087ae582b47976fffa6107979e7fa31ecb0)) 🔏
  * 🔧(sops): Update .sops.yaml config (public keys and rules) by Romain Deville ([`0bb5452`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/0bb54521c70105086e837e95897a54e834c4b9f9)) 🔏
  * 🔧(flake): Update nixos by Romain Deville ([`e6c3b8b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e6c3b8bfc466635b25ef850b237e7bac656cdb3e)) 🔏

### 🔊 Others

  * ♻️(scripts): Create _init_logger.sh file to mutualise logger by Romain Deville ([`9a65f1e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9a65f1e57a333b22085d3f774c40efd5ee7843d2)) 🔏
  * 🎨(flake): Split flake.nix into nixos.nix and home-manager.nix by Romain Deville ([`55f2d1a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/55f2d1a73d436f0f16ca02f7cc8948d55fb1fa09)) 🔏
  * 🔐(cfg/hosts/darth-plagueis): Update os secrets by Romain Deville ([`a8f4148`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a8f41488a1cd2e1ee83ba9dbd06a4739e2f1aa16)) 🔏
  * 🔐(cfg/hosts/darth-plagueis): Update user rdeville secrets by Romain Deville ([`4d8b950`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4d8b9509240cb5cdbfc172b5cfbb03954f6ba3dc)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update os secrets by Romain Deville ([`82e6c16`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/82e6c16a34206e5036a0330c91e665ada9ed7d52)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update user rdeville secrets by Romain Deville ([`14ca9d9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/14ca9d9b227f2dd0a3d190c1a37f01084bf0071a)) 🔏
  * 🔐(cfg/hosts/rey): Update os secrets by Romain Deville ([`9dd0510`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9dd051090732c1014f4c6bcd6957322f3c8e002d)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update os secrets by Romain Deville ([`e69e46f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e69e46fa3637e519f583f02ced2ed6d94707ca47)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update user rdeville secrets by Romain Deville ([`a106353`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a106353e8f2b8497cc2e336139d30c36c9564a75)) 🔏
  * 🔐(cfg/hosts/rey): Update sops secrets by Romain Deville ([`eb84a34`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/eb84a3440d7d766873950ee4fff091c97044c5a1)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update sops secrets by Romain Deville ([`5f62aa2`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5f62aa2258fb13088feadeccc552792aac078878)) 🔏
  * 🔐(cfg/hosts/darth-maul): Add encrypted host ssh keys by Romain Deville ([`67038fe`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/67038fe73cb5fdddff1d6fb0e5ee1bc5a98d92d6)) 🔏
  * 🔐(cfg/accounts): Update accounts secrets with new keys by Romain Deville ([`678a072`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/678a0723fd95b6e3f5d7985e7ec11c7dd48f31d0)) 🔏
  * 🔨 hm/fmt by Romain Deville ([`d12b8e0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d12b8e03eea91af27601bc73d4890275cafd8946)) 🔏
  * 🔨(scripts): Add keys.sh script to (re)generate encrypted private keys by Romain Deville ([`8875a8b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8875a8bf4253b8817ad121681361100485342131)) 🔏
  * 🔨(scripts): Add script sops.sh to batch update encrypted files by Romain Deville ([`09dfd6d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/09dfd6dbd4bef495dc1e9ec9488017b07d654714)) 🔏
  * 🔨(scripts): Make hm,fmt and nixos to use _init_logger.sh and nix fmt by Romain Deville ([`911bf28`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/911bf28b24e98ab0ddf284540df2e2c56ecd4545)) 🔏
  * 🙈 Add *.qcow2 to gitignore by Romain Deville ([`201fb79`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/201fb796bdada38e71044c1e63bd580b36afd63d)) 🔏

## v0.5.1 (2025-01-06)

### 🩹 Patch

  * ⚡️(os): Improve nixos/default.nix by Romain Deville ([`15a82a0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/15a82a0db98b261ff1472c34de6d6e59b8fc248e)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`7e2c1bb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7e2c1bb444a68c9f1cceff4c06fe3e990d516f07)) 🔏
  * 🔧 Mainly update host config and setup user password (!35) by Romain Deville ([`5442d6b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5442d6b76b6d8a0ed37ea1e342a40f549ead0e29))
  * 🔧(flake): Update Update input, add nix-index by Romain Deville ([`f23fed0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f23fed0e6e1f1429ac30b1728d4e142c41aa5e67)) 🔏
  * 🔧(configs): Update config and add users password by Romain Deville ([`ef81d8e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ef81d8e5f6db1decad960e0c9c4de559c98d18a1)) 🔏

### 🔊 Others

  * 🔐 Update .sops.yaml with some keys by Romain Deville ([`b9ad5a8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b9ad5a83b0e99e49fcbe211586c998310b9ac46b)) 🔏

## v0.5.0 (2025-01-02)

### ✨ Minor

  * ✨ Fix configs due to modules in main nixos (!34) by Romain Deville ([`d39ac72`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d39ac72f514eb80a2545f3d98255b07d0f5205a9))

### 🩹 Patch

  * ⚡️(hm/flavors/ssh-client): Make flavor a nix module by Romain Deville ([`7974744`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/79747443786b9353706326e7b7fa98022fb57a18)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`a2a4360`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a2a4360fbdd210717e778515f388d2fa4899356a)) 🔏
  * 👽️(configs): Update all configs after public nixos upgrade by Romain Deville ([`ac43c18`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ac43c18830d715a3e819083e1f1a0722e0d2d266)) 🔏
  * 🔧(hm): Update default HM based on _core flavor by Romain Deville ([`c5c6eb8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c5c6eb8095a431a9cf51f92c37eeae01c253ed32)) 🔏

### 🔊 Others

  * 🎨 Rework format of devenv.nix by Romain Deville ([`ae27bd7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ae27bd76eadf2b89256995410479186542741358)) 🔏
  * 🎨 Improve flake.nix configuration by Romain Deville ([`7f6a3fe`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7f6a3feb4afe3e9849cdff90b69fbd95682e7fb6)) 🔏

## v0.4.2 (2024-12-22)

### 🩹 Patch

  * 🐛 Fix flake.nix allowing multihost HM config by Romain Deville ([`e59128d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e59128dfe81f42c9ec1caad1e223584a963b51c9)) 🔏
  * 🔧(configs/hosts): Update hosts configuration (!33) by Romain Deville ([`9a4c453`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9a4c45384676c78ba5b4815b9079c92ab39fb596))
  * 🔧(configs/hosts/rey): Update rey configuration to new structure by Romain Deville ([`ab54cfc`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ab54cfc510caa3cb7a46d85d65ece791118a2437)) 🔏
  * 🔧(configs/hosts/darth-plagueis): Update hosts configuration by Romain Deville ([`bc4551d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/bc4551d9ab690ad63fc2627d8e6f0cee5a45700d)) 🔏

## v0.4.1 (2024-12-22)

### 🩹 Patch

  * 🐛(hm): Fix accounts configurations (!32) by Romain Deville ([`29cad67`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/29cad67b3f78e093a7c23076abf3aa51b27947df))
  * 🐛(hm): Fix accounts basePath configurations by Romain Deville ([`f44ef33`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f44ef3303eaa4bceda470811b7d20a59c9fe2d44)) 🔏
  * 🔧(configs/accounts): Fix configs accounts by Romain Deville ([`200ba12`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/200ba12f4ed4044fce7fc7fc4cb9c886959b07d0)) 🔏

## v0.4.0 (2024-12-22)

### ✨ Minor

  * ✨ Upgrade config to use public nixos using modules (!31) by Romain Deville ([`7825107`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7825107b051d455eba34903a1220be5612515a47))
  * ✨ Upgrade flake.nix to new module structure by Romain Deville ([`98bc017`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/98bc017a361528d9873b36acfaa25ea5100e05c0)) 🔏
  * ✨(configs/hosts/darth-plagueis): Add darth-plagueis host and users config by Romain Deville ([`7065bcb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7065bcbe034788f50c73d11d7bc66eaccfb3af21)) 🔏
  * ✨(nixos): Add default nixos configuraiton by Romain Deville ([`294b225`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/294b225afab47883122e7484a67b7a571fda9eff)) 🔏
  * ✨(hm): Add hm default configuration and use modules by Romain Deville ([`9534950`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/953495017417e4890de0854d4613b8801148bd52)) 🔏
  * ✨(hm/flavors): Upgrade flavors to use modules by Romain Deville ([`3e13c5a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3e13c5aa1aa4fca8d26b68f194ed30db31ea26d6)) 🔏
  * ✨(lib): Add lib, mainly  related to hm accounts configuration by Romain Deville ([`a86886a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a86886af86942fc93c93752415ef9b34eb0a3351)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`183b478`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/183b478039d824582e34e20483a3ae4cfda2a7e8)) 🔏
  * 🔧(configs/hosts/rey): Upgrade rey config to use module by Romain Deville ([`19b69d6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/19b69d63803a851a0c60dfc20f25d18d068fae21)) 🔏
  * 🔧(configs/hosts/darth-maul): Upgrade darth-maul to use new modules by Romain Deville ([`045ca53`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/045ca53ecac866247067957db541eaff42fc07db)) 🔏
  * 🔧(configs/accounts): Update email/contact/calendar accounts config by Romain Deville ([`5165985`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/516598508400dd01c0d624acec5c56390262c4f0)) 🔏
  * 🔧(configs/pubkeys): Add some public SSH keys by Romain Deville ([`251761e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/251761ea5cfe735edf52d8f66aea7f31abbdb1a5)) 🔏

### 🔊 Others

  * 🔥(configs/hosts): Remove now useless default hosts config by Romain Deville ([`ff6c338`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ff6c338fa6710b83a0df8cede79203723da5fa84)) 🔏
  * 🔥(hm/presets): Remove hm presets not used anymore by Romain Deville ([`cb6bceb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/cb6bceb9225e2feb582aabd12eb0412c51bead97)) 🔏
  * 🔥 Remove now useless modules/home-manager by Romain Deville ([`65f797d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/65f797d2303b98c0576dce23d65980b1da154e34)) 🔏
  * 🔨 Update devenv.nix with new script by Romain Deville ([`e1938ee`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e1938ee884e00a8d2a6ef06ab0967cc6f17d0217)) 🔏
  * 🔨 Update devenv scripts by Romain Deville ([`bfbccf2`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/bfbccf216e6b6057694f868a5fc2c30ce8171785)) 🔏
  * 🚚(hm): Move flavors/bin to assets/scripts by Romain Deville ([`5fa6a3b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5fa6a3b1bf9cf01ff5a7d798ff84eaf9374252b8)) 🔏

## v0.3.2 (2024-12-08)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`dcd1693`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/dcd16939ade5c9eb9651bcbae629e269de63a444)) 🔏
  * ⬆️ Upgrade to configuration to 24.11 by Romain Deville ([`8cc28a9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8cc28a9d7d6e12f3c1c045d170799f93d9e0ba8d)) 🔏
  * 🐛(configs): Fix accounts pkgs configuration by Romain Deville ([`62bc7d9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/62bc7d977cf65d1636602a5387a697c08002308d)) 🔏
  * 🔧(config/hosts/darth-maul): Enable nixos k3s flavor by Romain Deville ([`5e71e63`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5e71e63a44c2b6a74f7042db4c80ce3bb13f7543)) 🔏
  * 🔧(configs/hosts/darth-maul): Add nixos and hm flavors by Romain Deville ([`40972a4`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/40972a45aa6efc28d558ba17d74dcf28e8bebce7)) 🔏

### 🔊 Others

  * 🎨(configs/hosts/darth-maul): Remove useless module input by Romain Deville ([`e2b73ab`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e2b73ab8e1d69d6c5d33dca51a173f66df70d3d3)) 🔏
  * 💚 fix commitlint CI by Romain Deville ([`a47173a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a47173a47dbfc3e2fef0e4a24068cf31d5282001)) 🔏
  * 💚 Update semantic release git strategy and depth by Romain Deville ([`547a659`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/547a659c201652a33e6ffa34ac893f105d8ff8ab)) 🔏
  * 🔀 Fix commitlint CI (!30) by Romain Deville ([`da0e0ea`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/da0e0ea901b03604724dca2d36553a74ea24cf2c))
  * 🔀 Fix accounts, update flavors (!29) by Romain Deville ([`eb80b21`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/eb80b21a32c9832a691234a15f0f97933141fab3))

## v0.3.1 (2024-11-24)

### 🩹 Patch

  * ⬆️ Update flake.nix and flake.lock by Romain Deville ([`68367b1`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/68367b198cd2c72260785912ef23b1d86ed79673)) 🔏
  * 🔧 Update rdeville@rey and rdeville@darth-maul config (!27) by Romain Deville ([`a3ce288`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a3ce28864ccfcf2cc1343502e4e4601e38b0ff9f))
  * 🔧 Add kitty config for rdeville@rey by Romain Deville ([`834291e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/834291e06ac8115ae04cd636da83d9ce1c327a75)) 🔏
  * 🔧 Add new flavor and kitty config for rdeville@darth-maul by Romain Deville ([`1ca8237`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/1ca8237fec32e6c249e97b206e9773d7f5510c9b)) 🔏

### 🔊 Others

  * 💚 Fix Semantic Release CI by Romain Deville ([`636acae`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/636acaecd339cdaf886056841f51249bb3630889)) 🔏
  * 💚 Fix commitlint and semantic-release CI by Romain Deville ([`6c636ce`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6c636ceb9f39461836549c60eccbb169cf5daba5)) 🔏

## v0.3.0 (2024-11-24)

### 🩹 Patch

  * ⚡️(hm/flavors/bin): Make direnv_init only setup symlink if dest exists (!25) by Romain Deville ([`c2a8d66`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c2a8d66c3471e7232721d18ab571f8ec7f1ffb8f))
  * ⚡️(hm/flavors/bin): Make direnv_init only setup symlink if dest exists by Romain Deville ([`9faf95f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9faf95f81ce20d95952849f86a0cce7c97b67537)) 🔏
  * ✏️(hm/flavors): Format default.nix by Romain Deville ([`bf93234`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/bf932345245d09ad082a1f8e7a5b6a1728d0dd7b)) 🔏
  * ⬆️ Update templated files from dotgit-sync (!24) by Romain Deville ([`76dfbbf`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/76dfbbffd596212345bd70c2b0a37e40bab7fde7))
  * ⬆️ Update templated files from DGS by Romain Deville ([`29376e3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/29376e384d7f3a27fbaf75d8be561334a589f0f9)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`4492536`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4492536d03505b3162f513ae5974ebcfabac14b6)) 🔏
  * 🐛(hm): Fix darwin support and wrapGL (!23) by Romain Deville ([`d87f79d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d87f79dedeea554ac501d27b735a204e4fe053c5))
  * 🐛(configs/hosts): Fix isDarwin and wragGL config by Romain Deville ([`c0be49b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c0be49b4fc8351eb1d6fb6e01ea8b3feafff786c)) 🔏
  * 🐛 Update configs to work with NixOS (!22) by Romain Deville ([`4d6f549`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4d6f549dca88799c5880fbf8dfadf4084700f380))
  * 🐛(hm/flavors/bin): Fix bug in rey_salon script by Romain Deville ([`e116011`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e11601105a5375d3dae0b2b1857d48b940cfa925)) 🔏
  * 🐛(modules): Fix HM module by Romain Deville ([`5ebdc09`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5ebdc09ec2b7d750533b72895cbcb887f9747900)) 🔏
  * 🐛(hm/presets): Add HM presets generic default.nix by Romain Deville ([`39538db`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/39538dbc19d82ab3491de22f91478d49f7fa24cc)) 🔏
  * 🐛(hm/flavors): Add flavors generic default.nix by Romain Deville ([`9746eed`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9746eed0c4e8f9730656b7d3aafd9e103d5749bb)) 🔏
  * 📌 Update pinned flake inputs in flake.lock by Romain Deville ([`e146d22`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e146d22e52fa90ee650d7121ec8f0b35f88f3f4f)) 🔏
  * 🔧(configs/hosts): Update hosts configuration by Romain Deville ([`21b8f37`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/21b8f37222dc6f3dfaa73c267f08366aa575be5f)) 🔏
  * 🔧(configs/hosts/darth-maul): Add root users by Romain Deville ([`ad4a3e9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ad4a3e9c7320d6932b4349dbf67fe4727b482e71)) 🔏
  * 🔧(configs): Update all configs with NixOS integration by Romain Deville ([`35a155d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/35a155d6804386b57438047f821692ccdd49d07e)) 🔏
  * 🔧 Update flake inputs and output by Romain Deville ([`97890ff`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/97890ff50708e11341809f82991588c6fecc74c7)) 🔏
  * 🔧(pre-commit): Temporarly deactivate some pre-commit by Romain Deville ([`64011af`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/64011afea45f907f55982fc2b8655479e8d9ddb7)) 🔏

### 🔊 Others

  * ♻️(hm/presets): Refacto hm presets by Romain Deville ([`092390f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/092390f003a1bc0c438cb3b318a29d6f56bbbcee)) 🔏
  * ♻️(hm/flavors): Refacto hm flavors by Romain Deville ([`6f333ed`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6f333edaf2cf56211567b970a5e276d61bc9f652)) 🔏
  * 💚 Fix CI release (!26) by Romain Deville ([`1f4e9df`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/1f4e9df16a3606fb92d4cb2dd71a83f82ca85c5e))
  * 💚 Fix CI release by Romain Deville ([`b032ec6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b032ec6337b32a0b60b3fcda59aa5b1f7dd96a95)) 🔏
  * 🔥(configs): Clean useless code by Romain Deville ([`a679b31`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a679b31c2ca0d6ea4b462520ad4f032e99975061)) 🔏
  * 🔥(hm): Remove useless default.nix for home-manager/ by Romain Deville ([`d7c30bd`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d7c30bd45c9ba8431d7f8b439f3c70efeace3fc9)) 🔏
  * 🔨(scripts): Improve hm.sh script behaviour by Romain Deville ([`c91d3fc`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c91d3fcc431c86caeb394345c5d725828d5236c2)) 🔏
  * 🔨(devenv): Update devenv and scripts by Romain Deville ([`4cc9871`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4cc98719e8acc2ec289be516bb2314c4fdd02ac7)) 🔏

## v0.2.13 (2024-10-07)

### 🩹 Patch

  * 🐛(cfg/accounts): Fix vdirsyncer cmd for contact@romaindeville.ovh (!21) by Romain Deville ([`173d46b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/173d46be67d968e0b52a19207063d658655819a3))
  * 🐛(cfg/accounts): Fix vdirsyncer cmd for contact@romaindeville.ovh by Romain Deville ([`7e55591`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7e55591b3dfc480c574dd32f8d59515c1a910b6e)) 🔏

## v0.2.12 (2024-10-07)

### 🩹 Patch

  * ✏️(cfg/accounts): Update typos for accounts (!20) by Romain Deville ([`5b9e94b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5b9e94bc9f2c006db79cf71f363498088c05f1be))
  * ✏️(cfg/accounts): Update account typos by Romain Deville ([`9f9a34f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9f9a34fd0ec47180ac76fd1c3e6194987792aedf)) 🔏
  * 🔧(cfg/hosts/rey): Update accounts by Romain Deville ([`9cdb82f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9cdb82fa61d20dd4d95205d88fd026ab028dae09)) 🔏

## v0.2.11 (2024-10-06)

### 🩹 Patch

  * ⚡️ Refacto accounts and improve management and secrets (!19) by Romain Deville ([`5ae7386`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5ae738682a4760d4a49485f37aff7cc677a56cb8))
  * ⚡️(hm/flavors): Make bin optional with boolean by Romain Deville ([`809a5e6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/809a5e68d5dfe99a80eeadd4e4b871990a4e422e)) 🔏
  * ⚡️(cfg): Update default config lib method by Romain Deville ([`4ef7958`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4ef7958c46cc33c491bf6dd94903d8c8e1f93593)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`0fe4b59`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/0fe4b59222703af79c87e11f01d824771066c4ec)) 🔏
  * 🔧(cfg/hosts): Update hosts rey and add anakin by Romain Deville ([`2bc38ac`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2bc38acb54de8b6c3d9a1469cf849e5d9e59d909)) 🔏
  * 🔧 Update .sops.yaml config by Romain Deville ([`9f1e3a8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9f1e3a82fcdb3a4a5c62c22378eec88044461821)) 🔏

### 🔊 Others

  * ♻️(cfg/accounts): Update accounts management and secrets by Romain Deville ([`e5dded3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e5dded36efc6b0d04565a389295ab898e4167f92)) 🔏
  * 🎨(modules): Update HM module by Romain Deville ([`7a9e293`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7a9e293f57f2b3188f67276b166489e5313c5002)) 🔏
  * 🔥(cfg/secrets): Remove old secrets structure by Romain Deville ([`34c2e6e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/34c2e6e7217d6eed5f759a59a7efde3b0e643387)) 🔏

## v0.2.10 (2024-09-14)

### 🩹 Patch

  * ⬆️ Update flake.lock (!18) by Romain Deville ([`65710f9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/65710f9dd1a7d98d259179eb980ee1af41e504df))
  * ⬆️ Update flake.lock by Romain Deville ([`edc625d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/edc625d77dd1d688c67cadfa58a8a6af86cd9fdf)) 🔏

## v0.2.9 (2024-09-14)

### 🩹 Patch

  * ⚡️ Improve kp script to manage yubikey (!17) by Romain Deville ([`4a7bc87`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4a7bc87d5f46a404f87030d1d2512651c8e4c1ac))
  * ⚡️(hm/flabors/bin): Improve kp script to better manage Yubikey by Romain Deville ([`dbcff23`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/dbcff23804f8fe7758f3fa36972518fdff6be83d)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`f3aacd6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f3aacd6cbd60170a944d61c39f85a23e8ac26aaa)) 🔏

## v0.2.8 (2024-09-13)

### 🩹 Patch

  * 🐛(hm/flavors/bin): Remove sensible log output (!16) by Romain Deville ([`83cd890`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/83cd89054d7b0e9908968411566a227e4f59c176))
  * 🐛(hm/flavors/bin): Remove sensible log output by Romain Deville ([`99b65a8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/99b65a8912c43680694c92015547bc29876e2d64)) 🔏

## v0.2.7 (2024-09-13)

### 🩹 Patch

  * ⚡️(hm/flavors/bin): Improve kp script for yubikey (!15) by Romain Deville ([`4822dbf`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4822dbfa763c2f51aba0d1a71e1c4e42c8afb169))
  * ⚡️(hm/flavors/bin): Improve kp script for yubikey management by Romain Deville ([`f6275cd`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f6275cdbe23dd5a442b0440ee9ddd1de9b658710)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`35fa37d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/35fa37d21871d4e703a86476fe7111169a1f2fa7)) 🔏

### 🔊 Others

  * 🎨 Improve Yubikey management assuming single key is plugged (!14) by Romain Deville ([`b9e6cdf`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b9e6cdfa872efb3f2ce563603a1d592027e612ac))
  * 🎨 Improve Yubikey management assuming single key is plugged by Romain Deville ([`9ad45d3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9ad45d3939e99c8e95bc60414a042e5428be0df4)) 🔏

## v0.2.6 (2024-09-12)

### 🩹 Patch

  * ⬆️ Update flake.lock (!13) by Romain Deville ([`839bb32`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/839bb3210b2004b4ff389283898bfee9402a5a80))
  * ⬆️ Update flake.lock by Romain Deville ([`6b9c7b6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6b9c7b6ecb1f482b5016124180b21b92fe9a92e8)) 🔏

## v0.2.5 (2024-09-12)

### 🩹 Patch

  * ⚡️ Improve dgs_commit script with tf-docs config (!12) by Romain Deville ([`16a3819`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/16a381941d9026ab8b7192ea6ae818c4dd1cb1b3))
  * ⚡️ Improve dgs_commit script with tf-docs config by Romain Deville ([`c672b33`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c672b33afbb7a42db3099d731fee3be11c4fad66)) 🔏

## v0.2.4 (2024-09-09)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`1ad2db3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/1ad2db371fcd97b8e1e685f0aa35fb69acdabde5)) 🔏
  * 🔧(cfg/hosts/rey): Enable TF flavors for @rdeville (!11) by Romain Deville ([`a162a54`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a162a54100544d0fa45e0c5522e76c96dff00410))
  * 🔧(cfg/hosts/rey): Enable TF flavors for @rdeville by Romain Deville ([`b3712f7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b3712f7e3bddce2094a824fce223343176578ba5)) 🔏

## v0.2.3 (2024-09-09)

### 🩹 Patch

  * ✏️ Format most files &amp; update lock (!10) by Romain Deville ([`ad885ef`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ad885ef58c0e4df0d690796eb47a382b9101c6da))
  * ✏️ Format devenv.nix by Romain Deville ([`570a7a1`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/570a7a1088fd6eed2ba2689a43d292a9f96c1cf5)) 🔏
  * ✏️(hm/flavors): Format nix files by Romain Deville ([`264763b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/264763bbe2e70fbcd902fa4c6fef40068875eb49)) 🔏
  * ✏️(hm): Format default.nix by Romain Deville ([`ae0b778`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ae0b778363c72762f329e58a820266e98db1bb73)) 🔏
  * ✏️ Format flake.nix by Romain Deville ([`730f6e0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/730f6e09fd87af3367a9f895eb5f19a7df05021d)) 🔏
  * ✏️(config/hosts/rey): Format file by Romain Deville ([`6523c4e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6523c4e0bcf0692573efae077c482bfbb7bf0b7d)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`5884369`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/58843693fb704e43ed331da213a488ba1fefd1fb)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`b15e063`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b15e063da3980c7c885be3848a0d60186a4fc2c1)) 🔏

## v0.2.2 (2024-09-07)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!9) by Romain Deville ([`b7b5ff3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b7b5ff36f6ab5ba2216ec6df5a58167db86ff29c))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`875196d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/875196d0bd15e9c1c0c878932dc7bc05d0f40850))

## v0.2.1 (2024-08-27)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!8) by Romain Deville ([`6b79bd6`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6b79bd61f9d83af9bfbd700079382b82ce764e5d))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`863451a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/863451a7f97f6590ee3a89704be016cf544e2ff1))

### 🔊 Others

  * 👷 Update Gitlab CI from DGS template by Romain Deville ([`56ada5f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/56ada5f7cc140a4c0555517ba0e30a13a953b85a)) 🔏

## v0.2.0 (2024-08-27)

### ✨ Minor

  * ✨(scripts/hm): Add `upgrade` options to hm scripts (update and switch) by Romain Deville ([`b4b7ebb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b4b7ebb638643b412bc98ae98285c38172973b7d)) 🔏

### 🩹 Patch

  * ✏️(scripts): Update default local_inputs.sh values by Romain Deville ([`284b55f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/284b55fa39fea1116df419c882036dc95aa39b6b)) 🔏
  * 🐛 Improve dgs_commit script to only add .envrc (!7) by Romain Deville ([`6e37e06`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6e37e068bc8661c72404a3094d0d0414d811e64a))
  * 🐛 Update dgs_commit script to only add .envrc by Romain Deville ([`6a0d09a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6a0d09a61500dcb0b9a561fc258faa1ded82808b)) 🔏
  * 📌 Update flake.lock by Romain Deville ([`b18309a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b18309a62e33c79cde13038451502aba14b0776d)) 🔏

### 🔊 Others

  * 💚 Fix CI from DGS Template by Romain Deville ([`3ad81fe`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3ad81fe15cb3a2342917c9d4c1c480fd69465574)) 🔏

## v0.1.4 (2024-08-23)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!6) by Romain Deville ([`d752348`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d752348d893b82798c2b4d11d836662972b6f81b))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`87d9acd`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/87d9acd7f7e4114cd37fc418bfc90f0e5171a10f))

## v0.1.3 (2024-08-19)

### 🩹 Patch

  * 🐛 Fix bugs in script dgs_commit (!5) by Romain Deville ([`eda92aa`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/eda92aa0b5a2c90641407d6fd1cbf2cf83468ed0))
  * 🐛(hm/flavors/bin): Update scripts dgs_commit by Romain Deville ([`f587ccb`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f587ccb6e0918fffe12db82d0c14afa9537ef8bf)) 🔏
  * 📌 Update flake.lock by Romain Deville ([`92da424`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/92da424ddd41f5cf52c774fc8fd2e7c280313bf3)) 🔏

## v0.1.2 (2024-08-18)

### 🩹 Patch

  * ⚡️ Improve scripts and update config from DGS (!4) by Romain Deville ([`82cd728`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/82cd728824e46277ae243c9a906dc4cd9b007cd6))
  * ⚡️(scripts): Improve scripts allowing to build locally by Romain Deville ([`eee9b1f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/eee9b1f3d10b0da26524a8c243d22881c664450c)) 🔏
  * 📦️ Update flake.* from DGS by Romain Deville ([`e416036`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e416036403c90b24e2d11dc011aa7cf7c755cf61)) 🔏

### 🔊 Others

  * 💚 Update Gitlab CI from DGS by Romain Deville ([`c98464b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c98464b46d0c8b25afba5ae78f2174e1523a87ca)) 🔏
  * 📝 Update README from DGS by Romain Deville ([`91ddbea`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/91ddbea9fa6d925cc8d287426863752ce4b67596)) 🔏
  * 🔨 Update devenv from DGS by Romain Deville ([`680d926`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/680d926e0f26751df59f1080d226e4e29bb9861b)) 🔏

## v0.1.1 (2024-08-18)

### 🩹 Patch

  * ✏️ Fix typos in configs/default.nix (!3) by Romain Deville ([`522349e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/522349e597d7ecf3202e94834878f3e0e793c2ed))
  * ✏️ Fix typos in configs/default.nix by Romain Deville ([`c58343f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c58343f9bd58147355b74ee896b6e6ecdb820c6f)) 🔏

## v0.1.0 (2024-08-18)

### ✨ Minor

  * ✨ First version of my private NixOS/HM Config (!2) by Romain Deville ([`34e2b74`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/34e2b746af6a243d91d118eb11983c00274a3eef))
  * ✨(hm): Add HM default.nix by Romain Deville ([`838e427`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/838e4273f07221bf1bb92e4857d3134fa6a6ad57)) 🔏
  * ✨(hm/presets/main): Add SSH host config by Romain Deville ([`b11ef5e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/b11ef5efd308b0932083974844ef078815943062)) 🔏
  * ✨(hm/flavors/bin): Add bin flavors to setup my scripts by Romain Deville ([`7a26ac9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7a26ac9985dfbc57b567e7a2d871e7c9222eb3b6)) 🔏
  * ✨ Add config secret rey rdeville by Romain Deville ([`dbab7b0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/dbab7b059a0aa1c0e2500a18e987727c20073a63)) 🔏
  * ✨ Add config account default.nix by Romain Deville ([`9b4425b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9b4425bb64b07ea2b1c80063260545d45ebc5d9f)) 🔏
  * ✨ Add config accounts rdeville by Romain Deville ([`6b7a72c`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/6b7a72ce3c0883d2bcc1333dc52dd5bfa48225da)) 🔏
  * ✨ Add config host default by Romain Deville ([`06c4944`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/06c4944dcda1bd238fc3074f42df50bc3b7522b1)) 🔏
  * ✨ Add config host rey by Romain Deville ([`46fb5e5`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/46fb5e57bd3e7187fd76cf9dc25d84b4185ff1e2)) 🔏
  * ✨ Initialise repo and add host configuration (!1) by Romain Deville ([`3f6f353`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3f6f3538f2afcb2c2c5b6c525cf2d43308d0c6ed))
  * ✨ Add config default.nix by Romain Deville ([`83dce2d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/83dce2dd4ea4ffdb7f30ae6fb23f0ceff8d7bd8f)) 🔏
  * ✨ Add config vms by Romain Deville ([`f314bf2`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f314bf2a0a6919b4e27afca68318028215a3c900)) 🔏
  * ✨ Add config secret rey rdeville by Romain Deville ([`d571817`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/d571817fc090d110dfef56a10e60531a716a99b3)) 🔏
  * ✨ Add config account default.nix by Romain Deville ([`1ef3de3`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/1ef3de3f1181c22a6dbcd784af40bca2afc988a3)) 🔏
  * ✨ Add config accounts rdeville by Romain Deville ([`4ef6b5a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/4ef6b5a3d63d2c9625d758c54288e74ade9f37fd)) 🔏
  * ✨ Add config host default by Romain Deville ([`e29c62d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e29c62de95e853c6bd0b464f85921ab66f7e3802)) 🔏
  * ✨ Add config host rey by Romain Deville ([`ed78691`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/ed78691dc03f7da09afeda68432b02175352a3b9)) 🔏

### 🩹 Patch

  * 🔧 Add .dotgit.yaml by Romain Deville ([`26053d7`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/26053d7d0068dd3244e107e9bb7e48161322d03c)) 🔏
  * 🔧 Add .sops.yaml configuration by Romain Deville ([`bd40dac`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/bd40dacf80e9bf8934651f1e4c0f896343484205)) 🔏
  * 🔧 Add .dotgit.yaml by Romain Deville ([`321cf65`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/321cf650024b283c22d83564230762e567f56c64)) 🔏

### 🔊 Others

  * 👷 Add Gitlab CI Build System by Romain Deville ([`13323fd`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/13323fd84154041b01fff6a58c2389b352a7912a)) 🔏
  * 👷 Add Gitlab CI Build System by Romain Deville ([`13871f9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/13871f9d8c48ec20ffc6a0e471a3a957b4f8a962)) 🔏
  * 📄 Add LICENSES by Romain Deville ([`0a0d2d0`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/0a0d2d00a62a0d6a575de9106598aba97636a07a)) 🔏
  * 📄 Add LICENSES by Romain Deville ([`a6dfd1d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/a6dfd1de64278be6752a18401d14973e9fb9134f)) 🔏
  * 📝 Update README.md by Romain Deville ([`9ad223a`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/9ad223ab9dc229671489dafc4f0a4cb474bbb90f)) 🔏
  * 📝 Update README.md by Romain Deville ([`3b79cfa`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/3b79cfa39cfb2b6b785f6f6588a8c51181ed02ff)) 🔏
  * 📝 Add CODE_OF_CONDUCT.md by Romain Deville ([`7770cdd`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/7770cddc1ecbd2779d72cd3fb012a3c08f9c69d5)) 🔏
  * 🔨 Add flake.nix and flake.lock by Romain Deville ([`df6343f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/df6343fe0a613f18bdf3454bf60c94e98a51adce)) 🔏
  * 🔨 Add scripts tools by Romain Deville ([`2b5b57f`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/2b5b57f67a6e2112ae6226a96df1e9731346c28d)) 🔏
  * 🔨 Add devbox configuration by Romain Deville ([`e4b41ba`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e4b41ba9841261e453ad540b715b17ffc91989ca)) 🔏
  * 🔨 Add python-semantic-release configuration by Romain Deville ([`5fe7446`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5fe74461464886dd828b14f595e9ec9f919c97be)) 🔏
  * 🔨 Add markdownlint configuration by Romain Deville ([`edd633b`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/edd633b5572da78de97ca8dcd3e66772b8bc03b6)) 🔏
  * 🔨 Add .envrc by Romain Deville ([`f0ab654`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f0ab654f2b7958e7ff0ef95c9a048a216b95f0f6)) 🔏
  * 🔨 Add flake.nix and flake.lock by Romain Deville ([`e4bdf16`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/e4bdf1603af888fbc5bcad4c1cb97349c18cddae)) 🔏
  * 🔨 Add scripts tools by Romain Deville ([`5b28c19`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/5b28c192c51795466a2c73a47962678c8aa4fa4b)) 🔏
  * 🔨 Add devenv.nix configuration by Romain Deville ([`800158e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/800158eae5792f0ebaf7b956d74ad8e8441596e3)) 🔏
  * 🔨 Add devbox configuration by Romain Deville ([`86878e9`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/86878e99d8c696e87182bcf73fd66a2d93f3d18a)) 🔏
  * 🔨 Add python-semantic-release configuration by Romain Deville ([`8e939c8`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8e939c8eb8c45ecd4da2f80857ae1b0ad57ab622)) 🔏
  * 🔨 Add markdownlint configuration by Romain Deville ([`0144460`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/01444606cfcddec26b302a57f6c05e9193d7e49e)) 🔏
  * 🔨 Add commitlint configuration by Romain Deville ([`c5e1b15`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/c5e1b1508072980c50c787bd0ecc6baf830794fe)) 🔏
  * 🔨 Add cspell configuration by Romain Deville ([`f5c9158`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f5c91587614048d9f9da9acf248963fd29f82cc1)) 🔏
  * 🔨 Add pre-commit-config.yaml by Romain Deville ([`88b8b4e`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/88b8b4e3c36e06088e42d21e9e575993d2512147)) 🔏
  * 🔨 Add .editorconfig by Romain Deville ([`8be1297`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/8be1297bc5d1dda32d4fdbf83d19460f0eba2fd5)) 🔏
  * 🔨 Add .envrc by Romain Deville ([`84f5a4d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/84f5a4de773eb5145d2463a436139079de7c71bd)) 🔏
  * 🙈 Add .gitignore by Romain Deville ([`955469d`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/955469de99c18618903597041feaae6eab54d62e)) 🔏
  * 🙈 Add .gitignore by Romain Deville ([`f9f9fde`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/f9f9fdea913cb6b4feae493aaa974ef04b86116d)) 🔏

## v0.0.0 (2024-08-18)

### 🔊 Others

  * 🎉 Initial Commit by Romain Deville ([`1312109`](https://framagit.org/rdeville-private/dotfiles/nixos/-/commit/1312109f5250423f42d18dfa0805e4df872a2758)) 🔏
