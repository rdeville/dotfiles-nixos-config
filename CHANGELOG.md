<!-- markdownlint-disable-file -->
# CHANGELOG

## v0.44.0 (2025-09-17)

### ✨ Minor

  * ✨(hm/gui/wayland): Add hyprpaper support and improve waybar (!149) by Romain Deville ([`e169d8f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e169d8ff892379a69a3b639de3b4eadf1b44895a))
  * ✨(hm/gui/wayland): Add hyprpaper support with wallpaper randomizer by Romain Deville ([`7ee4873`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7ee48731c07e8daea0773ce134f279edcc9d61cf)) 🔏

### 🩹 Patch

  * 🔧(hm/gui/wayland): Improve waybar config with new design by Romain Deville ([`6831cca`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6831cca97a44f788e599305ac3777e6f24bc6642)) 🔏

## v0.43.7 (2025-09-05)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`92a570c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/92a570cba4ad3003f581a6e637b4c8900f2e286a)) 🔏
  * 🔧(os/net): Force network.links empty to avoid auto-configuration (!148) by Romain Deville ([`779a231`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/779a2315bba868cc6dfa32d4568dad36a93127d8))
  * 🔧(os/net): Force network.links empty to avoid auto-configuration by Romain Deville ([`ec9bc9f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ec9bc9f2719b65d2a7f594e564f822a337bbd4c4)) 🔏

## v0.43.6 (2025-09-03)

### 🩹 Patch

  * 📦️(_gui/wayland): Add nwg-displays package if hyprland is installed (!147) by Romain Deville ([`fd2b013`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fd2b013a28caba6411a3cec89e138633a42ac332))
  * 📦️(_gui/wayland): Add nwg-displays package if hyprland is installed by Romain Deville ([`9933574`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9933574654d297a6018149b7ffa7fbe704765b47)) 🔏

## v0.43.5 (2025-09-03)

### 🩹 Patch

  * ⚡️(os/network): Update network do deactivate dhcpcd is networking.useDHCP=false (!146) by Romain Deville ([`1732e6e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1732e6e9a92ec84cb9e06a6dce493ac182184394))
  * ⚡️(os/network): Update network do deactivate dhcpcd is networking.useDHCP=false by Romain Deville ([`70c8cb5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/70c8cb51889da67566e73041556e1255fb844668)) 🔏
  * 👽️(hm/_core/fastech): Update config due to fastfech config changes by Romain Deville ([`7475c8c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7475c8c95f8d4745f70da96c69449b7cf7c51848)) 🔏

## v0.43.4 (2025-09-01)

### 🩹 Patch

  * ⚡️(os/k3s): Add isci workaround for Longhorn (!145) by Romain Deville ([`b21b486`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b21b486fe1d144d602287b35b752fb6a0b20c62c))
  * ⚡️(os/k3s): Add isci workaround for Longhorn by Romain Deville ([`c45d3b7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c45d3b7cbbb4cb21ca6932736a22d9e71a068545)) 🔏

## v0.43.3 (2025-08-28)

### 🩹 Patch

  * 🔧(os/network): Remove text if no port are opened (!144) by Romain Deville ([`711c5c9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/711c5c921807eaa2836d4026c197ad4f04485581))
  * 🔧(os/network): Remove text if no port are opened by Romain Deville ([`80fddeb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/80fddeb768f8cfc2559a1914737f7c0fbdd5b5ac)) 🔏

## v0.43.2 (2025-08-28)

### 🩹 Patch

  * 👽️(hm): Update HM modules (nix.gc and ssh-client) due to HM changes (!143) by Romain Deville ([`5c385d3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5c385d3d8925eb07feb4269e2bcaff9e2729cff8))
  * 👽️(hm/ssh-client): Update module to remove default and use matchBlocks by Romain Deville ([`63e8179`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/63e8179605a7c3821d8a9534184890cece049717)) 🔏
  * 👽️(home-manager): Bump to 25.05 and update nix.gc.frequency to nix.gc.date by Romain Deville ([`5f3336c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5f3336cb055570859ed071a76b6765f637496635)) 🔏

## v0.43.1 (2025-08-28)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`9b4fce0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9b4fce06b6c57c27ebc3bc6c080074f3e85b37b9)) 🔏
  * 🔧(os/k3s): Deactivate local-storage &#39;cos I&#39;ll use rook-ceph (!142) by Romain Deville ([`b3766e9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b3766e980c5a22392c6eb1200de8b0460927920b))
  * 🔧(os/k3s): Disable local-storage from k3s &#39;cos I&#39;ll use rook-ceph by Romain Deville ([`1370cb4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1370cb4cf356cf4021f0a07ec6509b11863ed59e)) 🔏

## v0.43.0 (2025-08-05)

### ✨ Minor

  * ✨(os/net): Add new option for extraRules and refacto module by Romain Deville ([`09ec2f4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/09ec2f406bc03c7f473cf4b4dbec34b0392329c1)) 🔏

### 🩹 Patch

  * ⚡️ Add labels and taint support to k3s, opti nftable and add firefox addon (!141) by Romain Deville ([`dcf080d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/dcf080deb5d8b2ea2d56c5ebef0319401023a0d4))
  * ⚡️(k3s): Add labels and taints option to module for k3s node by Romain Deville ([`1a3a723`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1a3a7232ed9bb9bb5a841417854c58b9638fc5c9)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2508f03`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2508f0383dc6ac6e739603be0141e67c2aabe2c1)) 🔏
  * 🔧(hm/gui/firefox): Add Environment Marker addons by Romain Deville ([`6e254d8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6e254d89b64155193461cac7336dafe4ae2a0b22)) 🔏

## v0.42.0 (2025-08-03)

### ✨ Minor

  * ✨(os/network): Upgrade module to better manage and generate nftables (!140) by Romain Deville ([`d09fe4e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d09fe4e9da28fd27557e9f9ce823a4e6583cbca5))
  * ✨(os/network): Upgrade module to better manage and generate nftables by Romain Deville ([`b0037c9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b0037c9a9bbed8ee0bac8597e803f19dbe4c2293)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`b1db1f9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b1db1f97cf4175798ca0111b33a6e2a8cd5f6b70)) 🔏

## v0.41.10 (2025-07-29)

### 🩹 Patch

  * ⚡️(os/net): Improve forward rules with trustedInterfaces (!139) by Romain Deville ([`bbe0671`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bbe0671de427945c4cf29fc4f3034514998a8846))
  * ⚡️(os/net): Improve forward rules with trustedInterfaces by Romain Deville ([`335fe48`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/335fe48333ff10800b1aa779d8c21deaa65db6f9)) 🔏

## v0.41.9 (2025-07-28)

### 🩹 Patch

  * 👽️(hm/_core): Update zsh dotdir path to be absolute due to HM update (!138) by Romain Deville ([`1769510`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1769510d14307ae1055ef976ac6736406799612d))
  * 👽️(hm/_core): Update zsh dotdir path to be absolute due to HM update by Romain Deville ([`6ae1ab7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6ae1ab713c5194db387b9f6d3e868d1f0a967138)) 🔏

## v0.41.8 (2025-07-28)

### 🩹 Patch

  * ⚡️(hm): Update discord to use OSS Vesktop and starship k8s segment (!137) by Romain Deville ([`3f38fe6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3f38fe6a765dd70e4cc191f145b2713c2e3fd12c))
  * ⚡️(hm/discord): Replace discord with it OSS alternative Vesktop by Romain Deville ([`ecd911f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ecd911f04e33c8e1587c331186dbd2ac1be6c40c)) 🔏
  * 🔧(hm/_core): Update starship segment kubernetes by Romain Deville ([`0b01139`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0b011398f3fb54e37bc51d4b1043872cd376521b)) 🔏

## v0.41.7 (2025-07-28)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`cb10373`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cb10373bc457c27deec80565b94ea3db008fabcf)) 🔏
  * 🔧(os/net/wg): Remove PersistentKeepalive from server, client must do it (!136) by Romain Deville ([`43ca8f5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/43ca8f5e5de0bc2b697f9cba9fde7d60f2de7036))
  * 🔧(os/net/wg): Remove PersistentKeepalive from server, client must do it by Romain Deville ([`bce8dec`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bce8dec10601d5f2b8a0599aa47c1cf4028dbee7)) 🔏

## v0.41.6 (2025-07-27)

### 🩹 Patch

  * ⚡️(os/users): Improve module to add groups define as user.extraGroups (!135) by Romain Deville ([`5c4462d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5c4462db7300f02403be50c9f5cdf6a959838c6c))
  * ⚡️(os/users): Improve module to add groups define as user.extraGroups by Romain Deville ([`aaaf896`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/aaaf8966522387fab6faca132e706a4d57a56503)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`c73bab5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c73bab572f1893755c854d024bd92382fdf37aee)) 🔏

## v0.41.5 (2025-07-27)

### 🩹 Patch

  * 🔧(os/net): Improve module firewall and nftable configuration (!134) by Romain Deville ([`3389878`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3389878067edc59c7f1878c0423134494b75b1a1))
  * 🔧(os/net): Improve module firewall and nftable configuration by Romain Deville ([`ae36fd1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ae36fd11d4a3b8ce055da7cd5c08487385e3bf59)) 🔏

## v0.41.4 (2025-07-26)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`c188e1c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c188e1cf86eff8cd2a1d780fb6a5ce3af9a696eb)) 🔏
  * 🐛(os/network): Fix wrong interface in nftable forward rule (!133) by Romain Deville ([`7d09f9d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7d09f9db5235407e3dd5357ae15d2291af0e80e2))
  * 🐛(os/network): Fix wrong interface in nftable forward rule by Romain Deville ([`0369526`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/03695263c8d39033044cb2b9b075fbada1875694)) 🔏

## v0.41.3 (2025-07-25)

### 🩹 Patch

  * ⚡️(os/network): Review network module (matchConfig and topology) (!132) by Romain Deville ([`8406acb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8406acbc6a2fc22d6d9775ebce7d8e8868cf50b1))
  * ⚡️(os/network): Improve network configuration (MatchConfig &amp; topology) by Romain Deville ([`bde40c9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bde40c94935c9bb973bd87f75289ef5e189044d3)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`1c8fd42`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1c8fd4291dd6a2aa53cb3d7cce197062c1c30eb9)) 🔏

## v0.41.2 (2025-07-24)

### 🩹 Patch

  * ⚡️(os/network): Improve module with two new options (firewall.debug and nftables.defaultPolicy) (!131) by Romain Deville ([`efa1574`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/efa15746a0143c37d5c6e4fe2114b349088c2b9e))
  * ⚡️(os/network): Improve option for module network (debug and defaultPolicy added) by Romain Deville ([`317ad78`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/317ad7864b65bef46476947342e542f11b316493)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`c59f0ab`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c59f0ab1952491f3f9a1e66ff5c80d3ac4f25714)) 🔏

## v0.41.1 (2025-07-22)

### 🩹 Patch

  * ⬆️ Update flake.lock (!130) by Romain Deville ([`4ff644f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4ff644f20baac37e2b5ed7e408445b0fe61ece42))
  * ⬆️ Update flake.lock by Romain Deville ([`1cf822f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1cf822fdb25cb7d1a60fc98bb5502cf762cdeebe)) 🔏

## v0.41.0 (2025-07-21)

### ✨ Minor

  * ✨(os): Add network modules and minor fixes (!129) by Romain Deville ([`d279940`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d27994057a14285db71c10fbffa6e133eaa9e14f))
  * ✨(os/network): Add module to configure vlans by Romain Deville ([`f91120c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f91120cad10eb37b7d0bc5735cf53a83da7c144c)) 🔏
  * ✨(os/network): Add wireguard flavor to ease wireguard config by Romain Deville ([`42d265d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/42d265d1d8a58e40ffaadd9122b5764dd5510211)) 🔏
  * ✨(os): Add network flavors to ease router and net config by Romain Deville ([`58363a0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/58363a0dcda67b944a2292fe0327fd69aa98e046)) 🔏

### 🩹 Patch

  * ⚡️(os): Update nix.settings with lib.mkDefault by Romain Deville ([`b8e7bde`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b8e7bde4166c5ca096890da634a01c688369ff36)) 🔏
  * ➕(flake): Add input topology by Romain Deville ([`e534562`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e5345622e334accd0c363dbc86f0d9052c0e3087)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`adb772d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/adb772d2bbd9aba43ef73c1563a646fa899cbffe)) 🔏
  * 🍱(assets): Add topology interfaces assets by Romain Deville ([`427ed37`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/427ed370ed0becc16dfdcdb0b52a8875b520273d)) 🔏
  * 🐛(os/k3s): Fix k3s flavor to pass args when node is agent by Romain Deville ([`aa431ae`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/aa431ae7322240d8da59e539496dc4b15fa2c7a6)) 🔏

## v0.40.1 (2025-07-10)

### 🩹 Patch

  * 🐛(os/k3s): Fix k3s flavor to pass args when node is agent (!128) by Romain Deville ([`30a526e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/30a526e0a3a46c2134b49b9a47642868a7437cc3))
  * 🐛(os/k3s): Fix k3s flavor to pass args when node is agent by Romain Deville ([`9646f64`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9646f647686241fdbbc92db7fc3064c39e58e616)) 🔏

## v0.40.0 (2025-07-06)

### ✨ Minor

  * ✨(os): Add parentName options to be used in VM/container (!127) by Romain Deville ([`13a64e8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/13a64e872a42e5e201b64d9de17768b4abd375f5))
  * ✨(os): Add parentName options to store host name when in VM/container by Romain Deville ([`c7cb6a0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c7cb6a0b21a7f7c8bbb897c2d3b86705631f0180)) 🔏

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`866af94`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/866af9437a6badef9b2f25892938f6b9014625c2)) 🔏
  * 🔧(os): Bump stateVersion to 25.05 by Romain Deville ([`6e9b374`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6e9b374626785547b74fce390820113bd304bd49)) 🔏

## v0.39.1 (2025-07-03)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`b1fa878`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b1fa878c276324dc0129a00c0090f2f48abfbcd0)) 🔏

### 🔊 Others

  * 🔥(os): Drop allowUnfree from module (!126) by Romain Deville ([`035a2c1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/035a2c12cdaadd21235d68e71481c2591578a960))
  * 🔥(os): Drop allowUnfree from module by Romain Deville ([`a6d038c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a6d038c0518e1c1b6f24bfd7a58ed1b2c4bf68ec)) 🔏

## v0.39.0 (2025-07-01)

### ✨ Minor

  * ✨(os): Add option to manage config using nixpkgs stable or unstable (!125) by Romain Deville ([`8a599fb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8a599fb99dd39922e7ea18466b70f1fb05b04fee))
  * ✨(os): Add option isProd to specify stable or unstable nixpkgs config to use by Romain Deville ([`2a44a05`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2a44a0528b324ccf82e2e49c55b0a321718552fb)) 🔏

### 🩹 Patch

  * ⚡️(os/flavors): Update flavor to manage nixpks stable and unstable by Romain Deville ([`4126f57`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4126f5747cb6c415af1ee6aed41b4e882f80355b)) 🔏

### 🔊 Others

  * 🔥(hm/core): Remove devenv pkgs since I don&#39;t use it anymore by Romain Deville ([`dfffabd`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/dfffabdcfe15539ddbbd7a3f13b7a638918c2656)) 🔏
  * 🔥(os/_core): Remove default networking.nameservers (!124) by Romain Deville ([`bd68c48`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bd68c48ef480da18ad540cc0edc0bdb903a4876c))
  * 🔥(os/_core): Remove default networking.nameservers by Romain Deville ([`67e435f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/67e435f350dce52b5e61338f4f1a78a68429e5f9)) 🔏

## v0.38.0 (2025-06-30)

### ✨ Minor

  * ✨(flavor/ssh-server): Add ports and openFirewall option to flavors (!123) by Romain Deville ([`fb96ae4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fb96ae428920f460d45641bd8496a8179c1ae07f))
  * ✨(flavor/ssh-server): Add ports and openFirewall option to flavors by Romain Deville ([`b1088ff`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b1088ff5741ecc507a30a7b406644ae3e3ea7b14)) 🔏

## v0.37.16 (2025-06-30)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`1e85b30`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1e85b30f8bf89b11ef359ba365516c4e9cddba1c)) 🔏

### 🔊 Others

  * 🔥(lib): Remove function importDir from my lib and every call to it (!122) by Romain Deville ([`f0becf5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f0becf5e9ff6b4e6156033709344cbfb46196272))
  * 🔥 Remove all usage of function importDir by Romain Deville ([`c59433d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c59433da2026061bc04f8877866597f8c903b78b)) 🔏
  * 🔥(lib): Remove method importDir since causing issues in NixOS containers by Romain Deville ([`94a3832`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/94a38329047e3c345e2ad402a9dbc18e96401d5c)) 🔏

## v0.37.15 (2025-06-19)

### 🩹 Patch

  * 🐛(hm/_core): Fix dircolors configuration from ls-colors inputs (!121) by Romain Deville ([`a05fe91`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a05fe912cf99dad702af2fd74467ac95a3310ab6))
  * 🐛(hm/_core): Fix dircolors configuration from ls-colors inputs by Romain Deville ([`7f41a5e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7f41a5e49afb1fbe94e91babe99155d265b3e7c9)) 🔏

## v0.37.14 (2025-06-19)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`af130eb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/af130eb7a1b9cb49581fc53929560da10f0fb2d2)) 🔏
  * 🐛(os): Fix gdm definition in wrong block &amp; format files (!120) by Romain Deville ([`0ac57e8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0ac57e835f5cbb2957363a1c9a8e939b252875ed))
  * 🐛(os/window-manager): Fix gdm definition in wrong service by Romain Deville ([`1098ed2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1098ed2aefd103a8eb43b86242ea715b3c25cc5e)) 🔏

### 🔊 Others

  * 🎨(hm/_core): Format files by Romain Deville ([`95653e4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/95653e4dd029274b3c6fbd48cc086f4a63feb06d)) 🔏

## v0.37.13 (2025-06-18)

### 🩹 Patch

  * ⚡️(hm/_core): Set dircolors now use inputs.ls-colors by Romain Deville ([`9bda2ab`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9bda2ab07a6933b769a570e916d76d66ad6333bd)) 🔏
  * ➕(flake): Add ls-colors as input now by Romain Deville ([`5a251a4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5a251a4119a9eea918c3828b37b39988ad73af6b)) 🔏
  * ➖(hm/_gui): Remove hyprswith module since I don&#39;t use it (!119) by Romain Deville ([`d7433a4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d7433a4bf8d9fb1a6323cb7187b201710ffadf99))
  * ➖(flake): Remove hyprswitch from flake.nix by Romain Deville ([`4b49f1f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4b49f1f80221f678ebfcfebf535ffe774765f0fb)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`0898d07`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0898d070297f4f3e261ba0d9da2c83dc501a1efe)) 🔏
  * 👽️(os/display-manager): displayManager moved from svc.xserver to svc.displayManager by Romain Deville ([`b428bb5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b428bb54da3b8098258f92ff99e3a0557c3502c1)) 🔏

### 🔊 Others

  * 🔥(hm/_gui): Drop hyprswitch support since I don&#39;t use it by Romain Deville ([`f5d9d94`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f5d9d94acf738e7b7deebe1898569c5281b63dd4)) 🔏

## v0.37.12 (2025-06-01)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`1cdf94f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1cdf94f1576b47a2242d7c1ace455335ba939a48)) 🔏
  * 👽️(hm/_core): Remove thefuck from flavors since removed from HM (!118) by Romain Deville ([`3f3ec8e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3f3ec8e57172c9dda98846df7b2f652b2d4e36fa))
  * 👽️(hm/_core): Remove thefuck from flavors since removed from HM by Romain Deville ([`4aa8a1b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4aa8a1b323e608e5c4a39b452425c757f62c6d35)) 🔏

## v0.37.11 (2025-05-26)

### 🩹 Patch

  * 🐛(hm/_core/starship): Fix separator and modules for starship (!117) by Romain Deville ([`a2fe01c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a2fe01cd7298944813200c13479d69011a67725c))
  * 🐛(hm/_core/starship): Fix separator and modules for starship by Romain Deville ([`2a224a3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2a224a376152551e37e8aec3a2b5283a3e223674)) 🔏
  * 🔧(hm): Update starship prompt module &amp; wayland config (!116) by Romain Deville ([`37463e9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/37463e9b90d887b3228e811f7cfdb7680faba06e))
  * 🔧(hm/_gui/wayland): Update module by Romain Deville ([`9b8c545`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9b8c545c60302ed118b01fb30bcc337e7e417dcb)) 🔏
  * 🔧(hm/_core/starship): Update user and hostname module display by Romain Deville ([`edf63ae`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/edf63aefe5ca4cd72d5aa7de335237183adc8edd)) 🔏

## v0.37.10 (2025-05-17)

### 🩹 Patch

  * ⬆️ Upgrade devbox.lock by Romain Deville ([`2b54da6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2b54da60343da268baa647640a18b41d9bc90909)) 🔏
  * 🐛(hm/_core/zsh): Fix zsh autocompletion with files for sops (!115) by Romain Deville ([`bf5bfba`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bf5bfbaaeb1266af2e02c6d843bca2f190b59b7a))
  * 🐛(hm/_core/zsh): Update zsh completions for sops by Romain Deville ([`3235648`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/32356489c37e221129243db5231495e88afeb678)) 🔏

### 🔊 Others

  * 🎨(hm): Format nix files (!114) by Romain Deville ([`7da3e8a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7da3e8ae530952f6b35d405d6efb94ed22d8e5b7))
  * 🎨(hm): Format nix files by Romain Deville ([`3f56e85`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3f56e85ce06326ce6def3b434d3cdf4bec907cb5)) 🔏

## v0.37.9 (2025-05-05)

### 🩹 Patch

  * 👽️(hm/_core): Update flavor due to HM modules update (!113) by Romain Deville ([`8849656`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/884965602475b1ac99ab13bf578d4723451e3a4a))
  * 👽️(hm): Update flavors due to HM modules update by Romain Deville ([`8f19d95`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8f19d95e01c790ca5bd104859755bd609e40aa57)) 🔏

## v0.37.8 (2025-04-26)

### 🩹 Patch

  * ⚡️(flake): Make OS and HM ignore machines/_* and machines/*/_* folders (!112) by Romain Deville ([`fe5fa2c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fe5fa2c1cdc0d70807ff247bf849656215813d32))
  * ⚡️(flake): Make OS and HM ignore machines/_* and machines/*/_* folders by Romain Deville ([`2e3f306`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2e3f306d5d757c573d6f8dfd5683d0e41df89350)) 🔏

## v0.37.7 (2025-04-21)

### 🩹 Patch

  * ⚡️ Update default values for some modules (!111) by Romain Deville ([`b8c3bb7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b8c3bb7e611f988019c6cc2c7da55655aa872f15))
  * ⚡️(os): Add isMain and isGui options to module by Romain Deville ([`fe89ecd`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fe89ecd9527d5568115678f74e709cf84640b737)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`e437e29`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e437e2986dd103a16e28c735cdc0ebc7f5c90311)) 🔏
  * 🐛(hm/ssh-client): Fix wrong type in option for the module by Romain Deville ([`f205355`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f205355ac56214c16102378cfa121fbf096e5dfe)) 🔏
  * 🔧(hm/_gui): Update hyprspace and hyprswitch default disabled by Romain Deville ([`20d45e1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/20d45e1bc6c854c1660695044944a17a2d6b520a)) 🔏

## v0.37.6 (2025-04-20)

### 🩹 Patch

  * 🐛(os/k3s): Fix options passed to k3s when node is agent (!110) by Romain Deville ([`a89d741`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a89d741f2f126f480aac96ba2dbde71ed0a14846))
  * 🐛(os/k3s): Fix options passed to k3s when node is agent by Romain Deville ([`ba65e9f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ba65e9f0ebde5553c89885f3481bc5e4e19350ae))

## v0.37.5 (2025-04-20)

### 🩹 Patch

  * 🐛(os/k3s): Fix options passed to k3s when node is agent (!109) by Romain Deville ([`7d04c7f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7d04c7ff4df809b4b3998bbf834eb55389c1812c))
  * 🐛(os/k3s): Fix k3s arguments passed when node is agent by Romain Deville ([`b46d657`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b46d657025657616d1755f0e73a0f9246406ad76)) 🔏

### 🔊 Others

  * 🎨 Format nix files by Romain Deville ([`93d00c2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/93d00c2f014db3695f9f2db6b706cf321bea9ee7)) 🔏

## v0.37.4 (2025-04-20)

### 🩹 Patch

  * ✏️(os/audio): Remove useless variable in module by Romain Deville ([`7f92e36`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7f92e360160b9ab70e873ff1bd37d267b6791253)) 🔏
  * 🐛(os/k3s): Fix options usage for the flavor (!108) by Romain Deville ([`2d9f4b9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2d9f4b9d2d5d954322b735b3e9b58346525964dc))
  * 🐛(os/k3s): Fix options usage in flavor by Romain Deville ([`ae14238`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ae14238ae03e04c3cb7c978f7547771e935003aa)) 🔏

## v0.37.3 (2025-04-19)

### 🩹 Patch

  * ✏️(os): Fix default value for system (a.k.a hostPlaform) (!107) by Romain Deville ([`7c9ec41`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7c9ec41fa9b4f51fe0d97d6e924f77f7f98eb0de))
  * ✏️(os): Fix default value for system (a.k.a hostPlaform) by Romain Deville ([`d9008b4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d9008b4603a0b0e5dd5a2d533718cecdd5df4b9f)) 🔏

## v0.37.2 (2025-04-19)

### 🩹 Patch

  * ⚡️ Mainly improve flavors default options and new options (!106) by Romain Deville ([`c501e64`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c501e64382ac74f7ec71da0b3fb84b5d17591914))
  * ⚡️(os): Update default nixos configuration by Romain Deville ([`2c92a7f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2c92a7f2841153d23d302c21d0f8ccb4d2543d50)) 🔏
  * ⚡️(hm): Improve HM by using osConfig by default if set by Romain Deville ([`2397e03`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2397e0392335ae3e1c87f6a4be2a0b531e0eb4be)) 🔏
  * ⚡️(hm/_core): Disable auto-upgrade if install from NixOS configuration by Romain Deville ([`d1304da`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d1304da84c0879b406d339e6e4925dd3e2436342)) 🔏
  * ⚡️(os/k3s): Improve k3s behaviour using nftables and new options by Romain Deville ([`b3259e7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b3259e753526e85cfdc483687bd41f4148bd8e5b)) 🔏
  * 🔧(machine/dev-min): Remove redondant boolean by Romain Deville ([`e4450d8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e4450d8ef58f9d324da1b31c7f86fbe850b98de1)) 🔏
  * 🔧(os/window-manager): Enable all window-manager by default by Romain Deville ([`3a4a800`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3a4a800d479b2a794148f9773cd526749fe7b943)) 🔏
  * 🔧(os/display-manager): Set ly as default display-manager by Romain Deville ([`1ab9a96`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1ab9a96dd445b6cc6a8400959a54d8bd9aa35b21)) 🔏

### 🔊 Others

  * 🎨(hm/ssh-client): Format HM flavor ssh-client by Romain Deville ([`d150c2b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d150c2b4655c49b36699305b091cb005d3e1dc58)) 🔏

## v0.37.1 (2025-04-13)

### 🩹 Patch

  * ⚡️(os): Improve k3s and _core flavors (!105) by Romain Deville ([`69b37d1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/69b37d1235506ffb97037d0b74513c04121c5681))
  * ⚡️(os/_core): Add IPv6 FDN DNS IPs by Romain Deville ([`cdb95c4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cdb95c439c4a8d28f7b1189f5428ca93ecf46ce2)) 🔏
  * ⚡️(os/k3s): Re-enable firewall and update default config by Romain Deville ([`cc7e3ec`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cc7e3ec2d40bc64d1f4845f61c3208eb12b27e1f)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`95bcca0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/95bcca0eaaffd1c8fbba977a363f0b2cdbca830f)) 🔏

### 🔊 Others

  * 🔥(hm/_gui): Remove hyprexpo module since I do not use it by Romain Deville ([`c9dfe67`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c9dfe676c096475905c0242fe995a019d519b8db)) 🔏
  * 🔥 Remove now useless devenv files by Romain Deville ([`040a5ab`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/040a5abd1a3f0f81fa57dff15a890e0945ceed34)) 🔏
  * 🔨(devbox): Update devbox scripts and config from DGS templates by Romain Deville ([`57b4e57`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/57b4e57218db634f6b8b2a2987da527a41c2cc3e)) 🔏

## v0.37.0 (2025-03-23)

### ✨ Minor

  * ✨ Improve k3s flavors to support multi-node, update README (!104) by Romain Deville ([`16ec9ac`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/16ec9ac479a0ff6e013149e7f8c164367730cb15))
  * ✨(os/k3s): Improve k3s to be multi-nodes by Romain Deville ([`1e8cdd1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1e8cdd1802cb2b819cafbcd4f4a0d66dc2228c96)) 🔏

### 🩹 Patch

  * ⚡️(os/docker): Update way settings are handled by Romain Deville ([`ba00efb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ba00efb3f0416b0aba5dcf45b0b006df9061fd92)) 🔏
  * ⚡️(lib): Add mkDebug and mkWarn method to my lib by Romain Deville ([`82b3b64`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/82b3b64800fafe4f66230eb76a5bdd1130bdac78)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`0755bf4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0755bf4c3902f9e459b38753d44133597b8b1969)) 🔏
  * 👽️(hm/_gui/firefox): Update config due to HM changes by Romain Deville ([`6bc98c2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6bc98c2779c21568803f85cdff95e02d66008eee)) 🔏
  * 👽️(hm/vscode): Update flavors due to nixpkgs update in configuration by Romain Deville ([`9aaec2b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9aaec2ba8380f2cad770fff0c2b0ebbfb959294a)) 🔏

### 🔊 Others

  * 🎨(hm/k8s-client): Format flavor files by Romain Deville ([`c6dee21`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c6dee21f117c665c65c04269ff003f4a46da26c4)) 🔏
  * 📝 Update README with basic documentation by Romain Deville ([`204e6ce`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/204e6ce88221f20b1acb40e9397ebdcfc0422456)) 🔏

## v0.36.0 (2025-03-17)

### ✨ Minor

  * ✨(os/_core): Set DNS server to FDN by Romain Deville ([`9d90fb7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9d90fb70452e7ad789a80bedf99f110623b5a0ab)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`46d4391`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/46d43915f06aec7ff4c67e5acfc39d2595e9777c)) 🔏
  * 🐛(hm/bluetooth): Fix bug in flavors by Romain Deville ([`f23006e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f23006e57bb98a283f59a28aeeba70253292fb29)) 🔏
  * 🔧 Fix OIS bluetooth bugs, improve HM flavors (!103) by Romain Deville ([`c821a62`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c821a6280c42062bf8a109138cb928462c3e569a))
  * 🔧(hm/k8s-client): Update aliases and abbreviations, add k8s-explore pkgs by Romain Deville ([`3ce9330`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3ce9330335ca6c2d0bc1d055cbc5ad59a45694db)) 🔏
  * 🔧(hm/_gui/firefox): Harden Firefox VR access by Romain Deville ([`5f44278`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5f4427801456ec9e344ea4c214868f17d8e49917)) 🔏

## v0.35.3 (2025-03-03)

### 🩹 Patch

  * ⚡️(hm/bluetooth): Add darwin support correctly to flavors by Romain Deville ([`e2d7a8c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e2d7a8ce93f06866ce9c96986f33017c1d0412a2)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`8f15804`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8f158044f7d64b6e1ec960e0d07b8f3155f3b5ee)) 🔏
  * 🐛(hm): Fix minor bug for flavors _core and improve darwin support (!102) by Romain Deville ([`924b7d7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/924b7d7f42b601363047c3ff64dc221026dd2bed))
  * 🐛(hm/_core): Fix wrong boolean activation for viddy.toml by Romain Deville ([`944397a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/944397a4ef52075142d05b64192b322ba78dfef3)) 🔏

## v0.35.2 (2025-02-26)

### 🩹 Patch

  * ⬆️ Upgrade devbox.lock by Romain Deville ([`77cb2c3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/77cb2c386698c5643e11921f13d01850c7df0810)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`0bdbfce`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0bdbfce486103f964e9187bd8031849823e1b0de)) 🔏
  * 👽️(hm/_gui): Update ref to pkgs kolourpaintk (!101) by Romain Deville ([`2227808`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/22278086da91d61cc158dfd7bea9b6a44cad1dd6))
  * 👽️(hm/_gui): Update kolourpaint pkgs ref by Romain Deville ([`7c62905`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7c6290518993b1b463cba38d7c1833ea2f57cfd1)) 🔏

## v0.35.1 (2025-02-23)

### 🩹 Patch

  * ⚡️ Improve zsh aliases/abbr and improve docker rooless config (!100) by Romain Deville ([`ccfa39b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ccfa39b38d1152d1c1553d57b7bac083d373170f))
  * ⚡️(hm/terragrunt): Improve zsh aliases and abbr by Romain Deville ([`74a269b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/74a269bce20ed827c7b05a63660375cc7ba873f7)) 🔏
  * ⚡️(hm/spotify-player): Add zsh aliases and abbr by Romain Deville ([`ead8a17`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ead8a177a68a52d1ea8cc63627146f2027d9b2f5)) 🔏
  * ⚡️(hm/k8s-client): Improve zsh aliases and abbr by Romain Deville ([`9d9a445`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9d9a445eb3b6feae61f3afb2208d910405376017)) 🔏
  * ⚡️(hm/docker): Set variable to use rootless docker by Romain Deville ([`0378b0f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0378b0f3a82d022acfe77f041dfab5e17eb8a16a)) 🔏
  * ⚡️(hm/audio): Improve zsh aliases and abbr by Romain Deville ([`a5cff1a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a5cff1a4f0555f9f33b52330e34943df0ae15caf)) 🔏
  * ⚡️(hm/_core): Improve zsh alias and abbr management by Romain Deville ([`2de0e52`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2de0e522bbcc0891e21c335552e96d357633eab1)) 🔏
  * ⚡️(os/docker): Improve docker rootless configuration by Romain Deville ([`54314f0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/54314f00d3b54e171e0ca2d59969ef9e4483f0d0)) 🔏
  * ✏️(hm/opentofu): Fix minor typos by Romain Deville ([`381ebcb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/381ebcb63b024776c33da58c5397dc833c0256d6)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`cced893`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cced893bbcbe27b63275888585058ec72bf91057)) 🔏
  * 🔧(flake): Unset HM useGlobalPkgs to allow set nixpkgs config by HM user by Romain Deville ([`b121c53`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b121c537a7b3f1a699945195001274a637aafdd2)) 🔏

### 🔊 Others

  * 🔥(os/_core): Remove viddy from OS pkgs by Romain Deville ([`084a263`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/084a2633cc2e67e032956a1877ce85f1ce02baad)) 🔏

## v0.35.0 (2025-02-22)

### ✨ Minor

  * ✨ Mainly add my zsh config in HM and add OS audio flavor (!99) by Romain Deville ([`130cc61`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/130cc612c437b8eb96f722b3954cfb9268c6f959))
  * ✨(os/audio): Add new audio flavors with pipewire service by Romain Deville ([`825b511`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/825b511a19dd8e000ad886c3c9edce9ecf62e20f)) 🔏
  * ✨(hm/terragrunt): Update pkgs and add zsh config by Romain Deville ([`3917520`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/39175206d9cc1621c21fed203bbef9a24159e621)) 🔏
  * ✨(hm/terraform): Update pkgs and add zsh config by Romain Deville ([`8054ae4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8054ae4878305a7d52fe0337a505347584ddc939)) 🔏
  * ✨(hm/opentofu): Update pkgs and add zsh config by Romain Deville ([`92bdefd`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/92bdefd6d7194736d857adbff22050c69c294c40)) 🔏
  * ✨(hm/latex): Add flavor with pkg and zsh config by Romain Deville ([`cef3050`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cef3050282348c6ee58ced0545b082ec968e4891)) 🔏
  * ✨(hm/k8s-client): Update flavors with zsh config (alias and abbr) by Romain Deville ([`2a37c9a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2a37c9afd6b03ece3256dffd2c99a0f6ca056659)) 🔏
  * ✨(hm/docker): Add flavors with zsh config (alias and abbr) by Romain Deville ([`b4e3721`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b4e37215bbf5ef1324663819d41f2def3895d957)) 🔏
  * ✨(hm/_core): Add zsh config in flavors (and subflavors) by Romain Deville ([`b995dd6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b995dd68038d14d89bce4939d42726e59123ec74)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`21f7c3b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/21f7c3b815bf736915f348194389a617faa81a3c)) 🔏
  * 🔧(hm/audio): Update package installed in flavors by Romain Deville ([`6b63892`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6b638923c599c41e4964cb601b9021dbea26e102)) 🔏

## v0.34.2 (2025-02-15)

### 🩹 Patch

  * 👽️(_core/git): Update git config after HM update (!98) by Romain Deville ([`8cf9d2a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8cf9d2a5664cedbb6cb85e5e3966ec130f6ecb7e))
  * 👽️(_core/git): Update git config after HM update by Romain Deville ([`c1ca05e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c1ca05efc93d41bb687d526f9325f31a9e695795)) 🔏

## v0.34.1 (2025-02-11)

### 🩹 Patch

  * 🐛(hm): Fix HM darwin support (!97) by Romain Deville ([`bf6ddd2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bf6ddd270366e59b1d594d5a73a77c83436b427e))
  * 🐛(hm): Fix HM darwin support by Romain Deville ([`9c109d2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9c109d23ddba87eea562bc1454f01258205bd2a6)) 🔏

## v0.34.0 (2025-02-09)

### ✨ Minor

  * ✨(hm): Add HM discord flavor (!96) by Romain Deville ([`b601f30`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b601f309113074dc849d61e5dc8ea5e398533f8e))
  * ✨(hm): Add HM discord flavor by Romain Deville ([`defbaf2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/defbaf2ce38c30b80947cb46a54713cf67040beb)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`f80f9eb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f80f9eb050ecbdf665669eb2bacafc29b31a3727)) 🔏
  * 🔧(machines): Update machines config with new flavor by Romain Deville ([`57d4c49`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/57d4c49eb400d108f1711faae2cf2691f56594a2)) 🔏

## v0.33.0 (2025-02-08)

### ✨ Minor

  * ✨(hm/_core): Add zsh plugin you-should-use (!94) by Romain Deville ([`459e5ff`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/459e5ff9d7f0b31475bee54c51669586ca6c967a))
  * ✨(hm/_core): Add zsh plugin you-should-use by Romain Deville ([`52d5d94`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/52d5d94034ed7a4e59cdddf0d9ca5c79b765e972)) 🔏

## v0.32.0 (2025-02-08)

### ✨ Minor

  * ✨ Update flavors to better handle darwin, minor scripts fixes (!93) by Romain Deville ([`50c9f1d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/50c9f1d39bf7cec9f0810afc1860c67e2deea35e))
  * ✨(os): Add isDarwin boolean for flavors by Romain Deville ([`bd03cb7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bd03cb78d2ddb821797b606119bcfd30bddf7f7b)) 🔏
  * ✨(hm/ollama): Add basic ollama flavors by Romain Deville ([`c3c9c8c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c3c9c8cdb4b01d0bcc7c1b964dc9908225923df8)) 🔏
  * ✨(hm/_gui): Add gammastep as my new &#34;redshift&#34; like with wayland support (!90) by Romain Deville ([`c720c62`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c720c626d09789c903cc5c3aa6131796280645a5))
  * ✨(hm/_gui): Add gammastep as my new &#34;redshift&#34; like with wayland support by Romain Deville ([`08f0d3f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/08f0d3f44ac5c3a9fad310a15b2f4b7df99fd9b6)) 🔏

### 🩹 Patch

  * ⚡️(os/display-manager): Deactivate display manager if OS isDarwin by Romain Deville ([`333f75c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/333f75cfadfbdb91f1d8a7894fd600ca84f3356f)) 🔏
  * ⚡️(os/window-manager): Deactivate flavor if OS isDarwin by Romain Deville ([`b67b70b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b67b70b205801f8f7bb99df8445befdbb4029e16)) 🔏
  * ⚡️(hm): Force hm.homeDirectory value by Romain Deville ([`8a11e9d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8a11e9dd99b7ad66f0237880086a599ec011f9f3)) 🔏
  * ⚡️ Rework most flavors to be full module and refacto scriptsk (!92) by Romain Deville ([`f1e7cce`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f1e7ccedd7637e096bf25d29eb38cb7de75d10b2))
  * ➖ Update flake.nix by Romain Deville ([`0f4f029`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0f4f0293a9f2da8b95d323b96bca6ab885605f28)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`951d8da`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/951d8dadf61a4c8b1cfb564183fd4c0e065239ee)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`de050be`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/de050be69aeb4a672e836b665392c63d9e8df62e)) 🔏
  * 🐛(os/printing): Fix users usage to update userGroup by Romain Deville ([`07c5bee`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/07c5bee8c999fbe073b440b245a96c4cc1d0f147)) 🔏
  * 🐛(hm/_gui): Deactivate wayland if OS isDarwin by Romain Deville ([`4afd3fb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4afd3fb36d7ed4058adf69980f9b3281402d3f83)) 🔏
  * 🐛(hm/_gui): Fix minor issues for rofi and vlc pkgs set to linux only (!91) by Romain Deville ([`f7bb15d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f7bb15d70fff69b83af8496b5f8a2b6ed3152fd4))
  * 🐛(hm/_gui/wayland): Fix rofi submodule options name based on path by Romain Deville ([`7bd834d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7bd834d0180f4e6d0d91299d72cfd32148d31348)) 🔏
  * 🐛(hm/_gui): Move vlc pkgs to linux dedicated pkgs by Romain Deville ([`e041235`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e0412359a3d6b6ede6bc63c150c9d2bafc7942c0)) 🔏
  * 👽️(hm/_gui): Deactivate gtk iconTheme Qogir-manjaro as build fail by Romain Deville ([`7980844`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/798084480888fca3ce72706e54b41c9faa54af6e)) 🔏
  * 📦️(hm/_core): Add viddy to core pkgs by Romain Deville ([`ba63a86`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ba63a86feb0f76d23bb700fa09f9e4cb07ac97ad)) 🔏
  * 🔧(flake.nix): Update flake.nix to support new dev-min and dev-max machines by Romain Deville ([`a166699`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a1666994f4cdcb5912ed65f8ee16492933f014ca)) 🔏
  * 🔧(machines): Move machine dev to dev-min and dev-max by Romain Deville ([`130bebf`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/130bebf138f58d74ac3900b63422dead64bd1465)) 🔏
  * 🔧(hm/_gui): Change redshift to activable module (disabled by default) by Romain Deville ([`221cea1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/221cea16374dc269031dff1ee166ccb0f25182e5)) 🔏

### 🔊 Others

  * 🎨(os): Update flavors description and remove useless options by Romain Deville ([`1c45cfa`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1c45cfab50fdfca4527d6492076485dadeb0cd14)) 🔏
  * 🎨(hm): Update HM flavors option description by Romain Deville ([`edd1fc0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/edd1fc09dd477e17d1c6b5ae5abe0ea6b82bba96)) 🔏
  * 🎨(hm/_gui): Upgrade flavors such that everything is activable module by Romain Deville ([`8303207`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/830320752730a889370fa5fbb85c1280b57b8145)) 🔏
  * 🎨(hm/_core): Upgrade flavors such that everything is activable module by Romain Deville ([`5844f09`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5844f09e41cb4fdc7abb1c8ccab3fbd2b987075b)) 🔏
  * 🎨(hm/_accounts): Upgrade flavors such that everything is activable module by Romain Deville ([`f05ac37`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f05ac3751cfb8c3295626c7e22b4b82b332baa84)) 🔏
  * 🔥 Remove useless code and useless flakes inputs by Romain Deville ([`03ca665`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/03ca66501e24d5a8caaecfd59af14ae933c58c8c)) 🔏
  * 🔥(os/users): Remove useless options by Romain Deville ([`0e8fa2d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0e8fa2d1f251d79da6bab5b5b0ff43b9a5bc6da6)) 🔏
  * 🔨(scripts): Fix minor bugs and typos on scripts by Romain Deville ([`856c388`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/856c38807cb60155e27dd016abb416939d6cb4da)) 🔏
  * 🔨(devbox): Drop devenv to only use devbox by Romain Deville ([`21e055f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/21e055f954b4877e73674117d0f1c6a03aa12b42)) 🔏
  * 🔨(scripts): Update scripts with new CLI framework and within a nix pkgs by Romain Deville ([`fd979d4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fd979d4681e7f208d357b93e2f3d32f555e9124a)) 🔏
  * 🔨(machines): Update config for dev machine by Romain Deville ([`eb5f9ff`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/eb5f9ff226230d6ac2486529806af89948e4e27e)) 🔏

## v0.31.0 (2025-01-22)

### ✨ Minor

  * ✨(flake): Update flake.nix with dev vm as example (!89) by Romain Deville ([`8b91279`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8b91279a1b4cd9afe355cf6e17821e154977d905))

### 🩹 Patch

  * ✏️(hm/_gui/wayland): Fix font family name in wayland.hyprlock by Romain Deville ([`4d219a6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4d219a60c3c6c066d6344b583fb707a199ba9011)) 🔏
  * ➖(flake): Remove inputs not used anymore by Romain Deville ([`4ab9097`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4ab90979bc84d07bda73694ac7c420c76a563bf1)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`f79e042`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f79e04267739cf175f446af2170e2f1c5974be95)) 🔏
  * 🏷️(os/users): Add extraGroups options to os.users.users.&lt;name&gt; by Romain Deville ([`bfea4ad`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bfea4add007e174af486f87b2d9b65c2711de2a0)) 🔏
  * 🐛(hm/_gui): Fix qogir theme with manjaro dark varians by Romain Deville ([`d607f05`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d607f058d23e52c60b34ac3c88850971872f8313)) 🔏
  * 🔧(machines): Add dev machine example to use as dev VM by Romain Deville ([`6993296`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6993296a788097150b1f18d9d4eeedc726f27718)) 🔏

### 🔊 Others

  * 🔨(flake): Update flake.nix with nixos and hm configuration example by Romain Deville ([`6fa7ff2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6fa7ff2da3749d1e11f16ea01d767367b8e700aa)) 🔏

## v0.30.0 (2025-01-20)

### ✨ Minor

  * ✨(hm/_gui/wayland): Add wayland.hyprspace and fix screen sharing (!88) by Romain Deville ([`efcb081`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/efcb081feec6b36b889ae1af0f1467292cd1dd5f))
  * ✨(hm/_gui/wayland): Add wayland.hyprspace config by Romain Deville ([`f401840`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f401840e8f33f5f17694804074936297a7cb0a7e)) 🔏

### 🩹 Patch

  * ➕ Update flake.nix by Romain Deville ([`94bbf9a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/94bbf9a4d25fcb9ef23a67f01368bf8000886b73)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`b2d87fc`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b2d87fc38eb41685489b4f16bc135268ccf78982)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`85e404e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/85e404e0b938dcf7591c85e038b92a0de54d2f79)) 🔏
  * 🔧(hm/_gui/wayland): Update wayland config by Romain Deville ([`c3b1bcb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c3b1bcb424ca86ae9dad792e3782a95842629a6a)) 🔏
  * 🔧(hm/_gui/wayland): Update wayland.hyprswitch config by Romain Deville ([`510a988`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/510a988f60bcb6bc4be4dde7084214b39dc63f00)) 🔏
  * 🔧(hm/_gui/wayland): Update wayland.hyprexpo config by Romain Deville ([`c4367bf`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c4367bfeec3d611785f85aaf6a42f291302fa337)) 🔏
  * 🔧(hm/_gui/wayland): Update wayland.hyprland config by Romain Deville ([`70cba21`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/70cba210efd0b2ce3c3da0fe60a45e776a32095d)) 🔏
  * 🔧(hm/_gui/wayland): Update wayland.wl-kbptr config by Romain Deville ([`6ab8d8e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6ab8d8e2047e7d82fc2f26b644bd92582b6e7735)) 🔏
  * 🔧(hm/_core): Update atuin config by Romain Deville ([`2f33730`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2f33730d55cbef408dd84a5b3414739d24cacfba)) 🔏

## v0.29.0 (2025-01-19)

### ✨ Minor

  * ✨ Add Hyprland (and friends) and KDE, minor refacto (!87) by Romain Deville ([`b23eb4b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b23eb4b33cbaae81d62dd0f15dc073359fe9f892))
  * ✨(os/flavors/wm): Add enabled KDE Plasme DE by Romain Deville ([`f7dbc09`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f7dbc09f5f529bc256c8626c2cd636c48e4ec3ad)) 🔏
  * ✨(hm/flavors/_gui/wayland): Add wayland config by Romain Deville ([`956be55`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/956be55b0e876d5f7d8c95934927f637a550a5f6)) 🔏
  * ✨(hm/flavors/_gui/wayland): Add wayland.hyprland config by Romain Deville ([`9cdcf06`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9cdcf06c7478333365879ced9aafcdd921be7ddf)) 🔏
  * ✨(hm/flavors/_gui/wayland): Add wayland.wl-kbptr config by Romain Deville ([`4fde5cd`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4fde5cdc8268e8f9b3371c17fdc145454e753490)) 🔏
  * ✨(hm/flavors/_gui/wayland): Add wayland.waybar config by Romain Deville ([`95bbcf2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/95bbcf2180ffdb25e72a8ed6d8d56d30c42c0dc4)) 🔏
  * ✨(hm/flavors/_gui/wayland): Add wayland.rofi config by Romain Deville ([`9d54325`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9d543258d8811ed8c4ba32431780959497b2ccd2)) 🔏
  * ✨(lib): Add new function to libs by Romain Deville ([`415d8d6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/415d8d6a6a4d7acb6d5f45aca3d4623025d4d922)) 🔏

### 🩹 Patch

  * ⚡️ Update usage of colors according to new module structure by Romain Deville ([`88d7a8c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/88d7a8c68c93cf2c03ba109464053486c1e90a1c)) 🔏
  * ⚡️(colors): Move colors to a module by Romain Deville ([`97cb678`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/97cb678f6bf9b2f79c3dbe47e769a949fe9479ef)) 🔏
  * ➕(flake): Add hyprland (and friends) as inputs by Romain Deville ([`4cdab12`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4cdab12b559e314e522373aa0c60acdebfe652c9)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`9af93ce`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9af93ce691b5a2f1f343b9788506aaa37e746e2b)) 🔏
  * 🏷️(hm/flavors/_gui): Add font options to flavors gui by Romain Deville ([`9fe6ba3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9fe6ba36cd463fe78655b48ebaf60722d894d312)) 🔏
  * 🏷️(clr): Update material-all colors structure by Romain Deville ([`c4eb358`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c4eb358b738379ce463d712441bc6c1b9cdeac71)) 🔏
  * 🐛(hm/flavors/_core): Update core font name by Romain Deville ([`5f5a539`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5f5a5391721fcaf287b5c79127b5f4422a2a8a06)) 🔏
  * 📦️(hm/flavors/_gui): Add kolourpaints pkgs by Romain Deville ([`f7513d1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f7513d15dfc1c75d8c5a19049ebeb56648b01bb0)) 🔏

### 🔊 Others

  * ♻️ Remove usess options and update firefox profile management by Romain Deville ([`e46178b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e46178b6ecd8cac7fffbd60a17dc0426d2fb4916)) 🔏

## v0.28.1 (2025-01-15)

### 🩹 Patch

  * ⬆️ Update config from DGS (!86) by Romain Deville ([`b4d3dd8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b4d3dd85056ebb14f7fc726ce5c164ccdbe5a1f3))
  * 🔧 Add dotgit sync configuration by Romain Deville ([`bbc4a0d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bbc4a0d88fd1e7d927addfe484aea192be8d04a9)) 🔏
  * 🔧(pre-commit): Update pre-commit from DGS by Romain Deville ([`beeb337`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/beeb337ca38039a63a5f3284b80b79e9440e6516)) 🔏

### 🔊 Others

  * 📄 Update licenses from DGS by Romain Deville ([`4fbccc6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4fbccc6920f7720e2858a595fa8b2aabb23a701e)) 🔏
  * 📝 Add CONTRIBUTING.md from DGS by Romain Deville ([`9d827c4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9d827c4fe6267e04c77e032795437da77fea6527)) 🔏
  * 📝 Add CODE_OF_CONDUCT from DGS by Romain Deville ([`7091cf5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7091cf5e8f022a970e5f2a7945eee635916cb393)) 🔏
  * 📝 Update README from DGS by Romain Deville ([`5fbfdb6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5fbfdb61050e52841337534dd2443b2f77e56e0b)) 🔏
  * 🔨 Add .envrc from DGS template by Romain Deville ([`9f0cbf8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9f0cbf8991ea3f351bb4e06da2e7af1e7c0fbded)) 🔏

## v0.28.0 (2025-01-15)

### ✨ Minor

  * ✨ Rework _core flavors, add docker and remove _package (!85) by Romain Deville ([`0562738`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0562738e8cedfe444e92a3ff248a37dc5e06c996))
  * ✨(os/flavors/docker): Add docker OS flavors by Romain Deville ([`570447d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/570447d6e03d7a7968ad98b6e0959a39b115eb4d)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`ecd8db4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ecd8db4969784285b09551a5cdf4e31369da94d2)) 🔏
  * 🔧(os/flavors/_core): Add font and system pkgs by Romain Deville ([`ade15a6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ade15a6740c8e7f1b4b26fe5db91f67d6062548e)) 🔏

### 🔊 Others

  * 🔥(hm/flavors): Remove redundant _package flavors by Romain Deville ([`35a974b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/35a974b0971693edf0e0fbd2d434d414c1ea3392)) 🔏

## v0.27.1 (2025-01-12)

### 🩹 Patch

  * ⚡️ Upgrade `hm` and `os` modules options, remove `hm.flavors.discord` (!84) by Romain Deville ([`af39827`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/af3982719c17ecb0ff9ddd9f9d18bd5b805c2f84))
  * ⚡️(os): Upgrade `os` module options by Romain Deville ([`fd65850`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fd658505b2c2bae074dccc4d882cce87ab49d789)) 🔏
  * ⚡️(hm): Upgrade `hm` modules options𝅍 by Romain Deville ([`e01d7b3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e01d7b3b8acb49ebbcbc06c2c721dce1d7ac2d6d)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2ef4b44`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2ef4b44c579a481191bda51c7a977224836b00d1)) 🔏

### 🔊 Others

  * 🔥(hm/flavors/discord): Remove flavor since drop of allowUnfrePredicate by Romain Deville ([`67d0c3c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/67d0c3ca0d2638734af354e109029aee7d84bff4)) 🔏

## v0.27.0 (2025-01-07)

### ✨ Minor

  * ✨ Rework flavors to manage HM integration into Nixos Configuration (!83) by Romain Deville ([`c362677`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c3626770bed0e976fee82b9085e8e98d96ef4eee))
  * ✨(nixos/users): Add users options to manage HM by Romain Deville ([`9b68187`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9b6818703ee32f2328b13a344e33ea4777abbcbb)) 🔏

### 🩹 Patch

  * ⚡️(hm/flavors/_gui): Rework flavors to use HM in NixosConfigurations by Romain Deville ([`e3e4221`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e3e422106d56c51bd9b39210694d60c2adbc00da)) 🔏
  * ⚡️(hm/flavors/_core): Rework flavors to use HM in NixosConfigurations by Romain Deville ([`f46a098`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f46a09883acb073c025b5d9d120eacdfe33da733)) 🔏
  * ⚡️(hm/flavors/_accounts): Rework flavors to use HM in NixosConfigurations by Romain Deville ([`a50d609`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a50d609af6d4dc3763834b13387448f7409009df)) 🔏
  * ⚡️(hm/flavors/_accounts): Update flavors to use HM in nixosConfigurations by Romain Deville ([`68943b3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/68943b38b578fa56e310c0732023d9d420207ffe)) 🔏
  * 🐛(hm): Fix default options for HM module by Romain Deville ([`ecf2235`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ecf22357aeed107c1267b3679e24c06605bd94ba)) 🔏
  * 🔧(hm/flavors/_pkgs): Enable the flavors by default by Romain Deville ([`9b01cfa`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9b01cfac9cc5575e47e74ca8eaf69c00b73209f8)) 🔏

## v0.26.1 (2025-01-06)

### 🩹 Patch

  * 🐛(nixos/users): Fix mutableUsers config for nixos users (!82) by Romain Deville ([`901f2c9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/901f2c96b7bb7d1386644eb5d6e4d54f15340226))
  * 🐛(nixos/users): Fix mutableUsers config for nixos users by Romain Deville ([`ed1457c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ed1457ceecbdfbe7cc29fb653c6e1966b95faa69)) 🔏

## v0.26.0 (2025-01-05)

### ✨ Minor

  * ✨ Improve some os/hm flavors and fix bug (!81) by Romain Deville ([`9263073`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/92630737b0ad6b2fe1101c7a132a9678ccc2505b))
  * ✨(os/users): Update users new options (authorizedKey,password,mutableUsers) by Romain Deville ([`fd6771b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fd6771bbd688fa050db5072c0ec874de16fb6aa3)) 🔏
  * ✨(os/flavors/_core): Add nix-ld options and rename flavor by Romain Deville ([`eb68e39`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/eb68e3948c6534777e1bf75a0b578a873d0a43bd)) 🔏
  * ✨(hm/flavors): Add _packages flavors to install simple pkgs without config by Romain Deville ([`701a76c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/701a76c145fe43b372f5a042789285b1e928a369)) 🔏
  * ✨(hm/flavors/_core): Add nix-index-database, comma and colmena by Romain Deville ([`2af6d9d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2af6d9d19ffd370a39b6729fda8708424da736d4)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`634a820`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/634a820e7f2e4fd4e879e5c283d871fa01ece1bb)) 🔏
  * 🐛(os/flavors/dm): Update xkb and xserver config when activating dm by Romain Deville ([`ea77f04`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ea77f040cacc1a472c9884b94b982eca036b2633)) 🔏
  * 🔧(flake): Add nix-index-db and colmena to inputs by Romain Deville ([`a2f0321`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a2f0321f75eb918ffc9955711dfd0b34bbd17357)) 🔏
  * 🔧(os/flavors/steam): Update firewall configuration by Romain Deville ([`0723344`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/072334411c8157b190dee0fe62cf55e7ac488da9)) 🔏

### 🔊 Others

  * 🔥(hm/flavors): Remove flavors that only install pkgs by Romain Deville ([`f921464`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f9214640ef19849e129e780f799d1fbe44205e5e)) 🔏

## v0.25.0 (2025-01-05)

### ✨ Minor

  * ✨(hm/flavors): Update _core and latex flavors with new packages (!80) by Romain Deville ([`10547ee`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/10547eee9aee5ce2efddd18df8c31fe95d7322ea))
  * ✨(hm/flavors/_core): Enable nix-ld to use .pre-commit by Romain Deville ([`ffc2f37`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ffc2f37eb5b7149da7fcc56345bf7b02e48be470)) 🔏

### 🩹 Patch

  * ⚡️(hm/flavors/latex): Add ghostcript package installed with flavor by Romain Deville ([`268268f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/268268f975b3e49d466194e50f2b5cdedaa20ee2)) 🔏

## v0.24.0 (2025-01-04)

### ✨ Minor

  * ✨ Add new HM flavors and fix some typos (!79) by Romain Deville ([`2464fdc`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2464fdcf377c3e9454f4c800b0bf4e504ca9fbb6))
  * ✨(hm/flavor): Add inkscape flavor by Romain Deville ([`336cbe4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/336cbe4066431499baa790571fd3189fe867f7e1)) 🔏
  * ✨(hm/flavors): Add gimp flavor by Romain Deville ([`55628c0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/55628c0183096c92e61d88b5810973b36e42dfa9)) 🔏

### 🩹 Patch

  * ✏️(nixos/flavors): Fix nixos options to be more homogenous by Romain Deville ([`49219d0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/49219d063ba0cb0f9461523fa0dfceba0cbb3f03)) 🔏
  * ✏️(hm/flavors): Fix flavors options to be homogeneous by Romain Deville ([`444265e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/444265e0575fa1d20620e65b8ff63257bef11bb5)) 🔏

### 🔊 Others

  * 🔥 Remove now useless setup.sh by Romain Deville ([`9d29959`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9d29959b8ae1074e2945bd1e66ea5bc1d3b6e24e)) 🔏

## v0.23.1 (2025-01-03)

### 🩹 Patch

  * 🔧(hm/flavors): Add hclfmt and tf-docs to tf related flavors (!78) by Romain Deville ([`dd696b7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/dd696b7580d2fba1187c6638397823759f7eae59))
  * 🔧(hm/flavors): Add hclfmt and tf-docs to tf related flavors by Romain Deville ([`2afdcaf`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2afdcaf609f1de13c9816a166930b92ce36c612d)) 🔏

## v0.23.0 (2025-01-02)

### ✨ Minor

  * ✨(hm/flavors): Add gcloud flavors, improve starship in _core (!77) by Romain Deville ([`7cea25e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7cea25e16f2d2c5485f7cc0dae5f8724009c63d2))
  * ✨(hm/flavors): Add gcloud flavors by Romain Deville ([`9e3c126`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9e3c126e7b85a65ec77506eb6e7b82b0d55ff4cc)) 🔏
  * ✨(hm/flavors/_core): Make starship configuration being module by Romain Deville ([`fc87968`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fc87968ff38274f6ea648372187ece6930b136ef)) 🔏

### 🩹 Patch

  * ⚡️(hm/flavors/k8s-client): Add kubecolor pkgs and config by Romain Deville ([`475175c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/475175c3b78b32d3ed4ebab7172a496bbcd485e9)) 🔏
  * ✏️(devenv): Fix devenv.nix typo by Romain Deville ([`1fe1b59`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1fe1b59f201d91d2c4854863acd758558a1869d2)) 🔏

## v0.22.0 (2024-12-28)

### ✨ Minor

  * ✨(hm): Update default HM installation by Romain Deville ([`68a2819`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/68a28192f4bd5df3cbd79fa1c92824a89917dd37)) 🔏
  * ✨(hm/flavors): Add audio flavors by Romain Deville ([`8cccb7d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8cccb7d805b9bfa27990171c74e5c690f4787472)) 🔏
  * ✨(hm/flavors): Move presets into new &#34;meta&#34; flavors𝅍 by Romain Deville ([`24c8c0c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/24c8c0c5faddea715122c1d170ca13274f6c7215)) 🔏
  * ✨(lib): Add mkDefaultEnabledOptions function in lib by Romain Deville ([`5f448f3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5f448f31d0419ca0373668bf965a127defdbf3c5)) 🔏

### 🩹 Patch

  * ⚡️ Remove presets for flavors modules, fix some pkgs config (!76) by Romain Deville ([`9a245a7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9a245a7e6eab869fc7c902c006df1c95bc815446))
  * ⚡️(hm/flavors): Make all flavors more generalized by Romain Deville ([`9293e57`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9293e57bdb0e77926e9d358498610bb6050de83b)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`a3ea896`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a3ea8960f6786340eca6ef3619071d71865c426b)) 🔏
  * ⬆️ Update devenv.lock by Romain Deville ([`fc74764`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fc74764c92fba495ae6c424b48274e26d6d39f5d)) 🔏

### 🔊 Others

  * ♻️(nixos): Generalize flavors and make same more customizable by Romain Deville ([`40fc693`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/40fc6932c74ce3e98eda9d26e3cb67066639dff2)) 🔏
  * 🎨(nixos): Format nixos users module by Romain Deville ([`35f6893`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/35f6893b0f2e3a026f89e6cde3ade34796d07e92)) 🔏
  * 🔨 Update devenv.nix scripts references by Romain Deville ([`481d297`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/481d297375f25922c740c34f98aaff0e8ac91168)) 🔏
  * 🔨(scripts): Update scripts {os,hm,fmt}.sh by Romain Deville ([`11b8e4e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/11b8e4ee077d5e2ad5f18a281350d13ee2735378)) 🔏

## v0.21.0 (2024-12-22)

### ✨ Minor

  * ✨ Upgrade features to be nix modules (!75) by Romain Deville ([`cb70857`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cb70857849bef9710fcdd1d7923ddc97568be6c5))
  * ✨ Update flake.nix by Romain Deville ([`05e0c28`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/05e0c285efa46dcc02893a2aad301d91bdb3bf05)) 🔏
  * ✨(nixos/flavors): Upgrade flavors to be nix modules by Romain Deville ([`d11b2f9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d11b2f9a98ed60e8973e465fc1a4fae3230e5a47)) 🔏
  * ✨(nixos): Upgrade nixos to be a nix module and remove presets by Romain Deville ([`e4855bc`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e4855bcdbc9f3036ff88b98cb6540dacce32a858)) 🔏
  * ✨(hm): Make hm a module for home-manager by Romain Deville ([`e65819e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e65819efd2c1304227e61e74e1aef4e198352e2d)) 🔏
  * ✨(hm/flavors): Upgrade flavors to be nix modules by Romain Deville ([`81f5823`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/81f5823e25aea2c121c3db42d483d873f0fba342)) 🔏
  * ✨(hm/presets): Upgrade presets to be nix module by Romain Deville ([`4417765`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4417765e14e4601ed6f57e56cdf77b41a3b4ceeb)) 🔏
  * ✨(lib): Upgrade libs to work with new modules by Romain Deville ([`482ffe6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/482ffe65033b4460917fd752b75bc59aaf1ae329)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`8917b19`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8917b19aeead627c6b5b6438b651f0bd77ec21a4)) 🔏
  * 🔧(flake): Upgrade flake.nix to new module structure by Romain Deville ([`ed9970d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ed9970dccbb4eed5e7289add9511bcd64eb65dd1)) 🔏

### 🔊 Others

  * 🔥(lib): Remove now useless accounts libs by Romain Deville ([`0378ff1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0378ff158b988f1c07d03053f1840bafa67721ae)) 🔏

## v0.20.0 (2024-12-15)

### ✨ Minor

  * ✨(hm): Update presets and add new flavors (!73) by Romain Deville ([`5363f8d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5363f8d3d3140beb7bf910eccfa4af6a3a0c723d))
  * ✨(hm/flavors): Add terragrunt flavor by Romain Deville ([`c55e95c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c55e95c7b6c80a90691dfaa1c0c6ed334d983590)) 🔏
  * ✨(hm/flavors): Add hm opentofu flavor by Romain Deville ([`b8afa23`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b8afa23a11526fff8fa82b1bc6e3a1e2a7dac0bc)) 🔏
  * ✨(hm/flavors): Add hm whatsapp flavor by Romain Deville ([`6ad860b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6ad860b440c01e0eb095c4ab46d6e05c7296566a)) 🔏
  * ✨(hm/flavors): Add hm k8s-client flavor by Romain Deville ([`1bc138f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1bc138ff1e3767318feb6abfdd1fec0f5f3ce69d)) 🔏
  * ✨(hm/flavors): Add hm discord flavor by Romain Deville ([`245872e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/245872e794e19f4c15112d1211c4dc2ed6ab6481)) 🔏

### 🩹 Patch

  * ⚡️(hm/presets/main): Update pkgs presets by Romain Deville ([`52b87c0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/52b87c0ba6a83be36f2fa71715bd9310d8467d0e)) 🔏

### 🔊 Others

  * 💡(hm/flavors/glab): Remove useless comment by Romain Deville ([`0295dc8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0295dc89eaaafb56e0b9c4ca5db82d93d8a93c0b)) 🔏

## v0.19.1 (2024-12-08)

### 🩹 Patch

  * 🐛(hm/presets/minimal): fix HM auto upgrade service (!72) by Romain Deville ([`8617743`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/861774327dc9951660357bc55c2b0b05b5e3ac8b))
  * 🐛(hm/presets/minimal): fix HM auto upgrade service by Romain Deville ([`20190f5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/20190f55f4d95a9f690f613a5f68de87f8395fb8))

## v0.19.0 (2024-12-04)

### ✨ Minor

  * ✨(os/presets/gui): add ly desktop manager (!71) by Romain Deville ([`eae304d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/eae304d634f77c900960109a87cc7b63bc713776))
  * ✨(os/presets/gui): add ly desktop manager by Romain Deville ([`cddd418`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cddd4182f4a062d55f1734c204c8179b0564802a)) 🔏

## v0.18.0 (2024-12-03)

### ✨ Minor

  * ✨ Add new flavors, upgrade to 24.11 and minor fixes (!70) by Romain Deville ([`ffc1d4b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ffc1d4b0368531d827fb9df1532759e3ccb10357))
  * ✨(os/flavors): Add k3s flavor by Romain Deville ([`41084ad`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/41084ad9a1b817fc49de2a85951431f2fcd06b5f)) 🔏
  * ✨(hm/presets): Update pkgs list for gui and main presets by Romain Deville ([`4c09c50`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4c09c504ee836023f3701a9cda967557d4f9ca36)) 🔏

### 🩹 Patch

  * ✏️(hm/flavors/container): format flavors by Romain Deville ([`9a1ecdf`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9a1ecdfd076a4f26d574dada9dd30b319d6ae373)) 🔏

### 🔊 Others

  * 🚀 Upgrade config release of 24.11 by Romain Deville ([`8fa0738`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8fa07382b14da6c3a91dc9bb0e0923d9037390c5)) 🔏

## v0.17.1 (2024-11-27)

### 🩹 Patch

  * ⚡️(hm/flavors/latex): Update from texliveMedium to texliveFull pkgs (!69) by Romain Deville ([`dca7114`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/dca71143ff05d529f6490040fb3ba8b00bdfa03c))
  * ⚡️(hm/flavors/latex): Update from texliveMedium to texliveFull pkgs by Romain Deville ([`20adec2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/20adec20e8a2756179ae78ccfba8563c5971378a))

## v0.17.0 (2024-11-27)

### ✨ Minor

  * ✨(hm/flavors): Add latex flavors with tehliveMedium pkgs (!68) by Romain Deville ([`3da4edf`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3da4edf4248e3b6c979263d73fe7cff1c0aa9357))
  * ✨(hm/flavors): Add latex flavors with tehliveMedium pkgs by Romain Deville ([`c3b6ea8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c3b6ea8f0201b70e4a931a5aa3146622d040cd98)) 🔏

## v0.16.0 (2024-11-27)

### ✨ Minor

  * ✨(hm/flavors/containers): Add new containers flavors (!67) by Romain Deville ([`4ea6a0c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4ea6a0cf0aa9689edb055dfc265197fc305420a0))
  * ✨(hm/flavors/containers): Add new containers flavors by Romain Deville ([`2e5a253`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2e5a253e12d76c1e10ef3776f9bbc463a1078bf4))
  * ✨(hm/flavors): Add hm nextcloud flavors (!66) by Romain Deville ([`2cdfbcd`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2cdfbcd8a1beab24c5ded3d60f3c57eaa12bf2d0))
  * ✨(hm/flavors): Add hm nextcloud flavors by Romain Deville ([`023cbc7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/023cbc7feb332cdaf5f7fc3c52aa0b77e1b500e3)) 🔏
  * ✨(hm/presets/minimal): Add nh to packages installed by Romain Deville ([`14f193a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/14f193ad3f931fb8b37a57102e837c505e727f1e)) 🔏
  * ✨(hm): Add support for MacOS (darwin) system (!62) by Romain Deville ([`0bb22c1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0bb22c14b47355f01fb182b8e29175770d70694e))
  * ✨(hm/flavors): Add support for MacOS (darwin) system by Romain Deville ([`8ccabe1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8ccabe1b19f73fb06a3dbc3c9ba54705e0aa5a4b))
  * ✨(hm/presets): Add support for MacOS (darwin) system by Romain Deville ([`9fedf77`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9fedf7747d08fb17822c59b8ca2705fe02a096ca))
  * ✨(nixos/presets/minimal): Add home to user config by Romain Deville ([`e25af4b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e25af4b58923a1b17c476b93d983a638f1b220f6)) 🔏
  * ✨ Improve HM and Nixos config user management (!58) by Romain Deville ([`a6763a7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a6763a7fd4e6235a289329e29c80ac99db939b0e))
  * ✨ Upgrade everything since I moved to NixOS (!57) by Romain Deville ([`3599427`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3599427dfcfd8a843fe7886b6c4bfc9777038a17))
  * ✨(hm/flavors): Improve way HM flavors are load dynamically by Romain Deville ([`fc5c1f9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fc5c1f9307fca90af6310f67b13b4a969d20c1b8)) 🔏
  * ✨(hm/presets): Improve presets to work with NixOS by Romain Deville ([`8f228ac`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8f228ac32810993613d8be2f3fe1af5e8ab8e303)) 🔏
  * ✨(nixos/flavors): Add multiple flavors to NixOS by Romain Deville ([`78202e5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/78202e5c6f03314bcc13fc012b5e5f06a0440b6e)) 🔏
  * ✨(nixos/presets): Rework my nixos presets to be working by Romain Deville ([`1c42c3c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1c42c3c1147b569eaa4aee508d464cba5684ada8)) 🔏
  * ✨(nixos/presets): Add generic presets/default.nix by Romain Deville ([`2989629`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2989629ba8bea83ca32677fb1c231fbcc3d88d3f)) 🔏
  * ✨(lib): Add new lib method and upgrade lib to new structure by Romain Deville ([`c5ff290`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c5ff2904178c6008240867b5583f578465c359a6)) 🔏

### 🩹 Patch

  * ⚡️(hm): Add nh to packages and fix nixgl wrapper (!64) by Romain Deville ([`4bcf248`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4bcf248f872ff2827a221ef769e307129b0bef86))
  * ⚡️(nixos/presets/minimal): Update users to manage root user by Romain Deville ([`23cc98e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/23cc98e75b22c3312afc4f0d0de97bf309be1284)) 🔏
  * ✏️(nixos/presets/minimal): Remove unused variable by Romain Deville ([`0281c71`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0281c71c19f6fa6e8b81f4cb6db7ee07f9f8c450)) 🔏
  * ⬆️ Update templated files from dotgit-sync (!65) by Romain Deville ([`eb2ab29`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/eb2ab29394e4ca300c4b9ef962f4d923e2a74264))
  * ⬆️ Update templated files from dotgit-sync by Romain Deville ([`290feae`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/290feae5efd35b33221b7be918405256912dfeac)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`3fa83e9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3fa83e9dab9364c229b09ef90bf0c4c38e290898))
  * ⬆️ Upgrade flake.lock and flake.nix for NixOS by Romain Deville ([`4191fef`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4191fef194c76d203b8a03d392b3e3f28f2aa4d8)) 🔏
  * 🐛(hm/presets/gui): Fix programs kitty nixgl wrapper by Romain Deville ([`067f633`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/067f63392a8969447cd9d10953d3ff4c863b1d9d)) 🔏
  * 🐛(hm/presets): Fix some missing darwin support (!63) by Romain Deville ([`743e84d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/743e84df58bbcaf87e127647e5ac5b01bdfc53e9))
  * 🐛(hm/presets): Fix some missing darwin support by Romain Deville ([`01a2ea2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/01a2ea2b46afcf4f36b60043067d6076190813f1))
  * 🐛(nixos/presets/minimal): Fix root user in NixOS (!60) by Romain Deville ([`a7030bf`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a7030bff56dce7527194876ad41802fa9f0d8572))
  * 🐛(nixos/presets/minimal): Fix root user in NixOS by Romain Deville ([`15fde59`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/15fde5910604d164f7c5be8f1f8217a0d4cbeef1)) 🔏
  * 🐛 Fix NixOS and HM user root management (!59) by Romain Deville ([`92a9bcb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/92a9bcb95ee03e445d5af52468e8907efb98d318))
  * 🐛(hm/presets/minimal): Update home directory configuration by Romain Deville ([`c9c7088`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c9c7088a6f731f03898eb6d79f2748cd28973a74)) 🔏
  * 🐛(hm/presets/main): Make thunderbird profile name based on username by Romain Deville ([`70b6392`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/70b6392384087e50bbc1fbcf30c83d8b3571bf8a)) 🔏
  * 📌 Pin dependencies in flake.lock by Romain Deville ([`59093b9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/59093b93220a96a27a2ca6fe44469dbf330d9e16)) 🔏
  * 🔧(flake): Move nixpkgs to unstable by Romain Deville ([`2d7ab8b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2d7ab8b0cd03fed83a20a77df885a77efc2f350b)) 🔏
  * 🔧(pre-commit): Temporarly deactivate some pre-commit by Romain Deville ([`7723eff`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7723effe02bee8ceb14bf4dd2ab8bb19d9bd3e32)) 🔏

### 🔊 Others

  * ♻️ refacto flavors and presets (!61) by Romain Deville ([`257ef03`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/257ef039f6500c4d3343cd72770fb48ec28f8383))
  * ♻️(nixos/presets): refacto nixos presets by Romain Deville ([`c0aa70a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c0aa70aa2408edbc217af63698be30546d231546)) 🔏
  * ♻️(hm/presets): refacto presets imports by Romain Deville ([`c514124`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c51412419e9c880419622a3a88dda81bf2aa5735)) 🔏
  * ♻️(hm/flavors): Refacto import flavors by Romain Deville ([`2fbd538`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2fbd538c07e7e7f68535d4e6451b449fdf978949)) 🔏
  * 🎨 Run alejandra formatter by Romain Deville ([`7aa3c32`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7aa3c326133ce4444cbaa6d3871f3bdb16e2492a))
  * 🏗️(lib): Move nixGLWrap functions from lib/hm to lib/default by Romain Deville ([`b882afe`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b882afedd1a94e392ca046052147c01aac0158a1)) 🔏
  * 🔥(hm): Remove now useless default for HM by Romain Deville ([`59c6582`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/59c6582f1c7fc30b9e3a7d21807f68b28ae02559)) 🔏
  * 🔥(nixos/hosts): Remove test hosts configuration by Romain Deville ([`ced044c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ced044c54587204c428c359be06ab50b27d7e2f6)) 🔏
  * 🔥(nixos/vms): Remove VMs configuration by Romain Deville ([`9ab5f7e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9ab5f7e2bfcda7001fb139fca9256df8bd83fd73)) 🔏
  * 🔥 Remove now useless modules folder by Romain Deville ([`83e940b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/83e940b967b02bdafacbe40facbfc30807c3509d)) 🔏
  * 🔥(configs): Remove useless configs by Romain Deville ([`660d556`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/660d556c9bd0052348c7a07d9e5509ad7eed1897)) 🔏
  * 🔥(hm/presets/gui): Remove kitty hosts config (!56) by Romain Deville ([`272b866`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/272b86649ea30030b4855b26331f8d1077136e6f))
  * 🔥(hm/presets/gui): Remove kitty hosts config by Romain Deville ([`0c0f2d0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0c0f2d0865e659713e8f41dd721f86d69d0688a2)) 🔏
  * 🚚(hm/presets): Move thunderbird from main to gui presets by Romain Deville ([`5ec89af`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5ec89af7828e21a9acbd27361983e33266db9cfb)) 🔏

## v0.15.8 (2024-10-07)

### 🩹 Patch

  * 🔧(hm/presets/gui): Update kitty shortcut to avoid tmux conflict (!55) by Romain Deville ([`3b23c45`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3b23c45e90c52133161385de05349d279e6d574a))
  * 🔧(hm/presets/gui): Update kitty shortcut to avoid tmux conflict by Romain Deville ([`17fdc6d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/17fdc6dbc3349c2f4ac7002f520b8328c0f0f5d9)) 🔏

### 🔊 Others

  * 🔇(lib/accounts): Remove useless trace (!54) by Romain Deville ([`b0cf135`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b0cf135c31555a20cc7f9055588f802524212e84))
  * 🔇(lib/accounts): Remove useless trace by Romain Deville ([`2462554`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2462554c2c4acffc7e93c6bbb01b20ea4ae8fd0e)) 🔏

## v0.15.7 (2024-10-06)

### 🩹 Patch

  * ⚡️ Accounts related improvements (lib, presets) (!53) by Romain Deville ([`d1dad22`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d1dad22775998f96e0e88ba37d1b41eb9787060a))
  * ⚡️(lib/accounts): Improve libs to chose what to enable by Romain Deville ([`3666df8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3666df84add383c821baa39b35dc2c32be24852d)) 🔏
  * 🐛(hm/presets/main): Fix vdirsyncer to consider calendar and contact by Romain Deville ([`fef5575`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fef55751d6e718510c02ed0e1c03018df2c96867)) 🔏

## v0.15.6 (2024-10-06)

### 🩹 Patch

  * ⚡️(hm/flavors/spotify): Fix typos and add client_id_command option (!52) by Romain Deville ([`e131a95`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e131a95040e3bbc1cb9b3ebd4f683b5c89f345f6))
  * ⚡️(hm/flavors/spotify): Fix typos and add client_id_command option by Romain Deville ([`d4b53a0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d4b53a0a56df01108ec46f8c3f70ac64a9d119e7)) 🔏

## v0.15.5 (2024-10-06)

### 🩹 Patch

  * ⚡️(hm): Improve sops usage to be more generic (!51) by Romain Deville ([`590143c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/590143c72f66f56a0e70fce1580a80fc18daa77b))
  * ⚡️(hm): Make userCfg sops usage more generic by Romain Deville ([`b56b2d2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b56b2d279dcfe067cfbfd23b34f0d65efd5bc372)) 🔏

### 🔊 Others

  * 🔥(hm/presets/main): Remove sops usage in vdirsyncer by Romain Deville ([`f171238`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f171238d55bcd08e564bdd2c0e64279159a9d762)) 🔏

## v0.15.4 (2024-09-28)

### 🩹 Patch

  * 🐛(hm/presets/common): Fix mr log wrong redirection (!50) by Romain Deville ([`e7da10e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e7da10ee5be9d2a95ec66c194e0e0c69e0ce6426))
  * 🐛(hm/presets/common): Fix mr log wrong redirection by Romain Deville ([`c78b3c8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c78b3c885956365e447502bef479ab9061a117f7)) 🔏

## v0.15.3 (2024-09-28)

### 🩹 Patch

  * 🔧(hm): Improve flavors and update common preset (!49) by Romain Deville ([`65b6094`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/65b609493cfc81c7de30ea95dd745ed246cf7b9b))
  * 🔧(hm/presets/common): Add diffutils and colordiff packages by Romain Deville ([`0e11459`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0e11459a4787c340338fba559e0eb09612c18a19)) 🔏
  * 🔧(hm/flavors): Improve all flavors with default enabled false by Romain Deville ([`d891707`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d8917076fc7fc45cc6e0cd6fce4ac4a169208036)) 🔏

## v0.15.2 (2024-09-14)

### 🩹 Patch

  * 🐛(hm/presets/minimal): Fix HM upgrade script service and add notif (!48) by Romain Deville ([`2b3959c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2b3959cae30233139d4ef41dc1ef473c094f72a1))
  * 🐛(hm/presets/minimal): Fix HM upgrade script service and add notif by Romain Deville ([`34938da`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/34938dade61e66013778927f4d8b00893ad7692b)) 🔏

## v0.15.1 (2024-09-09)

### 🩹 Patch

  * 🐛(hm/flavors): Fix terraform settings (!47) by Romain Deville ([`7f667df`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7f667dfdd2aed7c89b0d830c09dc25d031f5bab8))
  * 🐛(hm/flavors): Fix terraform settings by Romain Deville ([`1e14228`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1e14228b7e31e4a36e272271e24caa489138b9c1)) 🔏

## v0.15.0 (2024-09-09)

### ✨ Minor

  * ✨ HM add flavor terraform (!46) by Romain Deville ([`ff41a7e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ff41a7e5ccdd5775c93754d4c0071124d91708c3))
  * ✨(hm/flavors): Add terraform flavors by Romain Deville ([`9868739`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9868739bfc813ce2a4071f5d6f1a83b00c536066)) 🔏

### 🔊 Others

  * 🔥(hm/presets/main): Remove XDG terraformrc by Romain Deville ([`c4aa7a1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c4aa7a14f254fdc694495a7fc3805f64a9ba5ca2)) 🔏

## v0.14.3 (2024-09-08)

### 🩹 Patch

  * ⬆️ Update flake.lock (!45) by Romain Deville ([`cc5748d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cc5748d5bdc681601d43179069eddeb00fa55cdf))
  * ⬆️ Update flake.lock by Romain Deville ([`8e5bde7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8e5bde72bf467a7e9d5003140cb89a204360f972)) 🔏

## v0.14.2 (2024-09-08)

### 🩹 Patch

  * 🐛(hm/prestets/common): Fix mrconfig file (!44) by Romain Deville ([`7f1d0b7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7f1d0b71b97ca928cb179ea73f9e3f9aa832003c))
  * 🐛(hm/prestets/common): Fix mrconfig file by Romain Deville ([`7248c87`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7248c87203e964fb71754e596ea8c493865ec2cc)) 🔏

## v0.14.1 (2024-09-07)

### 🩹 Patch

  * 🔧(hm/presets/common): Update mrconfig (!43) by Romain Deville ([`25dada6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/25dada6f8b0da57f06674a740245092889f94168))
  * 🔧(hm/presets/common): Update mrconfig by Romain Deville ([`9039b19`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9039b19019086983f099f3a74fb5ee44584265ed)) 🔏

## v0.14.0 (2024-09-07)

### ✨ Minor

  * ✨ Update packages list installed (!42) by Romain Deville ([`f9f6466`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f9f646690f218d5aa0b1414aa14bf909d4a20604))
  * ✨(hm/presets/gui): Add arandr to pkgs by Romain Deville ([`65224d3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/65224d3c2bbb0eb81076880bcc996eb24eb783a6)) 🔏
  * ✨(hm/presets/main): Add alejandra to pkgs by Romain Deville ([`b7326f0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b7326f0a734a4694e4f871858ca1bba73dc89b9c)) 🔏

### 🩹 Patch

  * 🔧(hm/presets/common): Update mrconfig by Romain Deville ([`f336346`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f3363460c15d0465219e55717f7c0788f44605d6)) 🔏
  * 🚩(hm/presets/minimal): Enable delta as git diff pager by Romain Deville ([`5594c11`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5594c115de3e090485196bfa494b74202db82139)) 🔏

### 🔊 Others

  * 🔥(hm/presets/common): Remove zsh from package list by Romain Deville ([`c533dab`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c533dab394ea9eb411453a337b8d8e0ead66df5a)) 🔏

## v0.13.5 (2024-08-27)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!41) by Romain Deville ([`b10bbce`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b10bbce299984874d56ae5d7c4e94fa0484cc7f4))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`a4b5300`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a4b5300575ac1db427dbb071600e3598ee85a73a))

### 🔊 Others

  * 👷 Update Gitlab CI from DGS template by Romain Deville ([`876cfa0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/876cfa03b003bd439045da182ffb2eb96db57112)) 🔏
  * 💚 Fix CI from DGS Template (!40) by Romain Deville ([`0110fd3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0110fd3aa12b5b8f487af1efa42c8106867e3f7c))
  * 💚 Fix CI from DGS Template by Romain Deville ([`448ff04`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/448ff0435100fbb1e144dddf80d97129a2cc1580)) 🔏

## v0.13.4 (2024-08-24)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!39) by Romain Deville ([`67717da`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/67717da99cd4d073233b0334a656fd6c748a2b33))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`5337b00`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5337b005fabecb5f0ede9d368df5fa683f398145))

## v0.13.3 (2024-08-19)

### 🩹 Patch

  * 📌(hm/presets/common): Bump SHA256 for file LS_COLORS (!38) by Romain Deville ([`278827f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/278827facd51001708e73379675f6e30cfe563ce))
  * 📌(hm/presets/common): Bump SHA256 for file LS_COLORS by Romain Deville ([`17c9092`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/17c9092d9a40bf3fcde8190036e421fea47cb8b1)) 🔏

### 🔊 Others

  * 💚 Fix CI from DGS (!37) by Romain Deville ([`d76f175`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d76f1753e0cda785485d941677dd946721ad5364))
  * 💚 Fix CI from DGS by Romain Deville ([`72bed7d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/72bed7dbd9437ffbdf2ef0da9e481ffa7e09fc9a)) 🔏

## v0.13.2 (2024-08-18)

### 🩹 Patch

  * 🐛(hm/flavors/glab): Update config to set chmod 0600 (!36) by Romain Deville ([`40a8519`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/40a851997ae583192a9988459c564d0ca96c882a))
  * 🐛(hm/flavors/glab): Update config to set chmod 0600 by Romain Deville ([`b7b5099`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b7b5099f7d87c8f43e72680558a25fedf3aaeb75)) 🔏

## v0.13.1 (2024-08-18)

### 🩹 Patch

  * 🐛(hm/flavors/glab): Update xdgConfig folder path (!35) by Romain Deville ([`6887b8b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6887b8bcaeaabbe364da117a4db18da181ba9bd2))
  * 🐛(hm/flavors/glab): Update xdgConfig folder path by Romain Deville ([`a52b3ad`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a52b3ad53c8d83dc4ad63768cf66778926ec8d9f)) 🔏

## v0.13.0 (2024-08-17)

### ✨ Minor

  * ✨(hm/flavors): Add gh and glab CLI flavors (!34) by Romain Deville ([`ec0b561`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ec0b5612ef2ffbd0a4f660c93f13653fe43534ee))
  * ✨(hm/flavors/glab): Add glab flavors by Romain Deville ([`8b0259f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8b0259f42fcc89ebde3a9c7faa7eccce027e65f3)) 🔏
  * ✨(hm/flavors/gh): Add gh flavors by Romain Deville ([`f934bc9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f934bc926ff22b438b82e35515ce7b47456a5b84)) 🔏

### 🔊 Others

  * 🎨(hm/presets): Run nix fmt by Romain Deville ([`e16479c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e16479cc1efa64ff64f912a179dfcb209feea477)) 🔏

## v0.12.1 (2024-08-17)

### 🩹 Patch

  * 🐛(hm/presets/minimal): Fix tmuxp config (!33) by Romain Deville ([`b3c0873`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b3c08730c604ce394ca2ff75b5a88f8860bf3b2e))
  * 🐛(hm/presets/minimal): Fix tmuxp config by Romain Deville ([`4152a2d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4152a2dab4dd99696eb9558b8ba7f7e8b027714c)) 🔏

## v0.12.0 (2024-08-17)

### ✨ Minor

  * ✨(hm/presets/minimal): Add tmux pkgs and tmuxp with config (!32) by Romain Deville ([`9aec0a2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9aec0a20d9891b1dd777602d04aca78130ff1d8d))
  * ✨(hm/presets/minimal): Add tmux pkgs and tmuxp with config by Romain Deville ([`a8ed045`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a8ed045fc8ffebb3d0de5114a26b55cc49bb47d7)) 🔏

## v0.11.0 (2024-08-17)

### ✨ Minor

  * ✨(hm/presets/minimal): Add difftastic/delta switch &#39;cos delta build broken (!31) by Romain Deville ([`85a48d2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/85a48d2879bc2dd0ad7b0638532b1d5b1a64b11a))
  * ✨(hm/presets/minimal): Add difftastic/delta switch &#39;cos delta build broken by Romain Deville ([`2a7f226`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2a7f2260817fc3dae1957ab5e08c4d76a0301b97)) 🔏

## v0.10.0 (2024-08-15)

### ✨ Minor

  * ✨ Reactivate redshift, upgrade khard config, clean and format (!30) by Romain Deville ([`31e690b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/31e690bd57250f0ed26859ee012193ca8b1e0567))
  * ✨(hm/presets/gui): Reactivate redshift by Romain Deville ([`41d68e7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/41d68e7e825eac790a9e204324cdeb6c095fe28f)) 🔏

### 🩹 Patch

  * 👽️(hm/presets/main): Update khard to use defaultCollection by Romain Deville ([`5866c7b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5866c7b1ca954f51730b8c55ef6049025e5ecd94)) 🔏

### 🔊 Others

  * 🎨 Run nix fmt on repos by Romain Deville ([`c9fb6d5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c9fb6d5d5f1461ffdd8feb397e055a84a5be521b)) 🔏
  * 🎨(lib/accounts): Remove useless codes by Romain Deville ([`ee67927`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ee67927682a2dfba0fc7e76d33900309ba4c821a)) 🔏
  * 🔥(hm/preset/main): Remove SSH hosts config by Romain Deville ([`bc1934b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bc1934b7ba054d90419960dba17247d53f9a4c7b)) 🔏

## v0.9.1 (2024-08-12)

### 🩹 Patch

  * ⬆️(hm/presets/common): Update SHA for LS_COLORS repos (!29) by Romain Deville ([`a318d5a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a318d5a13ec9c48b5d124703b824b03011668b56))
  * ⬆️(hm/presets/common): Update SHA for LS_COLORS repos by Romain Deville ([`653489c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/653489cb786e1e48a2f932079a79d4927d96e87c)) 🔏

## v0.9.0 (2024-08-05)

### ✨ Minor

  * ✨(hm/flavors): Add vscode flavors (!28) by Romain Deville ([`36d0d62`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/36d0d62a2b8b94c501f68048b1ded1cc54c6141d))
  * ✨(hm/flavors): Add vscode flavors by Romain Deville ([`a7f7d55`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a7f7d55a644eef1eb0e03d416350289db15cd765)) 🔏

## v0.8.5 (2024-07-27)

### 🩹 Patch

  * 🐛(hm/preset/common): Fix breaking change in fastfetch (!27) by Romain Deville ([`9485471`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9485471de084d0b4252054451c323e34003d3423))
  * 🐛(hm/preset/common): Fix breaking change in fastfetch by Romain Deville ([`8aa43b3`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8aa43b3323dd4b8a19477383ee1a328762967ede)) 🔏

## v0.8.4 (2024-07-25)

### 🩹 Patch

  * 🔧(hm/preset/gui): Update redshift config (!26) by Romain Deville ([`16489d4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/16489d40de8f3107998ceb1a3e2d7bc9d66948ce))
  * 🔧(hm/preset/gui): Update redshift config by Romain Deville ([`03251a6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/03251a65b4e1b54ac755f714db9e5255ad27e95c)) 🔏

## v0.8.3 (2024-07-23)

### 🩹 Patch

  * 🔧(preset/commont): Restore battery with only 25% threshold (!25) by Romain Deville ([`90ac412`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/90ac41240511aeecc6dba27556f9c07e8145cfe0))
  * 🔧(preset/commont): Restore battery with only 25% threshold by Romain Deville ([`394418d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/394418d9182cc6602c273027580a8c99fd73eef4)) 🔏

## v0.8.2 (2024-07-22)

### 🩹 Patch

  * 🐛 Fix HM zsh module to load my custom zshrc in the right order (!24) by Romain Deville ([`6a89483`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/6a89483af21f16274569fc474c9b497b56b2bada))
  * 🐛(presets/common): Fix zsh loading order to load my custom zshrc by Romain Deville ([`b73df15`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b73df15749e770117d284cbd21c08bc750fa161d)) 🔏
  * 🔧(preset/common): Remove weather from fastfetch by Romain Deville ([`eab940e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/eab940ebad56a9a67c834bcf447c8968053b9ead)) 🔏

### 🔊 Others

  * 🔥 Remove uselesss code by Romain Deville ([`0914b24`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0914b247e1824e12dee008ffa418802270251ba9)) 🔏

## v0.8.1 (2024-07-21)

### 🩹 Patch

  * 🔧(preset/minimal): Activate autocd for zsh (!23) by Romain Deville ([`f0c2634`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f0c2634019e568bcc3df4b6f3d10030110283564))
  * 🔧(preset/minimal): Activate autocd for zsh by Romain Deville ([`be05d95`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/be05d95a0d90048235675057465077dac6d34cc8)) 🔏

## v0.8.0 (2024-07-21)

### ✨ Minor

  * ✨(preset/commont): Add mirror publish to mr and improve logging (!22) by Romain Deville ([`672c4fc`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/672c4fc11269fcfd5bb3b968b3683587af46f9e2))
  * ✨(preset/commont): Add mirror publish to mr and improve logging by Romain Deville ([`347c01b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/347c01b2679667ef0f761743755ab4b63ab19579)) 🔏

## v0.7.0 (2024-07-21)

### ✨ Minor

  * ✨ Update config to work with my custom zsh flake (!21) by Romain Deville ([`b533fe4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b533fe437c32943c64a398bb2bf6be7de056760e))
  * ✨(preset/minimal): Upgrade zsh to work with my own flake by Romain Deville ([`c08dd9d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c08dd9d6374284d022689e009dfb7aad65c8b76b)) 🔏

### 🩹 Patch

  * 🔧(preset/common): Remove lsd alias to avoid conflict with mine by Romain Deville ([`2f75457`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2f754571a8b1a1c64feda33255f47da13b0d8810)) 🔏
  * 🔧(preset/common): Remove hostname and username from starship by Romain Deville ([`46904ba`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/46904bae268de0d10d2fe6fc814b24cf6e4e22cc)) 🔏

### 🔊 Others

  * 🔥(preset/common): Remove eza as it does not have icon by Romain Deville ([`c83385c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c83385cecc31816da0194fd75f205f988b7936b2)) 🔏

## v0.6.0 (2024-07-20)

### ✨ Minor

  * ✨ Add bc package to minial hm presets (!20) by Romain Deville ([`df0727b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/df0727bfb01909a5312b08030f133bdd96e56bcb))
  * ✨(preset/minimal): Add bc package by Romain Deville ([`d6efb72`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d6efb726c731f405ef7bba585cee6adbd5e0c7c8)) 🔏

### 🩹 Patch

  * 🔧(preset/gui): Update kitty font config by Romain Deville ([`1222919`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/12229193ead1dc496f67255e278acd838cf42f3d)) 🔏

## v0.5.3 (2024-07-18)

### 🩹 Patch

  * 🐛(flavors/spotify): Update spotify enable_streaming config (!19) by Romain Deville ([`afcf613`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/afcf6133daf661ff30ac50fa6592003788d1bdb7))
  * 🐛(flavors/spotify): Update spotify enable_streaming config by Romain Deville ([`c432186`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c432186880eb82b10c3bafd1f768b543743d7cfe)) 🔏

### 🔊 Others

  * 🔥(preset/common): Remove starship battery segment as in my tmux (!18) by Romain Deville ([`24204e0`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/24204e03bd7cc897b00f2bba941e9bfde00faa0b))
  * 🔥(preset/common): Remove starship battery segment as in my tmux by Romain Deville ([`ebf00d8`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ebf00d822e7fbfc9dac1c1dea60bd5f9c1291174)) 🔏
  * 🔥 Remove useless code and programs I&#39;v packaged myself (!17) by Romain Deville ([`f564b24`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f564b24da551ad9435fa48afacf35bda27487866))
  * 🔥 Remove useless code and programs I&#39;v packaged myself by Romain Deville ([`1675b63`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/1675b63f2ebf2d580f975de09a524ccd8437e01e)) 🔏

## v0.5.2 (2024-07-17)

### 🩹 Patch

  * 🐛(presets/common): Fix users-dirs config (!16) by Romain Deville ([`7ad5f41`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7ad5f41c7ee2c097d6673282c5d4bcb8df61cc69))
  * 🐛(presets/common): Fix users-dirs config by Romain Deville ([`b1b872a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b1b872ae7d1174cf9616617e9420f78d725c5a6a)) 🔏

## v0.5.1 (2024-07-16)

### 🩹 Patch

  * 🐛(preset/commont): Fix way mr setup symlink (!15) by Romain Deville ([`921a980`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/921a980703b172a9136b9b2f4233047760e4f74a))
  * 🐛(preset/commont): Fix way mr setup symlink by Romain Deville ([`3f04728`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3f0472875356f8018a8cba44d08d0c61c8aa56f7)) 🔏

## v0.5.0 (2024-07-16)

### ✨ Minor

  * ✨ Update myrepos libs and kitty conf (!14) by Romain Deville ([`01ab977`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/01ab977a3802b94b4cacafd59e12c0a4a032dedd))
  * ✨(presets/common): Add myrepos lib setup_symlinks by Romain Deville ([`2aaabb1`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2aaabb19b4cdaa266c02e396eac9537f6db4c311)) 🔏

### 🩹 Patch

  * ⚡️(presets/gui): Add FiraCode font to kitty conf by Romain Deville ([`65ee86d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/65ee86dab9f318ec23a8a0888df796238721ce14)) 🔏

## v0.4.2 (2024-07-16)

### 🩹 Patch

  * 🐛 Fix git delta color config (!13) by Romain Deville ([`100151a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/100151a925def9adb0faaeeb8f4adbc7d6d97601))
  * 🐛 Fix git delta color config by Romain Deville ([`a4bf38a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a4bf38a9a779b9f86ea9706ca605055b795b207c)) 🔏

## v0.4.1 (2024-07-16)

### 🩹 Patch

  * 🐛 Fix git delta configuration (!12) by Romain Deville ([`246f5e2`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/246f5e2d009e248ea7d71a6eead62601707c24a9))
  * 🐛 Fix git delta configuration by Romain Deville ([`148dc9d`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/148dc9d39375865834acd4ff94ee0a5876eaa636)) 🔏

### 🔊 Others

  * 🎨 Remove unused param in modules by Romain Deville ([`e714384`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e714384993ac96c546feae8569ab8ef982ab9ae8)) 🔏
  * 🔥 Remove old tmux install method (!11) by Romain Deville ([`2405c5f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2405c5f5c4d82fa4d70973e9b0b44ff53bcade6f))
  * 🔥 Remove old tmux dotfile install method by Romain Deville ([`f272666`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f272666245db81abfadec67195f3c76c54bdb223)) 🔏

## v0.4.0 (2024-07-15)

### ✨ Minor

  * ✨ Update fastfetch by Romain Deville ([`b23b71a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b23b71a02a0f34fa0ccec9fc45e757c0c9052a6f)) 🔏
  * ✨(hm): Add fastfetch config to common preset (!9) by Romain Deville ([`cd02823`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cd028237c407cf75f7e1cf30f51bfeb19c36000d))
  * ✨(hm): Add fastfetch config to common preset by Romain Deville ([`9056e3c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/9056e3cc2d31b7066352c14f7b193f72c0dcebad)) 🔏

### 🩹 Patch

  * 🐛 Update FastFetch and Flake.nix (!10) by Romain Deville ([`2553485`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/25534855733e4a342f84f862f0579aee2a4e1fc5))
  * 🐛 Fix flake.nix (and lock) to have HM up-to-date by Romain Deville ([`e626563`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e6265630fbbf4246018698f7c247ef013ed153bb)) 🔏

### 🔊 Others

  * 🔥 Remove vimiv by Romain Deville ([`10a9e2c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/10a9e2cc855affa6d87c4dc8b3d1c8ac3ded9e70)) 🔏

## v0.3.2 (2024-07-14)

### 🩹 Patch

  * ⚡️ Remove mr from packages as it&#39;s now a programs (!8) by Romain Deville ([`a654f80`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/a654f80a6bb94a2c4d83fec378de82f2c90bc8c0))
  * ⚡️ Remove mr from packages as it&#39;s now a programs by Romain Deville ([`31092e9`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/31092e9576e8e5ecbffedcfc31c59aa1771f03f7)) 🔏

## v0.3.1 (2024-07-14)

### 🩹 Patch

  * 🐛 Fix (trying to) spotify player (!7) by Romain Deville ([`dff376a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/dff376a1aa274316011ad266cbcb62cfa415b0e7))
  * 🐛(flavors) Fix spotify player by Romain Deville ([`f6a746e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f6a746e5fc1e2ad0ca29e86f61736142274069e3)) 🔏
  * 📌 Update flake.lock by Romain Deville ([`4ac0776`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4ac07763b577f453d9fdb4d9e8a622f539477994)) 🔏

## v0.3.0 (2024-07-14)

### ✨ Minor

  * ✨ Add git config and fix userdirs (!6) by Romain Deville ([`500ec38`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/500ec38990b7486529012d7c2b33b3d2d619a18c))
  * ✨(presets): Add git to minimal preset by Romain Deville ([`0c3a8d4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0c3a8d463fb9b110aadd6dcfb1691e58e20edfe2)) 🔏

### 🩹 Patch

  * 🐛(presets): Fix user-dirs in preset common by Romain Deville ([`7ec5aac`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7ec5aac5f13ab2b76aa6402a6026243218dcd759)) 🔏

## v0.2.0 (2024-07-12)

### ✨ Minor

  * ✨ Add myrepos config and git packages (!5) by Romain Deville ([`b35c864`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b35c864449e6b28bc31bdb9c547d54211a749ba5))
  * ✨(hm): Update spotify flavors with options by Romain Deville ([`2a0dd6e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2a0dd6ec85b0c89649c5fe4b42c69d5aae9dfd8e)) 🔏
  * ✨(hm): Add lazygit to common preset by Romain Deville ([`08e9ab5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/08e9ab524355183130b50bc6189b8b926b06ef42)) 🔏
  * ✨(presets): Add user-dirs to common by Romain Deville ([`c33eabc`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c33eabc195ef9b2867ec12ec197e18f8cb5f3152)) 🔏
  * ✨(presets): Add myrepos to common preset by Romain Deville ([`f7aeef4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f7aeef4351002f55d7d4454f68e4eaacbfad5cbb)) 🔏

### 🩹 Patch

  * 📌 Update flake.lock by Romain Deville ([`44716ca`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/44716ca720e77a07eda1a7f0007af5ef6a0f30f2)) 🔏

### 🔊 Others

  * 🎨(nixos): Nix fmt preset default.nix by Romain Deville ([`5284fcb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5284fcbbcc841b1a637359885ab1aacc846044eb)) 🔏
  * 🎨(lib): Nix fmt my nix lib by Romain Deville ([`b8f6b4b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b8f6b4bdde0ec8962d4b09fe4e365f27c5a249dc)) 🔏
  * 🎨(hm): Nix fmt common preset by Romain Deville ([`915d535`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/915d53589db2d9f46aba78f7b69d0b1a1a3c72d4)) 🔏
  * 🔥(presets): Remove MR from common xdf dotfile by Romain Deville ([`de1561a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/de1561ab65e5f0470cea5c3842efef0738d2e8b2)) 🔏
  * 🔨 Make init_hook devbox script executable by Romain Deville ([`7f6834c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7f6834c30fe38b9a882cd6814c841bc960851701)) 🔏
  * 🔨 Update .envrc from DGS template by Romain Deville ([`cb2f749`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/cb2f749dc4e6a07ba52487bc376070a028eacfd7)) 🔏

## v0.1.0 (2024-07-03)

### ✨ Minor

  * ✨ Huge initialisation of my NixOS/HM Configs (!4) by Romain Deville ([`986987b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/986987bd49c189e143bddf89ef1c18d74d610ea7))
  * ✨ Add modules hm to nixify my config by Romain Deville ([`3bd89df`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/3bd89df4b1f484b453400cdd239053558528c600)) 🔏
  * ✨ Add config default.nix by Romain Deville ([`26cb70a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/26cb70a015ae4fd0eae0cdb0bbd278f2c55dcf8e)) 🔏
  * ✨ Add configs vms default.nix by Romain Deville ([`167e993`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/167e993d883a0f6956ece086e5a33d7f10f09c94)) 🔏
  * ✨ Add HM default.nix by Romain Deville ([`d95b527`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d95b527ffc010d67e2559055e233b1b0f8e38b76)) 🔏
  * ✨ Add HM flavors spotify by Romain Deville ([`e728b7f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e728b7f8601ddc3f62dbc973fdbbcd141ce6d2ad)) 🔏
  * ✨ Add HM flavors bluetooth by Romain Deville ([`70800b6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/70800b60d4b32000b32470135fd1cd516e73f59e)) 🔏
  * ✨ Add HM presets gui by Romain Deville ([`7b5a3aa`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/7b5a3aa1a41fd732afc4a8d323a0895b6b39c48d)) 🔏
  * ✨ Add HM presets main by Romain Deville ([`74b4a8b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/74b4a8bccb0eb51b920def19d7f8f45432cf5ad4)) 🔏
  * ✨ Add HM presets common by Romain Deville ([`21d9805`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/21d98055be631f485279799b79c570821b461801)) 🔏
  * ✨ Add HM presets minimal by Romain Deville ([`8940b60`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8940b60a070e460662bc418aca09c1271310e907)) 🔏
  * ✨ Add NixOS presets default.nix by Romain Deville ([`c4418af`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/c4418afe874a6102b3208bc04de14b1230b4a03b)) 🔏
  * ✨ Add NixOS presets gui by Romain Deville ([`72862e4`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/72862e4e3a38a57370956e32345931d20e01d6fe)) 🔏
  * ✨ Add NixOS presets common by Romain Deville ([`8a63b93`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/8a63b9327759584144405d9e441cba6da7c9b6bc)) 🔏
  * ✨ Add NixOS presets base by Romain Deville ([`69688cb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/69688cb439e2b02d5240edbb37e627f8646cedc8)) 🔏
  * ✨ Add NixOS Host Configuration for nixbox by Romain Deville ([`57ee5bb`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/57ee5bb903f3b6fd1d8ab1955976bbc5e33b359b)) 🔏
  * ✨ Add NixOS vms modules for nixos-shell and microvm by Romain Deville ([`df5c39c`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/df5c39cc5d0691f852ecf0752224b0c74f5d70c4)) 🔏
  * ✨ Add library functions by Romain Deville ([`d23ace6`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d23ace60948a15f9c2074bed8ef750875a857ecc)) 🔏

### 🩹 Patch

  * ➕ Add flake.nix and flake.lock by Romain Deville ([`d6a4056`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/d6a40560f1bd90546517929efad035e0ef497cf7)) 🔏
  * 🍱 Add colors sets by Romain Deville ([`72c198a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/72c198a4ea07fa89986bc309fcec37919fbe4b8d)) 🔏
  * 🔧 Add commitlint configuration by Romain Deville ([`5e5e921`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5e5e921a53ba1e9cfaadfce53ca1f39b274c48b9)) 🔏
  * 🔧 Add markdownlint configuration by Romain Deville ([`ad67b4f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ad67b4f75682f209ae88c5da7f318901e3392cbd)) 🔏
  * 🔧 Add python semantic release configuration by Romain Deville ([`95b9b91`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/95b9b9183ef525271d957d6b40358fffe851fe97)) 🔏
  * 🔧 Add cspell configuration by Romain Deville ([`16c20ac`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/16c20acb0bbc0951f14c05b147f47916c27b25a2)) 🔏
  * 🔧 Add .editorconfig by Romain Deville ([`b7a7d4e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/b7a7d4efb13a7ca8cde21e7dd13af4367df0306d)) 🔏
  * 🔧 Add .dotgit.yaml DGS configuration by Romain Deville ([`dcbe846`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/dcbe846aa34aa940f57cf6cb40624a6bed8b6a23)) 🔏

### 🔊 Others

  * 👷 Add Gitlab CI Build from templates by Romain Deville ([`0f36f32`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/0f36f323da1b5e695eebd7988d3e563bd58d92e0)) 🔏
  * 📄 Add LICENSES by Romain Deville ([`2e128fe`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/2e128fede6bc59ee75dc1642d927c426314fa6b5)) 🔏
  * 📝 Add CODE_OF_CONDUCT.md by Romain Deville ([`fcaf43e`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/fcaf43e696e0cdecd2da5759f5a93e66635cb04b)) 🔏
  * 📝 Add README.md by Romain Deville ([`912fd88`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/912fd88c4a79d68a1e9c3f7e43b716f24b954873)) 🔏
  * 🔨 Add devenv.nix and devenv.lock by Romain Deville ([`094375f`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/094375f8f7034f8cead60233ed704ba372c9ac75)) 🔏
  * 🔨 Add dev script to easily manage hm and nixos by Romain Deville ([`bbb6ff7`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bbb6ff718d88b4e90bffcfa8d842caa845b000e1)) 🔏
  * 🔨 Add setup.sh script to setup symlink of nixos by Romain Deville ([`4150088`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/4150088c5cb3fdeb1109a44b0a66e058b0b1d3ff)) 🔏
  * 🔨 Add .envrc by Romain Deville ([`ab2728a`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/ab2728a0a44d3ea660ed4c6f06aebcfba3a82ad7)) 🔏
  * 🔨 Add devbox configuration by Romain Deville ([`5c98931`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/5c98931b773f6f3189566ebe13f5aba75d0adefa)) 🔏
  * 🔨 Add .pre-commit-config.yaml by Romain Deville ([`e973adf`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/e973adf3d083755f932cf4d073b9f9f1f5094efc)) 🔏
  * 🙈 Add gitignore by Romain Deville ([`f44796b`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/f44796b095c23c1ccf93f34fab82a1c7fce34565)) 🔏

## v0.0.0 (2024-07-03)

### 🔊 Others

  * 🎉 Initial Commit by Romain Deville ([`bda6cd5`](https://framagit.org/rdeville-public/dotfiles/nixos-config/-/commit/bda6cd56f4093b88c1fdd5ea633367ea4d07a346)) 🔏
