<!-- markdownlint-disable-file -->
# CHANGELOG

## v0.29.7 (2025-09-16)

### 🩹 Patch

  * ⚡️ Add dotgit-sync HM module for template/user/rdeville main (!82) by Romain Deville ([`b81bbb2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b81bbb2245a0cd0c229563e1903f398f9c1516a9))
  * ➕(flake): Add dotgit-sync as inputs by Romain Deville ([`977356d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/977356de7cf9e8c9dbf2b05a1bfb26285739060f)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`813334a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/813334a7224a209ba376ff040de82eded4787803)) 🔏
  * 🔧(templates/users/rdeville): Add dotgit-sync to main template by Romain Deville ([`33d303c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/33d303c4d54adc43863616af1a4f2e229977f419)) 🔏
  * 🔧(hm): Add dotgit-sync inputs to HM imported modules by Romain Deville ([`bdf15c6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bdf15c6e814e3594f8fa29b0de6f26ddac2b1a55)) 🔏

## v0.29.6 (2025-09-16)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`a250236`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a25023628d8b6450302c443752c0a3802e04b544)) 🔏
  * 🔧(rey): Update facter.json and flake.lock (!81) by Romain Deville ([`1f6e65c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1f6e65c34600daffc691f4a68410dce91aa6575e))
  * 🔧(flake): Add terraform-docs overlay by Romain Deville ([`3ae4ff4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3ae4ff413edb8843fecb891d328aabaa5b5a18ec)) 🔏
  * 🔧(rey): Update facter.json by Romain Deville ([`731b59d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/731b59d1101457d0818c8036934cacd9e57712e3)) 🔏

## v0.29.5 (2025-09-03)

### 🩹 Patch

  * ⚡️(overlay): Improve regexp in overlay to support package with &#39;-&#39; by Romain Deville ([`644b51a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/644b51a2b6c93b75201618bebf21f039a7726d74)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`4313ebe`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4313ebe7ba61e127d440c3c84c9430005bc1d75f)) 🔏
  * 🔧 Drop cudaSupport for darth-maul, update hyprland cfg, improve overlay (!80) by Romain Deville ([`9f2f95e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9f2f95e1c4bbeaa5d0fc603c632624c57208e1f1))
  * 🔧(flake): Add spotify-player and nwg-display overlay until backport by Romain Deville ([`8536e9a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8536e9a2363c123d30d59dc53a16431bc983d467)) 🔏
  * 🔧(rey/user/rdeville): Add monitor to hyprland config by Romain Deville ([`ed17635`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ed17635ad57704b44d70dcce6abeb6668180b4f7)) 🔏
  * 🔧(rey): Update /etc/hosts entry for local kube by Romain Deville ([`2cacf36`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2cacf3675305c0f9183b32fd4ae75a038708c0c9)) 🔏
  * 🔧(darth-maul): Drop cudaSupport by Romain Deville ([`a3c469e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a3c469e4cbf41e1cb4acbbff54e1ef54a2a030f3)) 🔏

## v0.29.4 (2025-09-03)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`372ce73`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/372ce73ed58840b07a3110777a2ed0fdc01e2e83)) 🔏
  * 👽️ Update network configuration to due os.flavors.network update (!79) by Romain Deville ([`007c5e4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/007c5e4d976aada9a6a90f7d5a279264e6aa95c3))
  * 👽️(rey/net): Update network generation due to os.flavors.network update by Romain Deville ([`9eb6d04`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9eb6d04bd158236c85209fee93d14375ec11600e)) 🔏
  * 👽️(lib): Update function to interface due to os.flavors.network update by Romain Deville ([`3e0aa30`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3e0aa30ca25b3128ce8fdc706c123876cdcc5d0e)) 🔏
  * 🔧(kenobi/net): Add route and disable pool for network eth-k8s by Romain Deville ([`c95163a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c95163a5b20d2b50ec65c937df84377e9b50b2bd)) 🔏

## v0.29.3 (2025-09-01)

### 🩹 Patch

  * ⬆️ Update flake.lock (!78) by Romain Deville ([`16326e9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/16326e9ac2eb361d58642f246f83ae077402d2e2))
  * ⬆️ Update flake.lock by Romain Deville ([`2dd4109`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2dd41090f56268a977aa14c2089b166074b44a23)) 🔏

## v0.29.2 (2025-09-01)

### 🩹 Patch

  * ⚡️(os/k8s-server): Remove k3s storage path and VMs users definition in modules by Romain Deville ([`6a36f3e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6a36f3e0c2e3b299adef7c94ba2cd44a7e234e8e)) 🔏
  * ⚡️(hm/accounts): Define thunberbird contact and calendar account activation by Romain Deville ([`65f82c1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/65f82c19bb8abdf4929689b743a89e3c4b38d4a6)) 🔏
  * ⚡️(lib): Add thunbirder to accounts and calendar accounts since it&#39;s supported by Romain Deville ([`57cb403`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/57cb403b8df51399b81dd108288c67aad7f6ae43)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`3ec46fa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3ec46fa6c2fddb61e93112327d98c791b56f6452)) 🔏
  * 🔧 Deactivate all VMs, rework network and script to reinstall machines (!77) by Romain Deville ([`311df8a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/311df8afe091406e6651a19f6ccd49ca26559840))
  * 🔧(flake): Add vdirsyncer overlay by Romain Deville ([`b1f76a5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b1f76a5dccb6e9d9d39be27be114b2561a040b53)) 🔏
  * 🔧(topology): Update P-Wing description by Romain Deville ([`4c9a3a5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4c9a3a55ccb49e0164b3e909d9a4d27e7765fd62)) 🔏
  * 🔧(nixos-live): Update nixos-live configuration due to other changes by Romain Deville ([`f01846c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f01846cbf8b03386f4d5e98d4d0b3f29b7ff6ac6)) 🔏
  * 🔧(luke/disko): Redefine leia disko partition (less root, more storage) by Romain Deville ([`dffeae0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/dffeae0beea95c8cebd1c4e309fd938589d91078)) 🔏
  * 🔧(leia/disko): Redefine leia disko partition (less root, more storage) by Romain Deville ([`eb295f9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/eb295f9f7b7bc319f56995eb68daae7127521f16)) 🔏
  * 🔧(rey): Remove wg-k8s-dev configuration since removed from kenobi by Romain Deville ([`0c85053`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0c85053e4d4796f3f8e10f2837dbf9b4392f2ca6)) 🔏
  * 🔧(darth-maul): Remove wg-k8s-dev configuration since removed from kenobi by Romain Deville ([`9c849a1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9c849a1edbb30c39c699c262e7c75a9dc2c0661e)) 🔏
  * 🔧(kenobi/network): Deactivate wg-k8s-dev network for now by Romain Deville ([`db7c8ae`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/db7c8aec6e018445e65079622ab80da08eb586c1)) 🔏
  * 🔧(kenobi/dns): Drop dev cluster (vms down), update local entry by Romain Deville ([`99c8d65`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/99c8d65aa00d357e78ccb44288a79df48adeaca9)) 🔏
  * 🔧(kenobi/microvms): Deactivate microvms for now and haproxy by Romain Deville ([`908a49c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/908a49c484c6515e498795a7e76cecdffddea7bb)) 🔏
  * 🔧(darth-maul/network): Drop k3d nft rule for vagrant by Romain Deville ([`9399540`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/93995407aead34b6bc5ae35f538a5873b0e8ba6a)) 🔏
  * 🔧(darth-maul/microvms): Deactivate k8s-dev VMs for now by Romain Deville ([`b62bd43`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b62bd43b20c12e1a329051c75547df8aac915d60)) 🔏
  * 🔧(rey/topology): Remove redondant topology information by Romain Deville ([`46feaa8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/46feaa87149997e895ec0189e4f6a7967a7b656e)) 🔏
  * 🔧(rey/users/rdeville): Update hyprland monitor configuration by Romain Deville ([`f556919`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f556919bb5973f395332a80902c593c860f5eb72)) 🔏
  * 🔧(rey/network): Drop k3d nft rule for vagrant by Romain Deville ([`dbd3670`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/dbd367086f32b801125d6fb543ba6a3b05571f55)) 🔏
  * 🔧(rey): Update /etc/hosts content with new vagrant cluster by Romain Deville ([`8611e89`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8611e891ca3d102314b0e2525a003a746a85b57a)) 🔏
  * 🔧(rey/microvms): Deactivate k8s-dev VMs for now by Romain Deville ([`7d4dedc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7d4dedce82225750dbbaa18558f86779c9d8a4e3)) 🔏
  * 🔧(palpatine/users/rdeville): Fix palpatine configuration and remove dougs cfg by Romain Deville ([`a03e698`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a03e6986f36c1833fd36bb7471c71f655db5a8e7)) 🔏
  * 🔧(template): Improve user rdeville groups and ssh keys management by Romain Deville ([`89027e0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/89027e0f730107cecb87992328a5509bf7dc9bff)) 🔏
  * 🔧(hm): Rework home-manager.nix and comment darwin palpatine for now by Romain Deville ([`f86230d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f86230d2d914b1f80a7a2a7fcc777d5c67b08ed1)) 🔏

### 🔊 Others

  * 🔥(hm/accounts): Remove dougs accounts by Romain Deville ([`75c6dfd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/75c6dfd162ed182f0fc2e9f7b372c9a6b51f06ac)) 🔏
  * 🔨(scripts): Update deploy and install script after luke and leia reinstall by Romain Deville ([`d7d0c8a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d7d0c8a8c93609256ad019db42fc149edcc0bef0)) 🔏
  * 🔨(scripts/lib): Update check_user method with new folder structure for HM by Romain Deville ([`eb818f9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/eb818f9ac535d1a2cf6136ae66c1f36cf3b14771)) 🔏
  * 🚚(kenobi): Move nginx and haproxy config from microvms to ingress by Romain Deville ([`0066205`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/006620513f3386ba733d74db8ef33743aa40ea65)) 🔏

## v0.29.1 (2025-08-11)

### 🩹 Patch

  * ⬆️ Update flake.lock and format code (!76) by Romain Deville ([`a96d76d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a96d76d11da58d0cc0154d4051029e04edc61737))
  * ⬆️ Update flake.lock by Romain Deville ([`f17af4f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f17af4fdc3005f75bcd23d6864b4c7ccb591a835)) 🔏

### 🔊 Others

  * 🎨 Pass nix format on the code by Romain Deville ([`85445e6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/85445e6a62f66c20461ddecedc5eb1c3ffc2bb12)) 🔏

## v0.29.0 (2025-08-06)

### ✨ Minor

  * ✨(darth-maul): Make darth-maul k3d local k8s cluster ready (!75) by Romain Deville ([`469edfc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/469edfc66d7a36c725b0b10ba90f833a45b89e0f))
  * ✨(darth-maul): Make darth-maul k3d local k8s cluster ready by Romain Deville ([`225ef26`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/225ef263381c965cbf95c0005a3af9a31b0bcc8e)) 🔏

## v0.28.1 (2025-08-06)

### 🩹 Patch

  * ⚡️ Declare group docker for user rdeville in templates config (!74) by Romain Deville ([`1817030`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1817030a53f55d69aaf3c3c7c71e040c924bf76b))
  * ⚡️(template/main): Add user rdeville to docker group for k3d for main machine by Romain Deville ([`0d3eec0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0d3eec07c926a5d113cbd29589f70569d624d65a)) 🔏

### 🔊 Others

  * 🔥(rey): Remove docker for rdeville since declared in template now by Romain Deville ([`26daeaa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/26daeaaff82019910a9a9d2bf3f347529c9744e0)) 🔏

## v0.28.0 (2025-08-05)

### ✨ Minor

  * ✨ Huge refacto, new k8s module, now all machines are k8s ready (!73) by Romain Deville ([`73209aa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/73209aafc442bede9c44827190439da59833d946))
  * ✨(kenobi/vms): Refacto, use new k8s-vms module and setup LB (http/https/cp) by Romain Deville ([`d59ce02`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d59ce021b63e2d1409b5ad00d6d9fab1ce12481e)) 🔏
  * ✨(nixos): Include k8s-server and k8s-microvms modules by Romain Deville ([`ac1d776`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ac1d77688f4d4bca5cdc592bc2a918c0596dc489)) 🔏
  * ✨(nixos/k8s-server): Add module to ease and normalize deployment of k8s server by Romain Deville ([`63c73d8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/63c73d8578deeb5eabdb071c959b4a08e15e2636)) 🔏
  * ✨(nixos/k8s-microvms): Add module to ease and normalize deployment of k8s VMs by Romain Deville ([`c0f02fb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c0f02fbd1ebb77a52e3da2adb7dce3090cb925dc)) 🔏

### 🩹 Patch

  * ⚡️(kenobi/net): Harden network config and use new public network module by Romain Deville ([`9f3f20d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9f3f20d8abb01f250160766c2cebeb14a537bdcc)) 🔏
  * ⚡️(kenobi/dns): Add log config, local romaindeville.xyz domain and simplify config by Romain Deville ([`c41209e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c41209e2f40691bbcef04f6028497d3d7719c8db)) 🔏
  * ⚡️(templates/user/rdeville): Add unfree cuda package if cudaSupport by Romain Deville ([`58176da`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/58176da2c94595361add8afc2cd5b5ae0e831242)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`6186316`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/618631662714eb6969cf18e339c54d5dc181efe8)) 🔏
  * 🍱(assets): Add service HAProxy logo to assets by Romain Deville ([`8a83695`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8a836957c720cb2473706c4da5613c6569d935ea)) 🔏
  * 👽️(rey/net): Update network declaration to use new network module by Romain Deville ([`01141a4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/01141a407de09fad93ff8f90bda1e9df09737477)) 🔏
  * 👽️(lib): Update wireguard method due to change in my public nixos network module by Romain Deville ([`e3c12f3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e3c12f340cb61c0a4f36ebe490a31cad14c8a47c)) 🔏
  * 🔧(kenobi/net/wg): Update client address after refacto by Romain Deville ([`25093dc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/25093dc241ee0dc8b1faedc97cafb8bd8d7d664d)) 🔏
  * 🔧(kenobi/dns): Add resolution *.local to 127.0.0.1 to ease local development by Romain Deville ([`b6f1035`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b6f1035e786c08250996e14f0f6d6e18416c5ac0)) 🔏
  * 🔧(rey): Update rey configuration to use k3d by Romain Deville ([`6d94673`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6d94673700d3039515981d2b7d0514851baf5a15)) 🔏
  * 🔧(darth-maul/net): Add DNS config for eth network by Romain Deville ([`68f8740`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/68f87400391e584a7cb963f11964bfd64a2f239b)) 🔏
  * 🔧(darth-maul): Add cudaSupport by Romain Deville ([`e11843b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e11843b279a2e43941e3590293896cdf93d6ed64)) 🔏
  * 🔧(common/k8s): Update k8s TCP ports with new NodePorts for HAProxy LB by Romain Deville ([`997d30e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/997d30e796af5a840e46fee5b400c353add6253f)) 🔏
  * 🔧(template/users/rdeville): Replace gimp2 to gimp3 for Gui &amp; Main computer by Romain Deville ([`17d17c2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/17d17c292a101dfa2e8c0ea95d80a707ff7ed63c)) 🔏
  * 🔧(template/server): Add openssl, dive and wget package by Romain Deville ([`921e47c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/921e47c7be610a8691bad2d003488f78c4928988)) 🔏
  * 🔧(flake): Add ia-robot-txt to inputs by Romain Deville ([`5a9dac3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5a9dac3ce49c3fbf9908e6fa4c1e6d378170e9d4)) 🔏

### 🔊 Others

  * ♻️(lilith): Refacto to use new k8s-server module by Romain Deville ([`b9ea8d7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b9ea8d7f37a463461d394f6978f0b0221f223dd9)) 🔏
  * ♻️(maya): Refacto to use new k8s-server module by Romain Deville ([`08edca8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/08edca8f29b9ca0905f81b157f81d466d888be39)) 🔏
  * ♻️(ava): Refacto to use new k8s-server module by Romain Deville ([`f14e25f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f14e25ffe4fef3f22314432b45908c1a8fd4e852)) 🔏
  * ♻️(leia): Refacto to use new k8s-server module by Romain Deville ([`6b95fa6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6b95fa6ab04fdd10d096a286929b1d82baeade8b)) 🔏
  * ♻️(luke): Refacto to use new k8s-server module by Romain Deville ([`a925ef3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a925ef3bd9a5763d8a5802a7fb4a8830ce63014f)) 🔏
  * ♻️(rey/vms): Update VMs declaration to use new k8s modules by Romain Deville ([`228eb8f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/228eb8f25fb12c472030ec519d9ec43fd1772fdf)) 🔏
  * ♻️(darth-maul/vms): Update VMs declaration to use new k8s modules by Romain Deville ([`8e4623a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8e4623a5f1a6b68beaf572990d9ee36c466e2146)) 🔏
  * ♻️(_templates): Refacto Users declaration due to new k8s modules by Romain Deville ([`c9bdc02`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c9bdc025e1770275679cf2f437ca7b4122406699)) 🔏
  * ♻️(hm): Change structure of usage of home-manager due to new k8s modules by Romain Deville ([`ade193a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ade193a410c0de5fc39b1a816014f930c35f38ea)) 🔏

## v0.27.1 (2025-07-29)

### 🩹 Patch

  * ⚡️ Review (again) networks security and clean scripts folder (!72) by Romain Deville ([`bd9509e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bd9509eb59f4186ca29ad7c4443b639b6908de7b))
  * ⚡️(darth-maul): Hardening network firewall and nftable by Romain Deville ([`3a82a4d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3a82a4df933dd0e7a62467c77fa0b1e4c08a5cef)) 🔏
  * ⚡️(rey): Hardening network firewall and nftable by Romain Deville ([`1bf8aeb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1bf8aeb241c84f84941b322d24ef213cfa415386)) 🔏
  * ⚡️(kenobi): Hardening network firewall and nftable by Romain Deville ([`40f4477`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/40f4477b228a577689071702d3051e1c60dc598b)) 🔏
  * ⚡️(scrips): Update script deploy to support local inputs by Romain Deville ([`7ab6c43`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7ab6c434b7e93e3e63a4970099733a7afffd777c)) 🔏
  * ⬆️ Upgrade devbox.lock by Romain Deville ([`32a19e4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/32a19e420030d030c2cef353ddd951873e3d0e25)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`2d98e34`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2d98e34ddd907601589f654a6dc78b853dbc6e6f)) 🔏

## v0.27.0 (2025-07-28)

### ✨ Minor

  * ✨ Hardening currently deployed node networks (close firewall and nftables) (!71) by Romain Deville ([`64d1540`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/64d1540ae50ff6dfa1ce3e621ea03178a5f82f4e))

### 🩹 Patch

  * ⚡️(maya/net): Update network to latest module nixos.os version by Romain Deville ([`fbe7d19`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fbe7d197449c743abdffbdfb990a86245b303f19)) 🔏
  * ⚡️(luke/net): Hardening network, removing useless nftable rules by Romain Deville ([`25283a1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/25283a1507915b2eafcf90c07bc5f6ef652f23b6)) 🔏
  * ⚡️(lilith/net): Update network to latest module nixos.os version by Romain Deville ([`c921927`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c921927ead284b517063a6468cf90ce9eaf5903f)) 🔏
  * ⚡️(leia/net): Hardening network firewall and nftable by Romain Deville ([`e309b14`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e309b14eae0860fded2596b788afd38e9673fab2)) 🔏
  * ⚡️(ava/net): Update network to latest module nixos.os version by Romain Deville ([`9501809`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9501809a87e5ca1bdbbe05ff9763787b6ffad886)) 🔏
  * ⚡️(darth-maul/vms): Hardening VMs network firewall and nftable by Romain Deville ([`b16c5f4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b16c5f4b812a522cd44904e551055b76defd7293)) 🔏
  * ⚡️(darth-maul/net): Hardening network firewall and nftable by Romain Deville ([`699573b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/699573bb8711481b9dc5f68aa2aa70e9bc22749c)) 🔏
  * ⚡️(rey/vm): Hardening VMs network firewall and nftable by Romain Deville ([`5498ecc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5498ecc703c798106531aad9dfa7935d61429f27)) 🔏
  * ⚡️(rey/net): Hardening network firewall and nftable by Romain Deville ([`2f1b3b1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2f1b3b1ec04e4a1f7a7c3c82e661279d320d0557)) 🔏
  * ⚡️(kenobi/net): Hardening network firewall and nftable by Romain Deville ([`5b424df`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5b424df534f376e9a55b96a5c405c57867053f8b)) 🔏
  * ⚡️(lib): Add interface support to function wgConfig by Romain Deville ([`ba83bd6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ba83bd617f88e19aa4e329af545a128bbeb81e7c)) 🔏
  * ✏️(overlays): Fix typos in overlays module by Romain Deville ([`b81d5b3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b81d5b329c470616fee30051fbf197c16cd0cb90)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`23ba2e1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/23ba2e19babd9432e9c1539004978b570fddaa29)) 🔏
  * 🔧(darth-maul/hardware): Activate bluetooth by Romain Deville ([`e5e4ad5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e5e4ad5f118c28168ecd0bc8f9e931613068769b)) 🔏
  * 🔧(kenobi/vms): Hardening network firewall and nftable by Romain Deville ([`0153bfe`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0153bfeb697a4943b5ccbcf22e29a8a34be5a116)) 🔏
  * 🔧(kenobi/wg-private): Fix vm-rey public key by Romain Deville ([`12f420d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/12f420dfe4c5cf72f36cf3f5048c80435debf7fe)) 🔏
  * 🔧(kenobi/dns): Fix some VMs DNS entry by Romain Deville ([`1e8d77b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1e8d77bb32aaf7400c5a428a986aa0ffa5484070)) 🔏

### 🔊 Others

  * 🔥(common/cfg/k8s): Remove wg-k8s-dev from default input trusted interface by Romain Deville ([`9ff5ba6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9ff5ba668693766cefb7123fdb1e782732e863a7)) 🔏
  * 🚧(scripts): WIP on script deploy by Romain Deville ([`0f160d1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0f160d126bca660325dc8bf5bf3ee1e58925a200)) 🔏

## v0.26.1 (2025-07-28)

### 🩹 Patch

  * 🐛(overlay): Fix overlay module to due warning (!70) by Romain Deville ([`3c37a6d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3c37a6dcc286f6074cb1ec203adde6ac0a5eaf01))
  * 🐛(overlay): Fix overlay module to due warning by Romain Deville ([`a29dae2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a29dae203259d436020ad602b9a6c4354f450a5d)) 🔏

## v0.26.0 (2025-07-26)

### ✨ Minor

  * ✨ finalize k8s stg node and update networks rendering (!69) by Romain Deville ([`018ea4f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/018ea4ff4f4024ed5cb23a024eb9284e3fe9061b))

### 🩹 Patch

  * ⚡️(luke): Improve network for k8s by Romain Deville ([`da4613f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/da4613f7f0cd1e931607567d8b111e9970778117)) 🔏
  * ⚡️(leia): Improve network for k8s by Romain Deville ([`7f2db49`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7f2db49c73cf481a7aee689b941cb37decbfa924)) 🔏
  * ⚡️(kenobi/net): Improve networks for k8s nodes and vlans by Romain Deville ([`84026cf`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/84026cf7d3db332a6294221910af289ce8043947)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`fd7f24c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fd7f24c0b89d1c07cd80cd944f3571a96759fedc)) 🔏
  * 🐛(kenobi/vms): Fix nginx address related to vms by Romain Deville ([`5fdc8de`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5fdc8deb60c5b8b19aa3c3a09a989cc50ab21d12)) 🔏
  * 🔧(topology): Update k8s stg nodes hardware description by Romain Deville ([`82df123`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/82df123fce85fa6b170c1fb0f4f04a994bc16cd1)) 🔏
  * 🔧(maya): Prepare k8s nodes network by Romain Deville ([`6f8f47c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6f8f47c3f5ebddec620644dd2853acaba5e4c442)) 🔏
  * 🔧(lilith): Prepare k8s nodes network by Romain Deville ([`b5f203a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b5f203a8e8dff59f710f4d5f49033206ffdc17df)) 🔏
  * 🔧(ava): Prepare k8s nodes network by Romain Deville ([`da80223`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/da802239fff37f1976dd4bf95e08edab969c590c)) 🔏
  * 🔧(kenobi/dns): Update DNS entry with right IPs by Romain Deville ([`2a8810c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2a8810c66ef4f0827c6327ec6a0fac4e4577d1f5)) 🔏
  * 🔧(rey|darth-maul): Update network config for topology rendering by Romain Deville ([`735c761`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/735c76179c22fcb3eb4ee12b30e854c423e2423f)) 🔏
  * 🔧(templates): Update pkgs for host server by Romain Deville ([`fbdbec2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fbdbec23c840afc6e153942beab379dc33e98822)) 🔏

### 🔊 Others

  * 🔥(kenobi): Remove packages now in templates/server by Romain Deville ([`a02c21c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a02c21cbfd147087577e4ad1301a1755a120b586)) 🔏
  * 🔥(rey|darth-maul): Remove package now in templates/server by Romain Deville ([`0c3ed3c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0c3ed3cec217fab7d79343da4093f6526027dcb8)) 🔏
  * 🔨(scripts): Add gpg script to auto-import or update expiricy by Romain Deville ([`e673498`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e67349810e1eadc873ebf601d738a3e23a262a5b)) 🔏
  * 🔨(script): Fix AGE key path in install script by Romain Deville ([`40715a7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/40715a7d43c0bc297d9217b10f6fe4b1fcd2777d)) 🔏

## v0.25.1 (2025-07-25)

### 🩹 Patch

  * 🔧(rey): Remove useless wg-public config by Romain Deville ([`fb85ffa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fb85ffaa3651d580fdadac4f42327e274687f6d4)) 🔏
  * 🔧(kenobi): Remove useless wg-public config by Romain Deville ([`112a533`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/112a533d41ded476800c0f1063580a5490f34625)) 🔏
  * 🔧(darth-maul): Remove useless wg-public config by Romain Deville ([`085a8fd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/085a8fd7dfba58552bdcfd3224436b53db3a08e3)) 🔏

### 🔊 Others

  * 🔥 Remove useless wg-public config for microvms* (!68) by Romain Deville ([`d1f927f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d1f927f6149907eb297de33f5306f3c973414cc2))

## v0.25.0 (2025-07-25)

### ✨ Minor

  * ✨ Prepare all machines to be k8s nodes (!67) by Romain Deville ([`226820a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/226820a29b66fa49f2b315ede9c72fe3b57625fc))
  * ✨(ava): Add ava base k3s configuration and secrets by Romain Deville ([`a6e6ab3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a6e6ab33fd1b846b7642da43b2fea80facd5fa74)) 🔏
  * ✨(maya): Add maya base k3s configuration and secrets by Romain Deville ([`fc36383`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fc36383121c68f8780b0295f0a79938a8a6a6620)) 🔏
  * ✨(lilith): Add lilith base k3s configuration and secrets by Romain Deville ([`bf9d954`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bf9d9542c6c15db578b98adef07e7cddb27908e2)) 🔏
  * ✨(luke): Make luke k8s ready by Romain Deville ([`139d9be`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/139d9be6bdb513e49375b868836d7c549fe8bbc4)) 🔏
  * ✨(leia): Make leia k8s ready by Romain Deville ([`3e539fc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3e539fc838e1f7709c0eadd4bd412273624312be)) 🔏

### 🩹 Patch

  * ⚡️(rey): Make rey k8s ready by Romain Deville ([`f56e28f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f56e28f5e2dfcce06ee0d70652a7defe70991a67)) 🔏
  * ⚡️(darth-maul): Make darth-maul k8s ready by Romain Deville ([`bc50fcf`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bc50fcfa289af47b19345b78002fd578937ba5e4)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`11dc920`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/11dc9208133f51141033fd247cc0f596b59aeae5)) 🔏
  * 🐛(nixos-live): Fix path in imports by Romain Deville ([`7160eb8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7160eb87ce37b83f8be95e769869f39361810659)) 🔏
  * 🐛(_templates/user): Fix azathoth config is not main machine by Romain Deville ([`17c4e8f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/17c4e8f2169bd5d3a51655f5e5641ac6ce6a400a)) 🔏
  * 🔒️(sops): Add ava, maya and lilith to sops rules by Romain Deville ([`062d74b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/062d74b52ceae6d5981a0f1e47f8ac049baa1c6e)) 🔏
  * 🔧(kenobi): Add new machines wireguard keys to wireguard networks by Romain Deville ([`81868a3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/81868a34b468a3655b62ef69542e5a8bc3d23381)) 🔏
  * 🔧(topology): Remove lilith, maya and ava from manual topology by Romain Deville ([`1b05225`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1b05225ca030c382157893035a641bec3a169bc8)) 🔏

## v0.24.1 (2025-07-22)

### 🩹 Patch

  * ⬆️ Update flake.lock (!66) by Romain Deville ([`3dc8bd6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3dc8bd6c862b6748e2fea48e6ce0aa36ef3a3f8c))
  * ⬆️ Update flake.lock by Romain Deville ([`c42ae64`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c42ae646fc0c181f1f2cd1e955a61769eab9a41d)) 🔏

## v0.24.0 (2025-07-22)

### ✨ Minor

  * ✨(darth-maul): Add k8s-dev microvms configuration by Romain Deville ([`bcb89ba`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bcb89baf0714866c90588e99ea357680cdfadac2)) 🔏
  * ✨(darth-maul/net): Add wiregaurd infra config and normalize net by Romain Deville ([`aea8b35`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/aea8b355fb953d662dd9a0430760d4857ef59a04)) 🔏

### 🩹 Patch

  * ⚡️ Improve kenobi, rey and darth-maul to use new network module (!65) by Romain Deville ([`8e131c3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8e131c3d9bdefe8e71b41afb5af295de432387e0))
  * ⚡️(rey/net): Update networks definition to use os.flavors.network module by Romain Deville ([`95091b0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/95091b01b63f4683c0298c0fcbbb80148d9ddafd)) 🔏
  * ⚡️(darth-maul/user): Update user config and secret path by Romain Deville ([`db81df1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/db81df11d54c0cf6f5e543c80343b4717e3acd1f)) 🔏
  * ⚡️(luke): Improve network configuration by Romain Deville ([`db23ca3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/db23ca33835dada9626cf7d40fd6cd93c2926cc4)) 🔏
  * ⚡️(os): Improve nixos.nix by Romain Deville ([`edf1831`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/edf1831c17f65dabcd28c3d280f28e43effe8a75)) 🔏
  * ⚡️(lib): Add mkWgNetwork function by Romain Deville ([`b4b7fe7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b4b7fe7bf8f639185911ec087995984b03058c12)) 🔏
  * ➕(flake): Add self to nixos import by Romain Deville ([`495e78d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/495e78d08a1b49123fbb9d833083374d88742b14)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`5770916`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/577091647564d66e0510b9acc9ca54c33e171a19)) 🔏
  * 🍱(assets/devices): Add pixel-7 image by Romain Deville ([`a93d441`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a93d4416d2e9014495f2996654069f9b57583f1b)) 🔏
  * 👽️(hm): Update nix-index-database imported module by Romain Deville ([`2f75e2a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2f75e2ad32b6ba3145325fee4eee13848f50f852)) 🔏
  * 🔧(kenobi/dns): Update DNS configuration by Romain Deville ([`82043e9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/82043e95ee0c4f88c89f9bdab68f678b3fda264d)) 🔏
  * 🔧(kenobi/users): Update secret path by Romain Deville ([`fc80839`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fc808393aaf496de9d3c9f2809ac76dc1446d616)) 🔏
  * 🔧(kenobi/vms): Update k8s vms configuration by Romain Deville ([`8e77a5b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8e77a5b7a8c9d5c1d4a329884f04df12b6044b1d)) 🔏
  * 🔧(rey/users): Update secret path by Romain Deville ([`bfd3d58`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bfd3d5856577e0973c606143722380f44b8d7d50)) 🔏
  * 🔧(rey/vms): Normalize microvms to use os.flavors.network module by Romain Deville ([`b09036d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b09036d5529404fcf3944ed405236ae3434b3587)) 🔏
  * 🔧 rey net by Romain Deville ([`65951af`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/65951af89adcea1c5ec944fd94ad2c6c3b4f09ef)) 🔏
  * 🔧(rey): Update config with nameserver, add wireguard tools, remove comment by Romain Deville ([`7bbe1b4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7bbe1b4c25129da4905f77e3ddd0adb7b7db75c9)) 🔏
  * 🔧(palpatine/users): Update secret path by Romain Deville ([`f81783b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f81783b30b2bc6fc79653a7dc28d8e76efa2cae8)) 🔏
  * 🔧(luke): Update secret path by Romain Deville ([`8e058ff`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8e058ffd57dba4f14987b8974d3238e7ffcb5d2f)) 🔏
  * 🔧(leia): Update secret path by Romain Deville ([`a843336`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a843336999dd92f77aaa448deaf03a7cb15a0ef1)) 🔏
  * 🔧(common): Add k8s common configs by Romain Deville ([`e2fdb7d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e2fdb7d2a37643dd09c67227458f8c0fbb9cc67d)) 🔏
  * 🔧(topology): Update topology config due to net changes by Romain Deville ([`9c21c1c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9c21c1ca84b26e5948eccc7a047bd6c3f7cd5889)) 🔏

### 🔊 Others

  * 🔐(kenobi/net/wg-public): Add P-Wing configuration by Romain Deville ([`97ef96b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/97ef96b67e171b4c09051f8739c2f88d8df56e1b)) 🔏
  * 🔐(kenobi/net): Update config to use os.flavor.network module by Romain Deville ([`5f2cc3c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5f2cc3c4b2f6b77d2d736013615e404da1d1c594)) 🔏
  * 🔐(darth-maul/keys): Add wireguard keys by Romain Deville ([`b49be18`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b49be18489e49e4ad9ccba7e886a983ec94923b3)) 🔏
  * 🔐(luke): Add wireguard keys by Romain Deville ([`21cc181`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/21cc181ca64d43d64514ec01cdbd83a69af991d7)) 🔏
  * 🔐(common): Move common_secrets to common/secrets by Romain Deville ([`c7684b8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c7684b843a11499c67dd18d7972e5878948ef03d)) 🔏
  * 🔨(scripts): Improve deploy script by Romain Deville ([`9ecb63d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9ecb63dce0ef671dde71737c787d2dbab8021979)) 🔏

## v0.23.0 (2025-07-09)

### ✨ Minor

  * ✨ Instanciate k8s infrastructure (!64) by Romain Deville ([`e81e85a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e81e85a4835b8c10d4dd4350786a5174b378ccbf))
  * ✨(rey/microvms): Add k8s microvms by Romain Deville ([`e2775b9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e2775b91f17018adfcebf7c8450ea8264be92309)) 🔏
  * ✨(kenobi/microvms): Add k8s microvms, not activated yet by Romain Deville ([`d813612`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d813612c23cc130289b131a5e03f29a525dbfd59)) 🔏
  * ✨(kenobi/dns): Update DNS entry and add DNS for k8s wireguard networks by Romain Deville ([`f50a598`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f50a5981f5d8ca4939574f6eb5f56f2f097a2396)) 🔏
  * ✨(kenobi/net): Normalize networks and add k8s wireguard networks by Romain Deville ([`d71e126`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d71e126a5c73b3dbccfd2c2aae338de58d3aa7fa)) 🔏

### 🩹 Patch

  * ⚡️(rey/network): Normalize network configuration with nftables by Romain Deville ([`e067a8e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e067a8e401b5899142ab2f469fd94c2c898ccfc5)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`b956eac`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b956eac9689bb43444d695ce0095ff472743f487)) 🔏
  * 🔧(topology): Update topology due to infra updates by Romain Deville ([`eea9771`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/eea9771466cac218323fb3bc0d678197547bf7a1)) 🔏
  * 🔧(templates/server): Update allowed command for azathoth by Romain Deville ([`0f9186e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0f9186ee6a3e0367ad7d8a2621ecdc50ba9c277f)) 🔏
  * 🔧(luke): Explicitly allow Ports by Romain Deville ([`42c6b10`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/42c6b108c451d6ad3628bf23bc64744e63e38c3e)) 🔏
  * 🔧(leia): Explicitly allowed Ports by Romain Deville ([`706b6f9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/706b6f9a11fda76618866c5b9aaf94494b0aa813)) 🔏
  * 🔧(sops): Remove microvms specific sops config by Romain Deville ([`2f7f4b7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2f7f4b7efcfba0b661c176eb3b0854a27082e374)) 🔏
  * 🔧(flake): Update topology to ignores nixos-live configurations by Romain Deville ([`38ffcc6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/38ffcc6b4c4f5557d2292f6735cfce3dbdf2e50d)) 🔏

### 🔊 Others

  * 🔐(rey/keys): Add key for wireguard k8s by Romain Deville ([`f3293e1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f3293e19b9fcadf27c5f8c6dba25d326729c3eea)) 🔏
  * 🔐(common_secrets): Update and k8s token secrets for all clusters by Romain Deville ([`0a1ab3d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0a1ab3d3142bf426d992e1fb128c37146b8f043c)) 🔏
  * 🔨(script): Improve deploy to stop if os build failed by Romain Deville ([`1e01c1d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1e01c1d15ae51dfe1082accf3dcd235dcfb84797)) 🔏
  * 🔨(scripts): Add new simple script to generate SSH and WG keys by Romain Deville ([`c1ec421`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c1ec421e1d2bbbadf64140c226412d3e0b3687d7)) 🔏

## v0.22.0 (2025-07-06)

### ✨ Minor

  * ✨ Add k8s (dev &amp; stg) VMs and deploy firewall on kenobi (!63) by Romain Deville ([`3450761`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3450761f4e358c3901f37071fd020b4a2c2a0ffe))
  * ✨(kenobi): Add basic VMs for k8s stg and minor fixes by Romain Deville ([`4a64b56`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4a64b56f67a7224296d748d5d0e9d37649692045)) 🔏
  * ✨(rey): Add basic VM for k8s dev cluster by Romain Deville ([`de219f8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/de219f89cedad5c006a84cf262f1f8d1f48f4d87)) 🔏

### 🩹 Patch

  * ⚡️(kenobi): Add firewall rules and update DNS by Romain Deville ([`885ad8f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/885ad8f57b5e7c2d727dd8dde3f36263d50e5717)) 🔏
  * ➕(flake): Add microvm to flake.nix and update flake.lock by Romain Deville ([`1b9d89d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1b9d89db29824af77c3742d0ddefd6aa39d89d7a)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`bc0f771`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bc0f7711173c11f9e3bd996dc8f97d9ca7e73293)) 🔏
  * 🔧(nixos): Add microvm and microvm-stable in NixOS Config by Romain Deville ([`c7d1345`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c7d134507c586cb3f6589d0d16034e0a1eaa083b)) 🔏
  * 🔧(templates/server): Update path to age key by Romain Deville ([`ca53514`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ca53514ac7c4b749cc6a71d42e4e01fe22e7379c)) 🔏

### 🔊 Others

  * 🔨(scripts): Improve deploy script by Romain Deville ([`3777765`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/377776545779bf28d9c40867fce6225bc42f93ba)) 🔏
  * 🚚(rey): Rework networks into dedicated folder by Romain Deville ([`87c2f8d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/87c2f8de0f8fa873c264d340dbdc72e0b6775977)) 🔏
  * 🚚(machines): Rename folder without underscore, create users folder by Romain Deville ([`0d60f4a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0d60f4a2c488cdc092b1ca1981c3acf175a311ab)) 🔏

## v0.21.0 (2025-07-01)

### ✨ Minor

  * ✨(os): Now able to deploy production server using nixpkgs stable (!62) by Romain Deville ([`f853462`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f853462233d4893ff4a21e9a3bccc6549505ac23))
  * ✨(nixos): Add support for prod server using nixpkgs stable by Romain Deville ([`362ec36`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/362ec36b1570470e6e6067db8a35c2830623a76e)) 🔏

### 🩹 Patch

  * ➕(flake): Add input nixpkgs-stable by Romain Deville ([`fb4c6d3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fb4c6d37b83819ca6eb99df00a60fba80b6147cd)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`399f727`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/399f727f926e5e5a8e15fb9c88ea236ff765009e)) 🔏
  * 🔧(kenobi): Fix kenobi k8s network and deploy prod using nixpgs-stable by Romain Deville ([`e9bde0a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e9bde0a8b6a91b6198195ada11774447ce38450c)) 🔏

### 🔊 Others

  * 🔨(scripts): Improve deploy script to ping target first by Romain Deville ([`7fa6fe1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7fa6fe13910983088d99c24ddb801b1f7ab83fe6)) 🔏
  * 🔨(scripts): Add nixos-stable to local_inputs script by Romain Deville ([`f3f68ab`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f3f68ab70ea8be53ad78b8bdf8a7e4dabd0601b0)) 🔏

## v0.20.0 (2025-07-01)

### ✨ Minor

  * ✨ Add DNS to Kenobi, fix networks for some machines (!61) by Romain Deville ([`6ec6fd6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6ec6fd6aa490631cb9d66e66bb207975f64387a8))
  * ✨(kenobi/dns): Setup and enable dns server configuration by Romain Deville ([`75f061c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/75f061c973f2a1ee5ed3a706980f13ce9871395c)) 🔏

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`b606eb7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b606eb754f65fd6b94304304225b319ae138690c)) 🔏
  * 🔧(darth-maul): Remove hardcoded kenobi in /etc/hosts by Romain Deville ([`e4c9c7b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e4c9c7b12a3afe40023382092bd24fc3e13c0c95)) 🔏
  * 🔧(rey): Remove useless code, fix network and dns config by Romain Deville ([`517a4b6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/517a4b6f12bb2b4d97deea8abe6ec40e42e79903)) 🔏
  * 🔧(kenobi/net): Fix some network config, add dns specific for wg network by Romain Deville ([`e2a9c0e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e2a9c0e87c07b6ed0cc15bc795bc2789641359b2)) 🔏
  * 🔧(templates/users): Update users SSH config to use tekunix.private by Romain Deville ([`67c8a53`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/67c8a537b9d5b22dd2eb816e23fa2a8a17ef0041)) 🔏
  * 🔧(templates/server): Disable IPv6 and update nameservers by Romain Deville ([`764928e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/764928ee9c1e8b19a3f6f2cbcfcb2297cdfcc7d4)) 🔏

### 🔊 Others

  * 🔨(scripts/ci): Update domain use by script deploy by Romain Deville ([`037c640`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/037c640394539456a1d544d17f6721c01370df1a)) 🔏

## v0.19.2 (2025-06-29)

### 🩹 Patch

  * 🍱(diagrams): Add first version of d2 diagrams for homelab networks (!60) by Romain Deville ([`342078e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/342078e75d27179b348d589eab892346bd5f3fec))
  * 🍱(diagrams): Add first version of d2 diagrams for homelab network by Romain Deville ([`fbf21d0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fbf21d0139482bf576c1a2c1d3834f33be8441ab)) 🔏

### 🔊 Others

  * 🔨(devbox): Add d2 package to devbox config by Romain Deville ([`4b03210`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4b032109228d042235cf4e91defe2e03a158bdf7)) 🔏

## v0.19.1 (2025-06-29)

### 🩹 Patch

  * ⬆️ Update flake.lock (!59) by Romain Deville ([`9fbd8cf`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9fbd8cfa1ac4fd01941e365ec1db06692a8de358))
  * ⬆️ Update flake.lock by Romain Deville ([`edf2765`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/edf2765688688e21fbfc3d37339afb66e35b6788)) 🔏

## v0.19.0 (2025-06-29)

### ✨ Minor

  * ✨ Improve Kenobi router config, setup Rey to use Kenobi networks (!58) by Romain Deville ([`1fde8c0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1fde8c0fa44f94838003280218a692f4b062c08c))
  * ✨(rey/net): Add wireguard private and public network configuration by Romain Deville ([`a376c56`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a376c56bd54b13c3a0a1bb8dfde7219b730813e5)) 🔏
  * ✨(kenobi/net/wg-public): Update wg-public configuration by Romain Deville ([`8ad4a7d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8ad4a7d8285cd7d661da54cff83077f04352399f)) 🔏

### 🩹 Patch

  * ⚡️(kenobi/net/tun-illyse): Set interface required for wait-online by Romain Deville ([`35aa88b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/35aa88bc80a44f7b976dc506c6d7284c6b145708)) 🔏
  * ⚡️(kenobi/net/wan): Specify wan as interface required for wait-online by Romain Deville ([`9a4e4cb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9a4e4cb76caa2d24f9b5b15414d6f25f1462eaab)) 🔏
  * ⚡️(lib): Add listSymlinks method to libs by Romain Deville ([`23876df`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/23876df2460a702fdf0e132d58b7000c7db0e401)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`15e3b7e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/15e3b7e78d3b736b4a3b0a7f1d1cc755e3ca00c9)) 🔏
  * 🍱(assets): Add assets used for topology graphic by Romain Deville ([`a96842e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a96842ead92fb7bdd321e7de5bd95a716849193f)) 🔏
  * 🐛(_templates/server): Add new sudo cmd authorized for azathoth without password by Romain Deville ([`8bdd687`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8bdd68794a1522073d2d041cd7085b3a7cb8a0c0)) 🔏
  * 👽️(script/ci): Update option for nixos-rebuild target-host in deploy.sh by Romain Deville ([`1fa3d73`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1fa3d73517d048abe49e8e5d43c3ee964e7df12d)) 🔏
  * 🔧(topology): Update main topology representation by Romain Deville ([`6dc2bce`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6dc2bce43d09324235f0ebf7a3117857b39fa1e8)) 🔏
  * 🔧(kenobi/net/eth-k8s-stg): Update network configuration by Romain Deville ([`78dc827`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/78dc827db16096bf3636777a3b73fcc30ea419e0)) 🔏
  * 🔧(kenobi/net/eth-k8s-prd): Update network configuration by Romain Deville ([`cdebc2e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/cdebc2ee821df86c6b46eece7aa75411fe1d3531)) 🔏
  * 🔧(kenobi/net/wg-private): Update network configuration by Romain Deville ([`75a8e40`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/75a8e402a457dd12303f6d2465f1fdd957d47e7d)) 🔏
  * 🔧(kenobi/net/wl-public): Make network not needed for wait-online by Romain Deville ([`baf1bd6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/baf1bd655460055390112a5cbe84b12e38804a9e)) 🔏
  * 🔧(kenobi/net/eth-public): Update network configuration by Romain Deville ([`61f3b28`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/61f3b288edc0bb5d03da0f639c6ca7fb4a530608)) 🔏
  * 🔧(_templates/user/rdeville): Add network monitoring tools by Romain Deville ([`923bbb5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/923bbb58ad25efd47611d1f7ae0e95a487eb4401)) 🔏

### 🔊 Others

  * 🔥 Remove references to dotgit-sync by Romain Deville ([`935076f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/935076fc9e56aeac678f8428bee3d5224d805b1c)) 🔏
  * 🚚(rey): Move kenobi wg-public related keys to be more coherent by Romain Deville ([`691f75d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/691f75d2a8b18739d999746d08c3281697c67405)) 🔏

## v0.18.0 (2025-06-19)

### ✨ Minor

  * ✨(kenobi): Refacto networking config and add wireguard servers (!57) by Romain Deville ([`596e198`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/596e1985508beff79cf4e2f78c7e583238cc93bd))
  * ✨(kenobi/net): Update list of net to deploy by Romain Deville ([`fc40452`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fc40452dda5f7adabfed95bf8c0cd8c404c60ea8)) 🔏
  * ✨(kenobi/net): Add wireguard private server configuration by Romain Deville ([`f49df09`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f49df09b7b118c32c550277387171be825d9c32c)) 🔏
  * ✨(kenobi/wg-public): Add public wireguard server and config by Romain Deville ([`8ea33b6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8ea33b63e86a89d375afaa4bed213f4137ec6dc9)) 🔏
  * ✨(kenobi/net/k8s-prd): Move net from interfaces to service.network by Romain Deville ([`334bd57`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/334bd5741c0957c0034893b45a8446517d4b3f84)) 🔏
  * ✨(kenobi/net/k8s-stg): Move net from interfaces to service.network by Romain Deville ([`418f39c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/418f39c67a2bcb4fb5177e90fdc1b9c27dc2d249)) 🔏

### 🩹 Patch

  * ⚡️(kenobi/net/wl-public): Move net from interfaces to systemd.network by Romain Deville ([`2018910`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2018910b47ad01397712be96098ad59fb2980572)) 🔏
  * ⚡️(kenobi/net/eth-public): Move net from interfaces to systemd.network by Romain Deville ([`1734955`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/17349550c1063cbf243f7f2a5a4fff96af7da786)) 🔏
  * ⚡️(kenobi/net/wan): Move wan from networking to systemd.network by Romain Deville ([`114238e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/114238ecf47b5405d94219daee4bc575a8d75afa)) 🔏
  * ➖(flake): Remove hyprswitch from flake.nix and add ls-colors by Romain Deville ([`7944c15`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7944c1531bb946ffb5dbf728c356135435853934)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`5562d2f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5562d2f7f059780029359950e9ce551e127968bd)) 🔏
  * 🔧(kenobi): Fix nftables to allow some traffic through tun-illyse by Romain Deville ([`e19a44c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e19a44c0d3121483e0b2980a67839262f3570fd1)) 🔏
  * 🔧(pre-commit): Add validate-sops pre-commit by Romain Deville ([`fe52484`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fe52484fede909701dcdef053350459e8c49d90b)) 🔏

### 🔊 Others

  * ♻️(kenobi): Move wan network to its dedicated folder by Romain Deville ([`5a34a15`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5a34a1529043094a6127640df2c2bf254b6ad9a3)) 🔏
  * 🎨(kenobi/dns): Format DNS entry for tekunix.cloud by Romain Deville ([`345d2a9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/345d2a90314a42e78b96f19ec64aafe7d964eceb)) 🔏
  * 💡(kenobi): Remove useless comment by Romain Deville ([`6725ec0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6725ec05084f4bfda786f4c632824b5252f94897)) 🔏
  * 🔐(rey/rdeville): Add wg private key for wg-public by Romain Deville ([`71d1bdc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/71d1bdc64b08400e2f3453651844af191412eff1)) 🔏

## v0.17.0 (2025-05-28)

### ✨ Minor

  * ✨(machines/kenobi): Add Illyse OpenVPN config &amp; hardening firewall (!56) by Romain Deville ([`4c67e34`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4c67e345fc2dcbbad33eb63e3d795bfc47f2fa30))
  * ✨(machine/kenobi): Add Illyse OpenVPN configuration by Romain Deville ([`7513187`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/75131870e4fff565271605d138cd520f8d7cead0)) 🔏

### 🩹 Patch

  * 🔒️(machines/kenobi): Hardening access with Firewall activation by Romain Deville ([`4a4b7b1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4a4b7b115443bc7c9a7660e144d22b92b686fa5b)) 🔏

## v0.16.0 (2025-05-26)

### ✨ Minor

  * ✨(os): Setup basic kenobi nftables config and minor updates (!55) by Romain Deville ([`07f5b47`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/07f5b475fd9df4924a34cebd5907b6eb6384067b))
  * ✨(machines/kenobi): Update kenobi router configuration by Romain Deville ([`0e0535e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0e0535ee0f18334cb539171de013b6a60ce210e5)) 🔏

### 🩹 Patch

  * ⚡️(machines/rey): Fix network and hyprland monitor resolution by Romain Deville ([`f4950b7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f4950b737fd0aaed84adeb7ac28f329ad39e61d3)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`a17dcc7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a17dcc7877cad93b2d932f0baa1349ff207c5eb6)) 🔏
  * 🔧(machines/_templates): Update template for rdeville and azathoth by Romain Deville ([`bacf7b9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bacf7b9c79d3b56a492dcd594b89a08902fd9a23)) 🔏
  * 🔧(machines/darth-maul): Add temporary route to kenobi by Romain Deville ([`be5832b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/be5832b0939623de5fbe799d48015acba1f2b4b3)) 🔏

## v0.15.0 (2025-05-21)

### ✨ Minor

  * ✨(machines): Add new users, generate users keys and reencrytp all by Romain Deville ([`8a80663`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8a80663068c274c1020c729e39ad7d1ae64325c3)) 🔏
  * ✨(scripts/ci): Add script do ease deployment of NixOS upgrade by Romain Deville ([`4b94265`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4b9426599797ce0f29b2d80d70cf6d6a745ea01a)) 🔏
  * ✨(scripts/ci): Add script to verify target and repo keys by Romain Deville ([`1a66a05`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1a66a0596bfd93b835328541676d59720438f40a)) 🔏
  * ✨(scripts/ci): Add install.sh script to ease installation of new machine by Romain Deville ([`3f207d9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3f207d99b39eeda6ed0edb8bfffbfe0e189d4626)) 🔏

### 🩹 Patch

  * ⚡️ Prepare bulk management with scripts &amp; new users (!54) by Romain Deville ([`a8d6696`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a8d6696fc43e738975032ea2567f033974397b79))
  * ⚡️(machines/_templates): Update users SSH configuration by Romain Deville ([`12ba2ed`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/12ba2edae79e767d56bc6a38e4481c77c6d1a780)) 🔏
  * ⚡️(lib): Add getValidHosts function to return list of host with default.nix by Romain Deville ([`797db9c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/797db9ce5a1c0a08d71685ce160f3610760932b2)) 🔏
  * ⚡️(scripts): Improve script CI generate_keys by Romain Deville ([`e6ecb01`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e6ecb01cf0b98e61037b668acbfb8aaa116b1c28)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`853c7a0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/853c7a09920a8d15cea22ff681d1418ba44dedc2)) 🔏
  * 🐛(hm/assets/scripts): Fix kp script if log folder does not exists by Romain Deville ([`32abf77`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/32abf77a706aa8e695a2f508fd59105b471462e8)) 🔏
  * 🔧(sops): Update .sops.yaml with new kenobi rdeville age key by Romain Deville ([`93714b2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/93714b2facac6155cfdded75d03bd9bda682c188)) 🔏

### 🔊 Others

  * ♻️(os): Set Home-Manager users in NixOS using os.users.users by Romain Deville ([`191d8e2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/191d8e276524bfc8c6908a4e395881021dffde40)) 🔏
  * 🔐 Reencrypt all secret by Romain Deville ([`3c18577`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3c185775c454c68b71c51354848746c547e6b467)) 🔏
  * 🔐(machines/darth-maul): Fix SSH key files with script generate_key by Romain Deville ([`10fee16`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/10fee16cccda7c016be12041488a7e6f7b3222e2)) 🔏
  * 🔐(machines/rey): Add rey disk encryption keyfile with encrypted password by Romain Deville ([`b3efb8d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b3efb8d1a278415aa8c9be6d3316bedacb785d6d)) 🔏
  * 🔥(machines/kenobi): Remove useless code for kenobi and set basic config by Romain Deville ([`792e5f5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/792e5f5758f57067d9762591ef1eb0cb01c591a3)) 🔏
  * 🔨 Update script deploy by Romain Deville ([`e4dd014`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e4dd014594bb16236443ac5eecac1f9c43ffd458)) 🔏
  * 🔨(scripts/ci): Add CI script to build all buildable configuration by Romain Deville ([`fc74cf9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fc74cf9baf121a6791c3de49e91dfcd34d27dc52)) 🔏

## v0.14.1 (2025-05-17)

### 🩹 Patch

  * ⚡️(scripts): Update script related to keys and secrets by Romain Deville ([`a431d9a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a431d9ab2b9c4f7ee7c831be645693c6c024cf77)) 🔏
  * ⚡️(hm/assets/scripts): Update where kp script logs its output by Romain Deville ([`37c908b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/37c908b213d634a27772f5f886609ea8bb98016c)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`6a5b37e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6a5b37eec791faaa83971104f6b970ee60e59fef)) 🔏
  * 🔧(sops): Update .sops.yaml with new keys by Romain Deville ([`9e9842c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9e9842c62d05180672e9ac07e5cdc9de2ad397f5)) 🔏

### 🔊 Others

  * 🔐 Update secret related scripts and regenerate only required keys (!53) by Romain Deville ([`f8e0fb6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f8e0fb675dd011f47473c3b48ddca2ef2cb4e227))
  * 🔐(common_secrets): Rotate common secrets encryption by Romain Deville ([`515e151`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/515e151ef93ad054e1c9d13a744ac5d891da56da)) 🔏
  * 🔐(hm/accounts): Rotate account encrypted credentials files by Romain Deville ([`a7ae516`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a7ae516e8d9964e865b349779eecb73170988b87)) 🔏
  * 🔐(machines): Remove useless keys, regenerate other ones by Romain Deville ([`f161112`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f16111265347425706aae16a5690a0bea51ea581)) 🔏

## v0.14.0 (2025-05-14)

### ✨ Minor

  * ✨ Huge refacto of machines with templates and tools update (!52) by Romain Deville ([`f57124d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f57124d402a7e026404678431d546c990164434c))
  * ✨(machines/kenobi): Add kenobi routeur configuration by Romain Deville ([`ef4fde3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ef4fde327693ea4735cebf11c8e3d57c851d9c6e)) 🔏
  * ✨(machines/nixos-live): Rename usb-amd64 to nixos-live and nixos-live-gui by Romain Deville ([`8ec6b49`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8ec6b4920f9e256619e89e19e8a9d7fef8fb74f4)) 🔏
  * ✨(machines/luke): Add new luke machine configuration by Romain Deville ([`8a63beb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8a63beb243ba88ba00eb1467264d34136b770e0f)) 🔏
  * ✨(machines/leia): Add leia configurations by Romain Deville ([`81f7d1e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/81f7d1e03ea5f361f2005a97dc8912d4efc2a40f)) 🔏
  * ✨(doc): Add topology.nix to describe not NixOS topology of my infra by Romain Deville ([`4dd4d82`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4dd4d826e5439baa1644d5f37bdd1d5813c59458)) 🔏

### 🩹 Patch

  * ⚡️(machines/_templates): Add OS and HM users templates by Romain Deville ([`b84be2f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b84be2fd860eb30c0a480b55de160c1a4a4f5544)) 🔏
  * ⚡️(hm): Make home-manager.nix ignore _.* folders by Romain Deville ([`b6b11c8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b6b11c8882f86fe30bff33ce854fe5fd2e6abbce)) 🔏
  * ⚡️(hm): Improve Home-Manager module configuration by Romain Deville ([`24e121c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/24e121c22093b545e2af711bff69e535db836aed)) 🔏
  * ⚡️(os): Make nixos.nix and nixos/default.nix ignore _.* folders by Romain Deville ([`6943c7d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6943c7d535d03b3ab17e95aeb451a35a9da3414a)) 🔏
  * ⚡️(os): Update NixOS Module configuration by Romain Deville ([`b610552`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b610552618bc195c1225926ee5ae47546e268e1b)) 🔏
  * ⚡️(flake): Add topology output to flake to render infra representation by Romain Deville ([`e420c87`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e420c878609eedf7ffef5b66fc0478e3c27fc4e3)) 🔏
  * ⚡️(devbox): Set devbox.json to use my public os flake by Romain Deville ([`c4d55d7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c4d55d704f00c0e622e40e91077613d9af632a72)) 🔏
  * ⬆️ Upgrade devbox.lock by Romain Deville ([`f0dd105`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f0dd105d4d7f604dc0737dd212e307c09c285a2f)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`aeb433b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/aeb433bac8b9393f862df9a208db9934c8fa7a2f)) 🔏
  * 🐛(hm): Fix system if host is palpatine by Romain Deville ([`50ed2a7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/50ed2a73e5f63c9d9ee6a5e454d7a76158b71adc)) 🔏
  * 🔧(accounts): Add romain.deville@dougs.fr account by Romain Deville ([`e6c4ec8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e6c4ec830a259fb2e3784c0d8d010d5524bde1e2)) 🔏

### 🔊 Others

  * ♻️(machines/rey): Refacto machines using templates by Romain Deville ([`ad12f00`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ad12f00ef54130ae29d8610b1a87282aa614a75e)) 🔏
  * ♻️(machines/palpatine): Refacto FBLP-181 into palpatine and use templates by Romain Deville ([`d3e8b67`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d3e8b67b5f533b966f8b448f6c35b2d9c73b8a3d)) 🔏
  * ♻️(machines/darth-vader): Refacto to use templates by Romain Deville ([`8d6898a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8d6898aadcd729af703433c1eccea41771640606)) 🔏
  * ♻️(machines/darth-plagueis): Refacto to use templates by Romain Deville ([`344c56d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/344c56dc39089f96c019a1e8bfa81cac8b402128)) 🔏
  * ♻️(machines/darth-maul): Refacto to use templates by Romain Deville ([`5631356`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/56313568d86122d9c33086bd726a5f41e6dee14e)) 🔏
  * 🎨(overlays): Format files in overlays by Romain Deville ([`775cf5d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/775cf5d4e5986dd1fa654cb6e864c79bde77677c)) 🔏
  * 🎨 Format ./home-manager.nix by Romain Deville ([`1f0ee90`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1f0ee901a89c8be4348092f0ced56ff2cea7d55b)) 🔏
  * 🔐(common_secrets): Add k3s related secrets by Romain Deville ([`1e5c2f2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1e5c2f2d5f7f5bf5bbca0fcb5dcc0e73572c92cc)) 🔏
  * 🔐(sops): Update .sops.yaml config by Romain Deville ([`9123ffd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9123ffd5d0af32ab58be0ab3d041e1142026915a)) 🔏
  * 🔥(machines/palpatine): Remove useless files by Romain Deville ([`7c39c51`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7c39c510921e7317b0a355e92896119825e7df51)) 🔏
  * 🔥(machines): Remove useless machines/base.nix by Romain Deville ([`4267905`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4267905aeac5c8684e20ca9660af32392427e7ee)) 🔏
  * 🔥(machines): Remove dev machines since I don&#39;t use it by Romain Deville ([`1975f9f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1975f9f8d641b792763040ce7d40497d7ba3150d)) 🔏
  * 🔥(machines): Remove luke machines since its not deployed by Romain Deville ([`a58e25d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a58e25d5663c65a3f8a66e8b49ddc28d1ad62282)) 🔏
  * 🔨(scripts): Improve scripts and add new ones by Romain Deville ([`0208b9a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0208b9ac451eec4fb8344810a06d8355b814f873)) 🔏
  * 🚚(accounts): Move accounts to home-manager by Romain Deville ([`1027aee`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1027aee6231f6aaf07b125bc9c7db95b7df7a29a)) 🔏
  * 🚚(assets): Move assets to HM assets folder by Romain Deville ([`c923949`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c9239493a753ef0502ddbc619d848807179416f2)) 🔏

## v0.13.1 (2025-04-02)

### 🩹 Patch

  * ⚡️(hm/assets): Improve script dgs_commit (!51) by Romain Deville ([`ac33a4e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ac33a4e39e30d80f489cccdbeb6fe23639bd58e9))
  * ⚡️(hm/assets): Improve script dgs_commit by Romain Deville ([`225c9e8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/225c9e8f27ab40ec5c335e4642fcbf043c18cc62)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`6842ab3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6842ab3f11b58bdcf1b9c3fd72ecc17674a66904)) 🔏
  * 🔧(flake): Update tmuxdata url to git URL instead of local path by Romain Deville ([`413356e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/413356eea0f678c66c96c5c628e79e71c9d3fccf)) 🔏

## v0.13.0 (2025-03-24)

### ✨ Minor

  * ✨(hm): Update tmuxrc with new pkg and add tmux-data by Romain Deville ([`c7eaa6b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c7eaa6b3269081374f8ef306904a4045287aa7a1)) 🔏
  * ✨(os): Add overlays management for OS and HM management by Romain Deville ([`8424279`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8424279f79b02a97b2b02f7716e1e3a86bf201e8)) 🔏
  * ✨(overlays): Add dynamic overlays management based on inputs name by Romain Deville ([`25ce9f8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/25ce9f8acc3ddf747f078818acaf82eaad73cd14)) 🔏

### 🩹 Patch

  * ⚡️(hm/assets): Add ginit script to initialize git repos by Romain Deville ([`cc6bfb2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/cc6bfb288c97c30cef1e6e3f29ca07ccd547faff)) 🔏
  * ⚡️(hm/assets): Improve dgs_commit script by Romain Deville ([`be98912`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/be9891296848b33fb8c98fd2d3d8ef0a7b65f66e)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`426dfb2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/426dfb2660a5590220a6db3022c252370c269157)) 🔏
  * 🐛(hm): Fix missing lib in HM specialArgs by Romain Deville ([`872cfc3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/872cfc33ae6bef31ba5df07d0cefd313a45b1605)) 🔏
  * 🔧 Mainly update darth-maul config for docker and k3s (!50) by Romain Deville ([`46881b7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/46881b78995c63e72b5562c21fa4f118e305716b))
  * 🔧(machines/darth-maul): Update machine configuration by Romain Deville ([`ac90e57`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ac90e572f124dbf31d242e2e4c9f4151ef6bb339)) 🔏
  * 🔧 Update pre-commit from DGS template by Romain Deville ([`68ac2a8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/68ac2a82a07f2bf3d8b2e80a7db928c0ceca7b34)) 🔏
  * 🔧 Add dotgit sync configuration by Romain Deville ([`6cb0d09`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6cb0d09dd130a9988e5e3666181fb53457828273)) 🔏

### 🔊 Others

  * 👷 Add Gitlab CI from DGS template by Romain Deville ([`be33af3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/be33af30992eda26e2c07ec03f74f82c1b6f6af2)) 🔏
  * 📝 Add COPYRIGHT from DGS template by Romain Deville ([`005136d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/005136d12fb6f4227c9fd1cc04e00320d3507fb7)) 🔏
  * 📝 Add CONTRIBUTING from DGS template by Romain Deville ([`2a4c3eb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2a4c3ebe10baaf6e0cabbfa816783a56aa169c13)) 🔏
  * 📝 Add CODE_OF_CONDUCT from DGS template by Romain Deville ([`491f132`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/491f1323373d65551b68debd623977b671139882)) 🔏
  * 📝 Update README from DGS template by Romain Deville ([`52632ea`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/52632eaf9f5edaa34d99e17fb413ea5bbfcffa70)) 🔏
  * 🔥 Remove licenses by Romain Deville ([`e32b71a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e32b71ab56b2ab99d642004adbc2d7b6eecb785c)) 🔏
  * 🔨(scripts): Update local inputs override scripts by Romain Deville ([`c1056d3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c1056d3806784f2fd206c077ef40002ba79f3e87)) 🔏
  * 🔨 Add .envrc from DGS template by Romain Deville ([`81b2992`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/81b29924a7aaec87a79cac9640c8c384f9681e2e)) 🔏
  * 🔨 Add devbox config from DGS template by Romain Deville ([`058f0f2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/058f0f2a6464bbf7edda684ee93e1b8f50247a7a)) 🔏

## v0.12.0 (2025-03-17)

### ✨ Minor

  * ✨ Add some overlays, update config and refactor methods (!49) by Romain Deville ([`59880cb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/59880cb3345052d7f37d1cc80cd137c85ea856a6))
  * ✨(os/overlays): Add OS overlays example by Romain Deville ([`61c04e1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/61c04e14b3cf85a38293203c4db887e93e5fccb1)) 🔏
  * ✨(hm/overlays): Add HM overlays by Romain Deville ([`c12b052`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c12b0528d4d737a013edd0afc9771268d2204adb)) 🔏

### 🩹 Patch

  * ➕(flake): Add overlay input by Romain Deville ([`ec2178c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ec2178c9de11622dea5f9749688af452ae5a956d)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`3be3127`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3be31270dd6ac44b06eedf858e2ed0f5900b21d5)) 🔏
  * 🔧(machines/darth-maul): Update config (DNS, partition, hyprland, k3s) by Romain Deville ([`524da24`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/524da2413dcd97ddd56b9603894afe7604834b94)) 🔏
  * 🔧(hm/assets): Add nixos tmuxp config, update dgs_commit scripts by Romain Deville ([`49dd0bf`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/49dd0bf4b3d07e82c5778b32435f3cecb76b29d0)) 🔏

### 🔊 Others

  * ♻️(hm): Refacto Home Manager entrypoint by Romain Deville ([`11380f2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/11380f23792bf558d048fb11ffc84ebb1c8dbf2b)) 🔏
  * ♻️(hm/ssh-client): Rework methods to be cleaner by Romain Deville ([`66e2771`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/66e2771ce91f7341cc39c1da7e70b1c66cf48202)) 🔏

## v0.11.1 (2025-03-03)

### 🩹 Patch

  * ⬆️ Update flake.lock (!48) by Romain Deville ([`02ad45a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/02ad45aa813c6b973282ad23aa69870c945f95b3))
  * ⬆️ Update flake.lock by Romain Deville ([`f79dbec`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f79dbec093945213b7d2a94aa30d9475cdeba671)) 🔏

## v0.11.0 (2025-02-27)

### ✨ Minor

  * ✨(os): Make /tmp cleaned on boot (!47) by Romain Deville ([`1a9c3df`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1a9c3df1f9358156be6c9468719c2c7448207c47))
  * ✨(os): Make /tmp cleaned on boot for all OS by Romain Deville ([`8b954b6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8b954b615b23e544540aa6a148868d65ecbb5fc6)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`51f9970`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/51f99706337b9ffb95e0798b0387dc65cf696ee1)) 🔏

## v0.10.1 (2025-02-23)

### 🩹 Patch

  * ⬆️(devbox): Update devbox.lock by Romain Deville ([`b9461a2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b9461a2a75fe46018e863e3862ce53e3e3f4d376)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`a6f97f8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a6f97f85dc7c3e5ce62a359ec546f4003e768501)) 🔏
  * 🔧 Update flavors used in config, remove zshrc from inputs (!46) by Romain Deville ([`592d1fb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/592d1fb9bc474fb2dbfdd33cd8a5798db65f2c9b))
  * 🔧(nixos/hm): Set useGlobalPkgs to false to let user set nixpkg config by Romain Deville ([`99ef4d1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/99ef4d16d3636a2d708be7ec30394f679230b54a)) 🔏
  * 🔧(machines/rey): Add latex and terragrunt HM flavors by Romain Deville ([`a02c68f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a02c68f63805f42552b47e62276572ae98ddd0c7)) 🔏
  * 🔧(machines/FBLP-181): Add terragrunt flavors by Romain Deville ([`e1f5e2a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e1f5e2afafd60d6c3593b9ea31b1722c933e8586)) 🔏
  * 🔧(machines/darth-maul): Update flavors used by Romain Deville ([`9b08007`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9b080073d5a1bbbeff3ea76ce074875883dd7295)) 🔏

### 🔊 Others

  * 🔥(flake): Remove zshrc from inputs by Romain Deville ([`57a9be2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/57a9be238dcf3e8e8e59bd96c662251ae5573a36)) 🔏
  * 🔥(scripts): Remove zshrc inputs from local_inputs by Romain Deville ([`f6a080e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f6a080ed77ecf4a2f7a1e7f47635d83b68df1f68)) 🔏
  * 🔥(hm): Remove use of my zshrc flake by Romain Deville ([`731dc9b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/731dc9be5c57f1f351d10d7d3a6f014753fcb7a1)) 🔏

## v0.10.0 (2025-02-20)

### ✨ Minor

  * ✨(machines): Add luke machines NixOS and HM Configurations by Romain Deville ([`b0b5080`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b0b5080b90996adcea7b28e53cefc64949a42a8a)) 🔏

### 🩹 Patch

  * ⚡️(hm/scripts): Add my auto-type script based on ydotool by Romain Deville ([`c9e0fd8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c9e0fd8f673a45ed99c9b02ffc9e764d7ee45957)) 🔏
  * ⚡️(os): Add use of facter for NixOS by Romain Deville ([`6d39eb8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6d39eb84d7e769610ec77893f29d9216c6b01696)) 🔏
  * ➕ Update flake.nix by Romain Deville ([`b16d267`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b16d267d5a80303a15463580447d171336a6e6fe)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2d21a39`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2d21a39925ec9a916c79bec460b594ebda6b8f80)) 🔏
  * 🔧 Mainly update darth-maul config and add luke config (!45) by Romain Deville ([`51e6b04`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/51e6b04a921a7e29c9f2d535724e5277f6d8a3cb))
  * 🔧(sops): Add luke machine with user to .sops.yaml by Romain Deville ([`634d851`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/634d85185265bdf7d0eb022f14caae0c490eae16)) 🔏
  * 🔧(machines/darth-maul): Update to use facter by Romain Deville ([`470bf37`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/470bf37fdea3c6aca6fc226398f21dea5e5bdaab)) 🔏
  * 🔧(machines/darth-maul): Add dconf and ydotool to OS configuration by Romain Deville ([`9a9246d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9a9246d53780f042ca5ef91cf328953520299170)) 🔏
  * 🔧(machines/darth-maul): Temporary deactivate wayland by Romain Deville ([`4b6eed1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4b6eed18603eaef53dae5902e521379e5d5b38fb)) 🔏
  * 🔧(machins/FBLP-181): Update kitty configuration for MacOS by Romain Deville ([`9b7f26f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9b7f26fbb5d83c705e9c1e3b6c4adc6a8060cb51)) 🔏

### 🔊 Others

  * 🔨(scripts): Fix dev scripts missing function and typos by Romain Deville ([`e67c345`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e67c345276fad635831a0f4fcc9181a1e1890a31)) 🔏
  * 🔨(devbox): Add devbox script that show available command wrapper by Romain Deville ([`77546c9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/77546c9eb1530c10e31e6183a6703e572686350c)) 🔏

## v0.9.3 (2025-02-11)

### 🩹 Patch

  * 🐛(machines/FBLP-181): Fix machines darwin support (!44) by Romain Deville ([`170ef59`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/170ef59b047f29873ccb1b082f4b7ef169797f07))
  * 🐛(machines/FBLP-181): Fix machines darwin support by Romain Deville ([`c606b7a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c606b7a1ac8214e7142c4f063cdb496c7f77f7c6)) 🔏

## v0.9.2 (2025-02-09)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`a996acb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a996acba27e88e59a66b7b2f2ecd39711cb34397)) 🔏

## v0.9.1 (2025-02-09)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`57cf4e7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/57cf4e74d526398035f956c40980dcbbac4b22c9)) 🔏
  * 🔧(machines): Enable terraform and switch to discord flavors (!43) by Romain Deville ([`5e40cfb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5e40cfbb3b5cadd0c3fdbe3b0727366cfdc15c98))
  * 🔧(machines/rey): Enable terraform and discord flavors by Romain Deville ([`c628698`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c628698924759fe9ccfe051d1c891f492508b3a4)) 🔏
  * 🔧(machines/darth-maul): Enable discord and terraform flavors by Romain Deville ([`9065f88`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9065f886c01038811e46bc993fa6ed923aae5401)) 🔏

## v0.9.0 (2025-02-08)

### ✨ Minor

  * ✨ Add new tooling scripts and refacto configuration folderk (!41) by Romain Deville ([`8cc8a70`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8cc8a709a5825d40fc5f7628759842c24f465e25))

### 🩹 Patch

  * ✏️(hm): Fix typo in home-manager.nix by Romain Deville ([`aa88d17`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/aa88d172fdcdc034ac5337b4743966bc4f951731)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2be3e2d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2be3e2d2d8502b980898d94d06fb566557138767)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`03d2b19`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/03d2b195df0125fe4b5cf92f1bef9d9850b510b1)) 🔏
  * 🍱(assets): Restore fastfetch logo by Romain Deville ([`b7e7de4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b7e7de4e62b4f29a7352bf65cb8573085db93483)) 🔏
  * 👽️(hosts): Update default git profiles due to new module structure by Romain Deville ([`5b09b89`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5b09b89023df867cfab0b57c0cc4ca844981bf03)) 🔏
  * 👽️(hosts/palpatine): Update git commented profiles due to new module structure by Romain Deville ([`bc166a6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bc166a605ad4561de2924d3311d0f792c168d4bd)) 🔏
  * 🔧 Update hosts config and scripts management (!42) by Romain Deville ([`cfbb836`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/cfbb836ee725f22c3f83695b0d3307a8d2635a9d))
  * 🔧(accounts): Deactivate khal since build fail by Romain Deville ([`3a7cdaa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3a7cdaab628052216173bc483126cef3cb8b6472)) 🔏
  * 🔧(machines): Upgrade all machines to new config, now able to build all by Romain Deville ([`89910ad`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/89910adbdd2c175fa488c1632e84c8f7d0b027d3)) 🔏
  * 🔧(darth-maul/rdeville): Add luarocks and go pkgs by Romain Deville ([`0330fbe`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0330fbe2c40bf9e023b38b02e246c5703f642047)) 🔏
  * 🔧(hm/darth-maul/rdeville): Deactivate hyprspace &amp; hyprexpo since unable to build by Romain Deville ([`d1c1691`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d1c16913ef3b3c8657d181e0542e1e15a0b38a76)) 🔏
  * 🔧(host/darth-maul): Remove useless comment by Romain Deville ([`f397913`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f3979131be3854c14f3de947145720a9ed9b6e7b)) 🔏

### 🔊 Others

  * ♻️ Update imports path due to new structure by Romain Deville ([`8e5efba`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8e5efbadf20bd123270c891afb0aadc0b54c111a)) 🔏
  * 🔥 Remove useless code and useless flakes inputs by Romain Deville ([`4e4e8c8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4e4e8c8ad6f8bf278727214d3a12eb0f0d327a9b)) 🔏
  * 🔥(pubkeys): Remove now useless old public keys by Romain Deville ([`74662c4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/74662c45325d01a8a2289cf714a97253daf603ab)) 🔏
  * 🔨(devbox): Drop devenv support to only use devbox with local scripts by Romain Deville ([`15ca325`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/15ca3253dbd286e4e7330379abf39f8bcf36bfe8)) 🔏
  * 🔨(scripts): Remove script now in my nixos flake and package them by Romain Deville ([`7be20e7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7be20e799dae9a9e0e9b9b1ea748d1d6a3893637)) 🔏
  * 🔨(devenv): Integrate new scripts to devenv by Romain Deville ([`9aa6d29`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9aa6d29288417c5b401a2f0164793b8c77602e60)) 🔏
  * 🔨(scripts): Refacto and normalize scripts with a &#34;fake&#34; CLI by Romain Deville ([`95e079a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/95e079a108bba3599fce8dde8e0e3c65df60aa35)) 🔏
  * 🚚(assets): Flatten configs/assets to assets by Romain Deville ([`3028254`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3028254d2b5ef24c7d35d6e1fba68aa043e7b2c8)) 🔏
  * 🚚(accounts): Flatten configs/accounts to accounts by Romain Deville ([`feea41b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/feea41b56348d0f3ff9c48de0d33f349252123ea)) 🔏
  * 🚚(hosts): Move configs/hosts to machines to flatten structure by Romain Deville ([`bf58f63`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bf58f63caf9a2f93cc0fd2661076df7fd15530ba)) 🔏

## v0.8.0 (2025-01-24)

### ✨ Minor

  * ✨ Add hyprland module to darth-maul and dev machine (!40) by Romain Deville ([`16f9947`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/16f994720660ce5f1014da67048c68000f342a93))

### 🩹 Patch

  * ⚡️(scripts): Improve scripts behaviour and logging by Romain Deville ([`2083be3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2083be30153e627734e811790c5551497fb182b5)) 🔏
  * ➕ Update flake.nix by Romain Deville ([`99c2533`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/99c253324e9d70a43b659e602a501adf88dc15a4)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`ce3db4d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ce3db4da0bcac550b646b7f4ea1887b7e3d02ca6)) 🔏
  * 🐛(cfg/hosts/darth-maul): Use nvidia stable instead of latest by Romain Deville ([`74a2d19`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/74a2d19b4407b064a6e88eb5b7ef2807d800e12c)) 🔏
  * 🔧(cfg/hosts/darth-maul): Deactivate discord autoupdate with config by Romain Deville ([`ced89e8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ced89e8fcd11016334cc10112a7729aca0c66c28)) 🔏
  * 🔧(sops): Add dev machine with user to .sops.yaml by Romain Deville ([`b662cd0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b662cd0d1440e5b49d1dde9c946cb8567d3505b5)) 🔏
  * 🔧(cfg/host/usb-amd64): Update OS usb-amd64 config by Romain Deville ([`e464831`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e46483154b8648f7453ccdf9d4b53dc36e9a45ce)) 🔏
  * 🔧(cfg/host/dev): Update OS dev config by Romain Deville ([`894e717`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/894e71757082f57d1758347e054692a7a4260a0d)) 🔏
  * 🔧(cfg/host/dev): Update HM dev:root config by Romain Deville ([`2e1342d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2e1342d8b0c1ec3d3b58d3d668175d5a1a5f8d4d)) 🔏
  * 🔧(cfg/host/dev): Update HM dev:nixos config by Romain Deville ([`d26f846`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d26f8468eb14bc8cdc242accc4e5c95862363041)) 🔏
  * 🔧(cfg/host/darth-maul): Update OS darth-maul config by Romain Deville ([`e3713af`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e3713afbb258925641572bf088c5e8c38f61096a)) 🔏
  * 🔧(cfg/host/darth-maul): Update HM darth-maul:root config by Romain Deville ([`7a84702`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7a847028794002fb52fbe69a8de12c5d733ab17f)) 🔏
  * 🔧(cfg/host/darth-maul): Update HM darth-maul:rdeville config by Romain Deville ([`0574a08`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0574a0829e1a4a564717169a8bd50a442f37f594)) 🔏

### 🔊 Others

  * ♻️ Refacto way HM modules are managed with nixosConfiguration by Romain Deville ([`482431d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/482431d75699afdc09715041cb45c24d63816433)) 🔏
  * 🔐(common): Rotate spotify.enc.yaml by Romain Deville ([`15cc6dc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/15cc6dc89a9c2be318661b6277a5cb0c8178593b)) 🔏
  * 🔐(cfg/host/usb-amd64): Update OS age &amp; ssh usb-amd64 key by Romain Deville ([`8139373`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/813937301a901998d3949735b5d33bcad93ced26)) 🔏
  * 🔐(cfg/host/usb-amd64): Update HM age &amp; ssh usb-amd64:root key by Romain Deville ([`4c423de`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4c423de90b589dca34d1323cbc9999adcf76d809)) 🔏
  * 🔐(cfg/host/usb-amd64): Update HM age &amp; ssh usb-amd64:nixos key by Romain Deville ([`362eebd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/362eebd67a60a4acef2a6aa6070087721dfcb1ea)) 🔏
  * 🔐(cfg/host/rey): Update OS rey secret by Romain Deville ([`c0b3fc0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c0b3fc08f47a448f0a91dc601c707e795e1de46f)) 🔏
  * 🔐(cfg/host/rey): Update OS age &amp; ssh rey key by Romain Deville ([`f0a070c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f0a070ca1f11f180ae16da4edf1a82a03b70e942)) 🔏
  * 🔐(cfg/host/rey): Update HM age &amp; ssh rey:root key by Romain Deville ([`88359a3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/88359a3ad04b0029553945265d2ecac78bbe8e0d)) 🔏
  * 🔐(cfg/host/rey): Update HM age &amp; ssh rey:rdeville key by Romain Deville ([`97646a9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/97646a9bec173b31274efdb7ed33ac982c95e303)) 🔏
  * 🔐(cfg/host/palpatine): Update OS age &amp; ssh palpatine key by Romain Deville ([`8ba21a1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8ba21a19470d0438405121ac2c22043cfb8f2e14)) 🔏
  * 🔐(cfg/host/palpatine): Update HM age &amp; ssh palpatine:romaindeville key by Romain Deville ([`f065b89`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f065b8999b1154c10804e115e66589fc9e91a9ee)) 🔏
  * 🔐(cfg/host/FBLP-181): Update OS age &amp; ssh FBLP-181 key by Romain Deville ([`854b047`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/854b047e5af10677a455e6644550ccf36c2df00f)) 🔏
  * 🔐(cfg/host/FBLP-181): Update HM age &amp; ssh FBLP-181:romaindeville key by Romain Deville ([`ba630fa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ba630faf7d6a205cdf29bb12beac096465e64a55)) 🔏
  * 🔐(cfg/host/dev): Update OS age &amp; ssh dev key by Romain Deville ([`92cb3d5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/92cb3d5f561873de9c710e8c1f2ccc97397172ea)) 🔏
  * 🔐(cfg/host/dev): Update HM age &amp; ssh dev:root key by Romain Deville ([`d86008e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d86008ea522d39a6c91915b8f8b16e47c58a6728)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update OS age &amp; ssh darth-plagueis key by Romain Deville ([`5e97f65`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5e97f65c838bcbb7dbe75fb7159d34089d6396de)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update HM age &amp; ssh darth-plagueis:root key by Romain Deville ([`3ba7cf8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3ba7cf8bd3dd73bace179ac4577b1ddf7e0ca016)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update HM age &amp; ssh darth-plagueis:rdeville key by Romain Deville ([`b730c70`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b730c70621da3e243b2b32ae4a0db0c609d3a5e0)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS darth-maul secret by Romain Deville ([`f358000`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f358000dc9ed67df2422801665ddb91207435a92)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS age &amp; ssh darth-maul key by Romain Deville ([`8ebbed8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8ebbed86ad87c40e2d157377b049dd40c234d455)) 🔏
  * 🔐(cfg/host/darth-maul): Update HM age &amp; ssh darth-maul:root key by Romain Deville ([`627bb47`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/627bb471871ae72e0ecaaa599fae63a7bf7192a9)) 🔏
  * 🔐(cfg/host/darth-maul): Update HM age &amp; ssh darth-maul:rdeville key by Romain Deville ([`05e0379`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/05e0379ed61f6a4246ba5d0ab6bf00686ef7ba5f)) 🔏
  * 🔥(direnv): Remove call to source .envrc.local.post() by Romain Deville ([`6d908ff`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6d908ff176703c6691313ca31b38e53732abea73)) 🔏

## v0.7.0 (2025-01-16)

### ✨ Minor

  * ✨ Add sets of script and configuration to ease key/secrets rotations (!39) by Romain Deville ([`c3a4cab`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c3a4cab9d04609de492ecbb549495a01ed0d1220))

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`7d9e97d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7d9e97d222c9af14f9a8da34693cc92775e97e38)) 🔏
  * 👽️(configs): Remove use of hm.flavors._packages with home.packages by Romain Deville ([`8a23516`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8a23516892b9d8de7326c29801416e5cd98c9257)) 🔏
  * 🔒️(common_secrets): Add spotify common secrets by Romain Deville ([`4fbf216`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4fbf2162227f1f84df976436e14429f4130bd639)) 🔏
  * 🔧(cfg/host/rey): Update OS rey config by Romain Deville ([`7784dcb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7784dcb543369cbb3a054f208eddbf0b499572a2)) 🔏
  * 🔧(cfg/host/darth-maul): Update OS darth-maul config by Romain Deville ([`5dd1644`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5dd1644b22eb23cb6c095e1158e95d578108d186)) 🔏
  * 🔧(cfg/host/rey): Update OS rey config by Romain Deville ([`c054ddb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c054ddbe95646c449a653c52f34b178b2ed23e73)) 🔏
  * 🔧(cfg/host/palpatine): Update OS palpatine config by Romain Deville ([`bce2782`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bce2782aeeac345dedcbda03a8b78396f7cb3cce)) 🔏
  * 🔧(cfg/host/FBLP-181): Update OS FBLP-181 config by Romain Deville ([`d2cab0a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d2cab0aaf68a96adc57ee1e2d2b3a7c8b42cec66)) 🔏
  * 🔧(cfg/host/darth-maul): Update OS darth-maul config by Romain Deville ([`287ae99`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/287ae99007858a10dd6e4a615a80ab53a6336c55)) 🔏
  * 🔧(cfg/hosts): Add base.nix for all hosts by Romain Deville ([`fae54f7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/fae54f788b60b410706b8cf947914bf212cc9f99)) 🔏
  * 🔧(sops): Update .sops.yaml config by Romain Deville ([`2a44da6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2a44da6bf8c8dc396e4dd792821a4b67564f20a2)) 🔏

### 🔊 Others

  * 🔐(cfg/accounts): Update contact@romaindeville.ovh secrets by Romain Deville ([`dd2382e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/dd2382edf2ceff8847ecc1a38da540c28eb248d4)) 🔏
  * 🔐(cfg/accounts): Update contact@romaindeville.fr secrets by Romain Deville ([`e501d12`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e501d12416977a12a496b8d92c693dbd4e8cf986)) 🔏
  * 🔐(cfg/host/usb-amd64): Update HM nixos@usb-amd64 keys by Romain Deville ([`a8f3eb1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a8f3eb1191bbdae86751b14f43439aa0fcd2d36b)) 🔏
  * 🔐(cfg/host/usb-amd64): Update OS usb-amd64 secrets by Romain Deville ([`5b3b61c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5b3b61c3973ff02a4c7db022cfd4a93ef660143a)) 🔏
  * 🔐(cfg/host/usb-amd64): Update OS usb-amd64 keys by Romain Deville ([`10cce07`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/10cce078ae44f28e00e97f428b3b99569affde05)) 🔏
  * 🔐(cfg/host/rey): Update HM rdeville@rey keys by Romain Deville ([`9fdbd47`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9fdbd479b4c81551899db3b9019b108f319cbb5e)) 🔏
  * 🔐(cfg/host/rey): Update OS rey secrets by Romain Deville ([`b907e50`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b907e5001b6954a02ef9c878070cb3e7d35f6430)) 🔏
  * 🔐(cfg/host/rey): Update OS rey keys by Romain Deville ([`061a960`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/061a960b0e2e7310a3ebaf1b88d0b6edbffaa472)) 🔏
  * 🔐(cfg/host/palpatine): Update HM romaindeville@palpatine keys by Romain Deville ([`10b2987`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/10b29875a81d56a5d925d0b1c6ea9cc98e53c2c1)) 🔏
  * 🔐(cfg/host/palpatine): Update OS palpatine secrets by Romain Deville ([`3f308ce`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3f308cef0a59c4cc0616672450e0dceed63282fe)) 🔏
  * 🔐(cfg/host/palpatine): Update OS palpatine keys by Romain Deville ([`a3b08c8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a3b08c8def195362d013cb6203e9e76257bd18e9)) 🔏
  * 🔐(cfg/host/FBLP-181): Update HM romaindeville@FBLP-181 keys by Romain Deville ([`9ac6436`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9ac643610f7f44181e3578edad5f1a770f52f55e)) 🔏
  * 🔐(cfg/host/FBLP-181): Update OS FBLP-181 secrets by Romain Deville ([`59d2f06`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/59d2f06a933c13f1a3977a8ddc7e6c8bb4dcc054)) 🔏
  * 🔐(cfg/host/FBLP-181): Update OS FBLP-181 keys by Romain Deville ([`3feb0c5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3feb0c525af0b72ea128cf755d2d290816dfdd0e)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update HM rdeville@darth-plagueis keys by Romain Deville ([`d3ac0ce`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d3ac0cea6960ef6f849cc40a0cfa4b1758462c1c)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update OS darth-plagueis secrets by Romain Deville ([`7ceb8b0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7ceb8b0493886b77a41eedc043a78f6349d7422a)) 🔏
  * 🔐(cfg/host/darth-plagueis): Update OS darth-plagueis keys by Romain Deville ([`9890c97`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9890c97db74e352ced7c4ba6efc84b795836ba9d)) 🔏
  * 🔐(cfg/host/darth-maul): Update HM rdeville@darth-maul keys by Romain Deville ([`95e1954`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/95e19541893c8ec2d36b977181f410ca831a5001)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS darth-maul secrets by Romain Deville ([`725ce08`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/725ce08ac26800eb7361cf09e6b4013c4d130e74)) 🔏
  * 🔐(cfg/host/darth-maul): Update OS darth-maul keys by Romain Deville ([`84bf451`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/84bf4519c3bccc134fbb39c005b9479c1dbbf031)) 🔏
  * 🔥(lib): Remove useless code in default.nix by Romain Deville ([`92f2ba7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/92f2ba7ab1d220255d3f1bfa7ddb900f8f793a2f)) 🔏
  * 🔨(scripts): Add commit.sh to to batch commit update of hosts by Romain Deville ([`f1e09c9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f1e09c95a6b1536305194ed7965c66a28c746b89)) 🔏
  * 🔨(scripts): Improve sops.sh script by Romain Deville ([`0598891`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/05988913d961986e41684a955f290c8a5c8f297a)) 🔏
  * 🔨(scripts): Improve keys.sh script by Romain Deville ([`81be55b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/81be55bcb5f9d0940ee630dd93aea592a683e298)) 🔏
  * 🔨(devbox): Update devbox.json and init_hook scripts location by Romain Deville ([`edb1781`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/edb1781d1143a67245167b91bd7670bcc49b5c0c)) 🔏
  * 🔨(direnv): Update .envrc with .envrc.local.post by Romain Deville ([`a252eb2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a252eb2f29ee7dfc9ceaa80b34ce9c328ce65bed)) 🔏

## v0.6.2 (2025-01-14)

### 🩹 Patch

  * 🐛(cfg/hosts/darth-maul): Add config as param to rdeville user (!38) by Romain Deville ([`d24baa9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d24baa948a4e0f2c1bef58d3ff0246e6e0e95423))
  * 🐛(cfg/hosts/darth-maul): Add config as param to rdeville user by Romain Deville ([`8e1c5f3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8e1c5f31ae000d68f102d553cc6fa3cdc3008d56)) 🔏
  * 🔧(cfg/hosts/darth-maul): Add yubikey-manager pkgs to user rdeville by Romain Deville ([`0644179`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/064417934102a3270e2fee45eef0ee806f28516a)) 🔏

### 🔊 Others

  * 🔨(scripts): Remove `nix fmt .` from hm.sh and nixos.sh by Romain Deville ([`2352848`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2352848fcf40bd93559bb48ecfa74002ab3e71be)) 🔏
  * 🔨(scripts): Restore local_inputs.sh to empty table by Romain Deville ([`d6c5b5e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d6c5b5ea469c9753f10f955db218902a9bb260cc)) 🔏

## v0.6.1 (2025-01-14)

### 🩹 Patch

  * 🍱(cfg/assets/fastfetch): Add dougs.txt ascii logo by Romain Deville ([`17d5ea3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/17d5ea3f271db5c380e453c0c0f7371ab77d6e6e)) 🔏
  * 🐛(cfg/hosts/rey): Fix user rdeville spotify client_id_command by Romain Deville ([`7a663fa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7a663fa85d117840b1a8174aa817b633c47dee69)) 🔏
  * 🐛(cfg/hosts/darth-maul): Fix user rdeville spotify client_id_command by Romain Deville ([`04c0e46`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/04c0e46237e7464d47c1978201c7440be9590731)) 🔏
  * 🔧 Mainly add workstation config, fix minor bugs (!37) by Romain Deville ([`7d32dda`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7d32dda77fd8b2bbe19e3d264a1391106f096abb))
  * 🔧(cfg/hosts/FBLP-181): Add user rdeville HM configuration by Romain Deville ([`db1085c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/db1085c003453f7e67c5a83281d3e158afb7205a)) 🔏
  * 🔧(cfg/hosts): Add FBLP-181 OS configuration (pro workstation) by Romain Deville ([`57f4fb7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/57f4fb74c91cf95a7a13f940e7a4fffc74b593d3)) 🔏
  * 🔧(cfg/hosts/palpatine): Add user rdeville configuration by Romain Deville ([`f716b60`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f716b604782a172696f6b7990d189ecef07e454f)) 🔏
  * 🔧(cfg/hosts): Add Palpatine OS minimal configuration by Romain Deville ([`35b4c12`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/35b4c12d2c2d554e9111607d4ce4be5fc974436d)) 🔏
  * 🔧(sops): Update sops public keys and rules by Romain Deville ([`16fd077`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/16fd0772e2428e5266d6e91c4909f1cf6108e3e2)) 🔏

### 🔊 Others

  * 🎨(scripts/sops.sh): Improve output when using `sops.sh -u` by Romain Deville ([`6213182`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/62131823f2e71a8db55ff776015c378782b00e69)) 🔏
  * 🔐(cfg/hosts/FBLP-181): Update user romaindeville secrets by Romain Deville ([`34e9eb4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/34e9eb4475380c32bae3d2ff81c36e15acc46880)) 🔏
  * 🔐(cfg/hosts/palpatine): Update user romaindeville secrets by Romain Deville ([`33cec51`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/33cec51ae24f98fbb32cb5925f160713ca873b64)) 🔏

## v0.6.0 (2025-01-14)

### ✨ Minor

  * ✨ Add multiples scripts, update secrets and prepare new vm-hosts (!36) by Romain Deville ([`3ef6cc0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3ef6cc0e04e4dc8208bb0dc2b8f2eb1a98f4e335))
  * ✨(os): Add local nixos module with home-manager support by Romain Deville ([`c395e4d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c395e4df9ee77d37fe50ef78ffbdc27b9a5dc290)) 🔏

### 🩹 Patch

  * ⚡️(cfg/accounts): Make use of `home` module instead of `hm` by Romain Deville ([`14b3c92`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/14b3c92d3445bf04aee24301d7ab48438d781b0b)) 🔏
  * ⚡️(hm): Improve `hm` module by removing `hm` arg by Romain Deville ([`93ebdef`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/93ebdef4bcb5158fa48ca219bf331e6ab8659195)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`2d3463c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2d3463c7f4ecb0c9454c5e1b389fe72cee799932)) 🔏
  * 📦️(cfg/hosts/darth-maul): Add viddy pkgs to user rdeville by Romain Deville ([`76e7444`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/76e744487614d27dcfe134ce8636b5058495b0e5)) 🔏
  * 🔧(cfgs/hosts): Add usb-amd64 build to cread bootable USB or VMs by Romain Deville ([`843c81a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/843c81a5b3824c2b49640e2f24fd28fe99a56450)) 🔏
  * 🔧(cfg/hosts/rey): Update rey config to use new modules by Romain Deville ([`d02a849`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d02a849bb9117ba26e0e91f55fdddace6e9dc51b)) 🔏
  * 🔧(cfg/hosts/darth-maul): Update `os` and `hm` to be nix modules. by Romain Deville ([`512a008`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/512a0087ae582b47976fffa6107979e7fa31ecb0)) 🔏
  * 🔧(sops): Update .sops.yaml config (public keys and rules) by Romain Deville ([`0bb5452`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0bb54521c70105086e837e95897a54e834c4b9f9)) 🔏
  * 🔧(flake): Update nixos by Romain Deville ([`e6c3b8b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e6c3b8bfc466635b25ef850b237e7bac656cdb3e)) 🔏

### 🔊 Others

  * ♻️(scripts): Create _init_logger.sh file to mutualise logger by Romain Deville ([`9a65f1e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9a65f1e57a333b22085d3f774c40efd5ee7843d2)) 🔏
  * 🎨(flake): Split flake.nix into nixos.nix and home-manager.nix by Romain Deville ([`55f2d1a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/55f2d1a73d436f0f16ca02f7cc8948d55fb1fa09)) 🔏
  * 🔐(cfg/hosts/darth-plagueis): Update os secrets by Romain Deville ([`a8f4148`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a8f41488a1cd2e1ee83ba9dbd06a4739e2f1aa16)) 🔏
  * 🔐(cfg/hosts/darth-plagueis): Update user rdeville secrets by Romain Deville ([`4d8b950`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4d8b9509240cb5cdbfc172b5cfbb03954f6ba3dc)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update os secrets by Romain Deville ([`82e6c16`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/82e6c16a34206e5036a0330c91e665ada9ed7d52)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update user rdeville secrets by Romain Deville ([`14ca9d9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/14ca9d9b227f2dd0a3d190c1a37f01084bf0071a)) 🔏
  * 🔐(cfg/hosts/rey): Update os secrets by Romain Deville ([`9dd0510`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9dd051090732c1014f4c6bcd6957322f3c8e002d)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update os secrets by Romain Deville ([`e69e46f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e69e46fa3637e519f583f02ced2ed6d94707ca47)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update user rdeville secrets by Romain Deville ([`a106353`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a106353e8f2b8497cc2e336139d30c36c9564a75)) 🔏
  * 🔐(cfg/hosts/rey): Update sops secrets by Romain Deville ([`eb84a34`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/eb84a3440d7d766873950ee4fff091c97044c5a1)) 🔏
  * 🔐(cfg/hosts/darth-maul): Update sops secrets by Romain Deville ([`5f62aa2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5f62aa2258fb13088feadeccc552792aac078878)) 🔏
  * 🔐(cfg/hosts/darth-maul): Add encrypted host ssh keys by Romain Deville ([`67038fe`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/67038fe73cb5fdddff1d6fb0e5ee1bc5a98d92d6)) 🔏
  * 🔐(cfg/accounts): Update accounts secrets with new keys by Romain Deville ([`678a072`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/678a0723fd95b6e3f5d7985e7ec11c7dd48f31d0)) 🔏
  * 🔨 hm/fmt by Romain Deville ([`d12b8e0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d12b8e03eea91af27601bc73d4890275cafd8946)) 🔏
  * 🔨(scripts): Add keys.sh script to (re)generate encrypted private keys by Romain Deville ([`8875a8b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8875a8bf4253b8817ad121681361100485342131)) 🔏
  * 🔨(scripts): Add script sops.sh to batch update encrypted files by Romain Deville ([`09dfd6d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/09dfd6dbd4bef495dc1e9ec9488017b07d654714)) 🔏
  * 🔨(scripts): Make hm,fmt and nixos to use _init_logger.sh and nix fmt by Romain Deville ([`911bf28`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/911bf28b24e98ab0ddf284540df2e2c56ecd4545)) 🔏
  * 🙈 Add *.qcow2 to gitignore by Romain Deville ([`201fb79`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/201fb796bdada38e71044c1e63bd580b36afd63d)) 🔏

## v0.5.1 (2025-01-06)

### 🩹 Patch

  * ⚡️(os): Improve nixos/default.nix by Romain Deville ([`15a82a0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/15a82a0db98b261ff1472c34de6d6e59b8fc248e)) 🔏
  * ⬆️ Upgrade flake.lock by Romain Deville ([`7e2c1bb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7e2c1bb444a68c9f1cceff4c06fe3e990d516f07)) 🔏
  * 🔧 Mainly update host config and setup user password (!35) by Romain Deville ([`5442d6b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5442d6b76b6d8a0ed37ea1e342a40f549ead0e29))
  * 🔧(flake): Update Update input, add nix-index by Romain Deville ([`f23fed0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f23fed0e6e1f1429ac30b1728d4e142c41aa5e67)) 🔏
  * 🔧(configs): Update config and add users password by Romain Deville ([`ef81d8e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ef81d8e5f6db1decad960e0c9c4de559c98d18a1)) 🔏

### 🔊 Others

  * 🔐 Update .sops.yaml with some keys by Romain Deville ([`b9ad5a8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b9ad5a83b0e99e49fcbe211586c998310b9ac46b)) 🔏

## v0.5.0 (2025-01-02)

### ✨ Minor

  * ✨ Fix configs due to modules in main nixos (!34) by Romain Deville ([`d39ac72`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d39ac72f514eb80a2545f3d98255b07d0f5205a9))

### 🩹 Patch

  * ⚡️(hm/flavors/ssh-client): Make flavor a nix module by Romain Deville ([`7974744`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/79747443786b9353706326e7b7fa98022fb57a18)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`a2a4360`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a2a4360fbdd210717e778515f388d2fa4899356a)) 🔏
  * 👽️(configs): Update all configs after public nixos upgrade by Romain Deville ([`ac43c18`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ac43c18830d715a3e819083e1f1a0722e0d2d266)) 🔏
  * 🔧(hm): Update default HM based on _core flavor by Romain Deville ([`c5c6eb8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c5c6eb8095a431a9cf51f92c37eeae01c253ed32)) 🔏

### 🔊 Others

  * 🎨 Rework format of devenv.nix by Romain Deville ([`ae27bd7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ae27bd76eadf2b89256995410479186542741358)) 🔏
  * 🎨 Improve flake.nix configuration by Romain Deville ([`7f6a3fe`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7f6a3feb4afe3e9849cdff90b69fbd95682e7fb6)) 🔏

## v0.4.2 (2024-12-22)

### 🩹 Patch

  * 🐛 Fix flake.nix allowing multihost HM config by Romain Deville ([`e59128d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e59128dfe81f42c9ec1caad1e223584a963b51c9)) 🔏
  * 🔧(configs/hosts): Update hosts configuration (!33) by Romain Deville ([`9a4c453`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9a4c45384676c78ba5b4815b9079c92ab39fb596))
  * 🔧(configs/hosts/rey): Update rey configuration to new structure by Romain Deville ([`ab54cfc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ab54cfc510caa3cb7a46d85d65ece791118a2437)) 🔏
  * 🔧(configs/hosts/darth-plagueis): Update hosts configuration by Romain Deville ([`bc4551d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bc4551d9ab690ad63fc2627d8e6f0cee5a45700d)) 🔏

## v0.4.1 (2024-12-22)

### 🩹 Patch

  * 🐛(hm): Fix accounts configurations (!32) by Romain Deville ([`29cad67`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/29cad67b3f78e093a7c23076abf3aa51b27947df))
  * 🐛(hm): Fix accounts basePath configurations by Romain Deville ([`f44ef33`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f44ef3303eaa4bceda470811b7d20a59c9fe2d44)) 🔏
  * 🔧(configs/accounts): Fix configs accounts by Romain Deville ([`200ba12`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/200ba12f4ed4044fce7fc7fc4cb9c886959b07d0)) 🔏

## v0.4.0 (2024-12-22)

### ✨ Minor

  * ✨ Upgrade config to use public nixos using modules (!31) by Romain Deville ([`7825107`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7825107b051d455eba34903a1220be5612515a47))
  * ✨ Upgrade flake.nix to new module structure by Romain Deville ([`98bc017`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/98bc017a361528d9873b36acfaa25ea5100e05c0)) 🔏
  * ✨(configs/hosts/darth-plagueis): Add darth-plagueis host and users config by Romain Deville ([`7065bcb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7065bcbe034788f50c73d11d7bc66eaccfb3af21)) 🔏
  * ✨(nixos): Add default nixos configuraiton by Romain Deville ([`294b225`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/294b225afab47883122e7484a67b7a571fda9eff)) 🔏
  * ✨(hm): Add hm default configuration and use modules by Romain Deville ([`9534950`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/953495017417e4890de0854d4613b8801148bd52)) 🔏
  * ✨(hm/flavors): Upgrade flavors to use modules by Romain Deville ([`3e13c5a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3e13c5aa1aa4fca8d26b68f194ed30db31ea26d6)) 🔏
  * ✨(lib): Add lib, mainly  related to hm accounts configuration by Romain Deville ([`a86886a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a86886af86942fc93c93752415ef9b34eb0a3351)) 🔏

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`183b478`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/183b478039d824582e34e20483a3ae4cfda2a7e8)) 🔏
  * 🔧(configs/hosts/rey): Upgrade rey config to use module by Romain Deville ([`19b69d6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/19b69d63803a851a0c60dfc20f25d18d068fae21)) 🔏
  * 🔧(configs/hosts/darth-maul): Upgrade darth-maul to use new modules by Romain Deville ([`045ca53`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/045ca53ecac866247067957db541eaff42fc07db)) 🔏
  * 🔧(configs/accounts): Update email/contact/calendar accounts config by Romain Deville ([`5165985`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/516598508400dd01c0d624acec5c56390262c4f0)) 🔏
  * 🔧(configs/pubkeys): Add some public SSH keys by Romain Deville ([`251761e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/251761ea5cfe735edf52d8f66aea7f31abbdb1a5)) 🔏

### 🔊 Others

  * 🔥(configs/hosts): Remove now useless default hosts config by Romain Deville ([`ff6c338`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ff6c338fa6710b83a0df8cede79203723da5fa84)) 🔏
  * 🔥(hm/presets): Remove hm presets not used anymore by Romain Deville ([`cb6bceb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/cb6bceb9225e2feb582aabd12eb0412c51bead97)) 🔏
  * 🔥 Remove now useless modules/home-manager by Romain Deville ([`65f797d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/65f797d2303b98c0576dce23d65980b1da154e34)) 🔏
  * 🔨 Update devenv.nix with new script by Romain Deville ([`e1938ee`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e1938ee884e00a8d2a6ef06ab0967cc6f17d0217)) 🔏
  * 🔨 Update devenv scripts by Romain Deville ([`bfbccf2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bfbccf216e6b6057694f868a5fc2c30ce8171785)) 🔏
  * 🚚(hm): Move flavors/bin to assets/scripts by Romain Deville ([`5fa6a3b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5fa6a3b1bf9cf01ff5a7d798ff84eaf9374252b8)) 🔏

## v0.3.2 (2024-12-08)

### 🩹 Patch

  * ⬆️ Upgrade flake.lock by Romain Deville ([`dcd1693`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/dcd16939ade5c9eb9651bcbae629e269de63a444)) 🔏
  * ⬆️ Upgrade to configuration to 24.11 by Romain Deville ([`8cc28a9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8cc28a9d7d6e12f3c1c045d170799f93d9e0ba8d)) 🔏
  * 🐛(configs): Fix accounts pkgs configuration by Romain Deville ([`62bc7d9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/62bc7d977cf65d1636602a5387a697c08002308d)) 🔏
  * 🔧(config/hosts/darth-maul): Enable nixos k3s flavor by Romain Deville ([`5e71e63`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5e71e63a44c2b6a74f7042db4c80ce3bb13f7543)) 🔏
  * 🔧(configs/hosts/darth-maul): Add nixos and hm flavors by Romain Deville ([`40972a4`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/40972a45aa6efc28d558ba17d74dcf28e8bebce7)) 🔏

### 🔊 Others

  * 🎨(configs/hosts/darth-maul): Remove useless module input by Romain Deville ([`e2b73ab`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e2b73ab8e1d69d6c5d33dca51a173f66df70d3d3)) 🔏
  * 💚 fix commitlint CI by Romain Deville ([`a47173a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a47173a47dbfc3e2fef0e4a24068cf31d5282001)) 🔏
  * 💚 Update semantic release git strategy and depth by Romain Deville ([`547a659`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/547a659c201652a33e6ffa34ac893f105d8ff8ab)) 🔏
  * 🔀 Fix commitlint CI (!30) by Romain Deville ([`da0e0ea`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/da0e0ea901b03604724dca2d36553a74ea24cf2c))
  * 🔀 Fix accounts, update flavors (!29) by Romain Deville ([`eb80b21`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/eb80b21a32c9832a691234a15f0f97933141fab3))

## v0.3.1 (2024-11-24)

### 🩹 Patch

  * ⬆️ Update flake.nix and flake.lock by Romain Deville ([`68367b1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/68367b198cd2c72260785912ef23b1d86ed79673)) 🔏
  * 🔧 Update rdeville@rey and rdeville@darth-maul config (!27) by Romain Deville ([`a3ce288`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a3ce28864ccfcf2cc1343502e4e4601e38b0ff9f))
  * 🔧 Add kitty config for rdeville@rey by Romain Deville ([`834291e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/834291e06ac8115ae04cd636da83d9ce1c327a75)) 🔏
  * 🔧 Add new flavor and kitty config for rdeville@darth-maul by Romain Deville ([`1ca8237`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1ca8237fec32e6c249e97b206e9773d7f5510c9b)) 🔏

### 🔊 Others

  * 💚 Fix Semantic Release CI by Romain Deville ([`636acae`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/636acaecd339cdaf886056841f51249bb3630889)) 🔏
  * 💚 Fix commitlint and semantic-release CI by Romain Deville ([`6c636ce`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6c636ceb9f39461836549c60eccbb169cf5daba5)) 🔏

## v0.3.0 (2024-11-24)

### 🩹 Patch

  * ⚡️(hm/flavors/bin): Make direnv_init only setup symlink if dest exists (!25) by Romain Deville ([`c2a8d66`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c2a8d66c3471e7232721d18ab571f8ec7f1ffb8f))
  * ⚡️(hm/flavors/bin): Make direnv_init only setup symlink if dest exists by Romain Deville ([`9faf95f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9faf95f81ce20d95952849f86a0cce7c97b67537)) 🔏
  * ✏️(hm/flavors): Format default.nix by Romain Deville ([`bf93234`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bf932345245d09ad082a1f8e7a5b6a1728d0dd7b)) 🔏
  * ⬆️ Update templated files from dotgit-sync (!24) by Romain Deville ([`76dfbbf`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/76dfbbffd596212345bd70c2b0a37e40bab7fde7))
  * ⬆️ Update templated files from DGS by Romain Deville ([`29376e3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/29376e384d7f3a27fbaf75d8be561334a589f0f9)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`4492536`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4492536d03505b3162f513ae5974ebcfabac14b6)) 🔏
  * 🐛(hm): Fix darwin support and wrapGL (!23) by Romain Deville ([`d87f79d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d87f79dedeea554ac501d27b735a204e4fe053c5))
  * 🐛(configs/hosts): Fix isDarwin and wragGL config by Romain Deville ([`c0be49b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c0be49b4fc8351eb1d6fb6e01ea8b3feafff786c)) 🔏
  * 🐛 Update configs to work with NixOS (!22) by Romain Deville ([`4d6f549`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4d6f549dca88799c5880fbf8dfadf4084700f380))
  * 🐛(hm/flavors/bin): Fix bug in rey_salon script by Romain Deville ([`e116011`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e11601105a5375d3dae0b2b1857d48b940cfa925)) 🔏
  * 🐛(modules): Fix HM module by Romain Deville ([`5ebdc09`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5ebdc09ec2b7d750533b72895cbcb887f9747900)) 🔏
  * 🐛(hm/presets): Add HM presets generic default.nix by Romain Deville ([`39538db`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/39538dbc19d82ab3491de22f91478d49f7fa24cc)) 🔏
  * 🐛(hm/flavors): Add flavors generic default.nix by Romain Deville ([`9746eed`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9746eed0c4e8f9730656b7d3aafd9e103d5749bb)) 🔏
  * 📌 Update pinned flake inputs in flake.lock by Romain Deville ([`e146d22`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e146d22e52fa90ee650d7121ec8f0b35f88f3f4f)) 🔏
  * 🔧(configs/hosts): Update hosts configuration by Romain Deville ([`21b8f37`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/21b8f37222dc6f3dfaa73c267f08366aa575be5f)) 🔏
  * 🔧(configs/hosts/darth-maul): Add root users by Romain Deville ([`ad4a3e9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ad4a3e9c7320d6932b4349dbf67fe4727b482e71)) 🔏
  * 🔧(configs): Update all configs with NixOS integration by Romain Deville ([`35a155d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/35a155d6804386b57438047f821692ccdd49d07e)) 🔏
  * 🔧 Update flake inputs and output by Romain Deville ([`97890ff`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/97890ff50708e11341809f82991588c6fecc74c7)) 🔏
  * 🔧(pre-commit): Temporarly deactivate some pre-commit by Romain Deville ([`64011af`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/64011afea45f907f55982fc2b8655479e8d9ddb7)) 🔏

### 🔊 Others

  * ♻️(hm/presets): Refacto hm presets by Romain Deville ([`092390f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/092390f003a1bc0c438cb3b318a29d6f56bbbcee)) 🔏
  * ♻️(hm/flavors): Refacto hm flavors by Romain Deville ([`6f333ed`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6f333edaf2cf56211567b970a5e276d61bc9f652)) 🔏
  * 💚 Fix CI release (!26) by Romain Deville ([`1f4e9df`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1f4e9df16a3606fb92d4cb2dd71a83f82ca85c5e))
  * 💚 Fix CI release by Romain Deville ([`b032ec6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b032ec6337b32a0b60b3fcda59aa5b1f7dd96a95)) 🔏
  * 🔥(configs): Clean useless code by Romain Deville ([`a679b31`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a679b31c2ca0d6ea4b462520ad4f032e99975061)) 🔏
  * 🔥(hm): Remove useless default.nix for home-manager/ by Romain Deville ([`d7c30bd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d7c30bd45c9ba8431d7f8b439f3c70efeace3fc9)) 🔏
  * 🔨(scripts): Improve hm.sh script behaviour by Romain Deville ([`c91d3fc`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c91d3fcc431c86caeb394345c5d725828d5236c2)) 🔏
  * 🔨(devenv): Update devenv and scripts by Romain Deville ([`4cc9871`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4cc98719e8acc2ec289be516bb2314c4fdd02ac7)) 🔏

## v0.2.13 (2024-10-07)

### 🩹 Patch

  * 🐛(cfg/accounts): Fix vdirsyncer cmd for contact@romaindeville.ovh (!21) by Romain Deville ([`173d46b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/173d46be67d968e0b52a19207063d658655819a3))
  * 🐛(cfg/accounts): Fix vdirsyncer cmd for contact@romaindeville.ovh by Romain Deville ([`7e55591`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7e55591b3dfc480c574dd32f8d59515c1a910b6e)) 🔏

## v0.2.12 (2024-10-07)

### 🩹 Patch

  * ✏️(cfg/accounts): Update typos for accounts (!20) by Romain Deville ([`5b9e94b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5b9e94bc9f2c006db79cf71f363498088c05f1be))
  * ✏️(cfg/accounts): Update account typos by Romain Deville ([`9f9a34f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9f9a34fd0ec47180ac76fd1c3e6194987792aedf)) 🔏
  * 🔧(cfg/hosts/rey): Update accounts by Romain Deville ([`9cdb82f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9cdb82fa61d20dd4d95205d88fd026ab028dae09)) 🔏

## v0.2.11 (2024-10-06)

### 🩹 Patch

  * ⚡️ Refacto accounts and improve management and secrets (!19) by Romain Deville ([`5ae7386`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5ae738682a4760d4a49485f37aff7cc677a56cb8))
  * ⚡️(hm/flavors): Make bin optional with boolean by Romain Deville ([`809a5e6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/809a5e68d5dfe99a80eeadd4e4b871990a4e422e)) 🔏
  * ⚡️(cfg): Update default config lib method by Romain Deville ([`4ef7958`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4ef7958c46cc33c491bf6dd94903d8c8e1f93593)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`0fe4b59`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0fe4b59222703af79c87e11f01d824771066c4ec)) 🔏
  * 🔧(cfg/hosts): Update hosts rey and add anakin by Romain Deville ([`2bc38ac`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2bc38acb54de8b6c3d9a1469cf849e5d9e59d909)) 🔏
  * 🔧 Update .sops.yaml config by Romain Deville ([`9f1e3a8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9f1e3a82fcdb3a4a5c62c22378eec88044461821)) 🔏

### 🔊 Others

  * ♻️(cfg/accounts): Update accounts management and secrets by Romain Deville ([`e5dded3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e5dded36efc6b0d04565a389295ab898e4167f92)) 🔏
  * 🎨(modules): Update HM module by Romain Deville ([`7a9e293`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7a9e293f57f2b3188f67276b166489e5313c5002)) 🔏
  * 🔥(cfg/secrets): Remove old secrets structure by Romain Deville ([`34c2e6e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/34c2e6e7217d6eed5f759a59a7efde3b0e643387)) 🔏

## v0.2.10 (2024-09-14)

### 🩹 Patch

  * ⬆️ Update flake.lock (!18) by Romain Deville ([`65710f9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/65710f9dd1a7d98d259179eb980ee1af41e504df))
  * ⬆️ Update flake.lock by Romain Deville ([`edc625d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/edc625d77dd1d688c67cadfa58a8a6af86cd9fdf)) 🔏

## v0.2.9 (2024-09-14)

### 🩹 Patch

  * ⚡️ Improve kp script to manage yubikey (!17) by Romain Deville ([`4a7bc87`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4a7bc87d5f46a404f87030d1d2512651c8e4c1ac))
  * ⚡️(hm/flabors/bin): Improve kp script to better manage Yubikey by Romain Deville ([`dbcff23`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/dbcff23804f8fe7758f3fa36972518fdff6be83d)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`f3aacd6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f3aacd6cbd60170a944d61c39f85a23e8ac26aaa)) 🔏

## v0.2.8 (2024-09-13)

### 🩹 Patch

  * 🐛(hm/flavors/bin): Remove sensible log output (!16) by Romain Deville ([`83cd890`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/83cd89054d7b0e9908968411566a227e4f59c176))
  * 🐛(hm/flavors/bin): Remove sensible log output by Romain Deville ([`99b65a8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/99b65a8912c43680694c92015547bc29876e2d64)) 🔏

## v0.2.7 (2024-09-13)

### 🩹 Patch

  * ⚡️(hm/flavors/bin): Improve kp script for yubikey (!15) by Romain Deville ([`4822dbf`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4822dbfa763c2f51aba0d1a71e1c4e42c8afb169))
  * ⚡️(hm/flavors/bin): Improve kp script for yubikey management by Romain Deville ([`f6275cd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f6275cdbe23dd5a442b0440ee9ddd1de9b658710)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`35fa37d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/35fa37d21871d4e703a86476fe7111169a1f2fa7)) 🔏

### 🔊 Others

  * 🎨 Improve Yubikey management assuming single key is plugged (!14) by Romain Deville ([`b9e6cdf`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b9e6cdfa872efb3f2ce563603a1d592027e612ac))
  * 🎨 Improve Yubikey management assuming single key is plugged by Romain Deville ([`9ad45d3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9ad45d3939e99c8e95bc60414a042e5428be0df4)) 🔏

## v0.2.6 (2024-09-12)

### 🩹 Patch

  * ⬆️ Update flake.lock (!13) by Romain Deville ([`839bb32`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/839bb3210b2004b4ff389283898bfee9402a5a80))
  * ⬆️ Update flake.lock by Romain Deville ([`6b9c7b6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6b9c7b6ecb1f482b5016124180b21b92fe9a92e8)) 🔏

## v0.2.5 (2024-09-12)

### 🩹 Patch

  * ⚡️ Improve dgs_commit script with tf-docs config (!12) by Romain Deville ([`16a3819`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/16a381941d9026ab8b7192ea6ae818c4dd1cb1b3))
  * ⚡️ Improve dgs_commit script with tf-docs config by Romain Deville ([`c672b33`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c672b33afbb7a42db3099d731fee3be11c4fad66)) 🔏

## v0.2.4 (2024-09-09)

### 🩹 Patch

  * ⬆️ Update flake.lock by Romain Deville ([`1ad2db3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1ad2db371fcd97b8e1e685f0aa35fb69acdabde5)) 🔏
  * 🔧(cfg/hosts/rey): Enable TF flavors for @rdeville (!11) by Romain Deville ([`a162a54`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a162a54100544d0fa45e0c5522e76c96dff00410))
  * 🔧(cfg/hosts/rey): Enable TF flavors for @rdeville by Romain Deville ([`b3712f7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b3712f7e3bddce2094a824fce223343176578ba5)) 🔏

## v0.2.3 (2024-09-09)

### 🩹 Patch

  * ✏️ Format most files &amp; update lock (!10) by Romain Deville ([`ad885ef`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ad885ef58c0e4df0d690796eb47a382b9101c6da))
  * ✏️ Format devenv.nix by Romain Deville ([`570a7a1`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/570a7a1088fd6eed2ba2689a43d292a9f96c1cf5)) 🔏
  * ✏️(hm/flavors): Format nix files by Romain Deville ([`264763b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/264763bbe2e70fbcd902fa4c6fef40068875eb49)) 🔏
  * ✏️(hm): Format default.nix by Romain Deville ([`ae0b778`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ae0b778363c72762f329e58a820266e98db1bb73)) 🔏
  * ✏️ Format flake.nix by Romain Deville ([`730f6e0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/730f6e09fd87af3367a9f895eb5f19a7df05021d)) 🔏
  * ✏️(config/hosts/rey): Format file by Romain Deville ([`6523c4e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6523c4e0bcf0692573efae077c482bfbb7bf0b7d)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`5884369`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/58843693fb704e43ed331da213a488ba1fefd1fb)) 🔏
  * ⬆️ Update flake.lock by Romain Deville ([`b15e063`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b15e063da3980c7c885be3848a0d60186a4fc2c1)) 🔏

## v0.2.2 (2024-09-07)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!9) by Romain Deville ([`b7b5ff3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b7b5ff36f6ab5ba2216ec6df5a58167db86ff29c))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`875196d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/875196d0bd15e9c1c0c878932dc7bc05d0f40850))

## v0.2.1 (2024-08-27)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!8) by Romain Deville ([`6b79bd6`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6b79bd61f9d83af9bfbd700079382b82ce764e5d))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`863451a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/863451a7f97f6590ee3a89704be016cf544e2ff1))

### 🔊 Others

  * 👷 Update Gitlab CI from DGS template by Romain Deville ([`56ada5f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/56ada5f7cc140a4c0555517ba0e30a13a953b85a)) 🔏

## v0.2.0 (2024-08-27)

### ✨ Minor

  * ✨(scripts/hm): Add `upgrade` options to hm scripts (update and switch) by Romain Deville ([`b4b7ebb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b4b7ebb638643b412bc98ae98285c38172973b7d)) 🔏

### 🩹 Patch

  * ✏️(scripts): Update default local_inputs.sh values by Romain Deville ([`284b55f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/284b55fa39fea1116df419c882036dc95aa39b6b)) 🔏
  * 🐛 Improve dgs_commit script to only add .envrc (!7) by Romain Deville ([`6e37e06`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6e37e068bc8661c72404a3094d0d0414d811e64a))
  * 🐛 Update dgs_commit script to only add .envrc by Romain Deville ([`6a0d09a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6a0d09a61500dcb0b9a561fc258faa1ded82808b)) 🔏
  * 📌 Update flake.lock by Romain Deville ([`b18309a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b18309a62e33c79cde13038451502aba14b0776d)) 🔏

### 🔊 Others

  * 💚 Fix CI from DGS Template by Romain Deville ([`3ad81fe`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3ad81fe15cb3a2342917c9d4c1c480fd69465574)) 🔏

## v0.1.4 (2024-08-23)

### 🩹 Patch

  * ⬆️ Update templated files from dotgit-sync (!6) by Romain Deville ([`d752348`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d752348d893b82798c2b4d11d836662972b6f81b))
  * ⬆️ Update templated files from dotgit-sync by Dotgit Sync [bot] ([`87d9acd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/87d9acd7f7e4114cd37fc418bfc90f0e5171a10f))

## v0.1.3 (2024-08-19)

### 🩹 Patch

  * 🐛 Fix bugs in script dgs_commit (!5) by Romain Deville ([`eda92aa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/eda92aa0b5a2c90641407d6fd1cbf2cf83468ed0))
  * 🐛(hm/flavors/bin): Update scripts dgs_commit by Romain Deville ([`f587ccb`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f587ccb6e0918fffe12db82d0c14afa9537ef8bf)) 🔏
  * 📌 Update flake.lock by Romain Deville ([`92da424`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/92da424ddd41f5cf52c774fc8fd2e7c280313bf3)) 🔏

## v0.1.2 (2024-08-18)

### 🩹 Patch

  * ⚡️ Improve scripts and update config from DGS (!4) by Romain Deville ([`82cd728`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/82cd728824e46277ae243c9a906dc4cd9b007cd6))
  * ⚡️(scripts): Improve scripts allowing to build locally by Romain Deville ([`eee9b1f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/eee9b1f3d10b0da26524a8c243d22881c664450c)) 🔏
  * 📦️ Update flake.* from DGS by Romain Deville ([`e416036`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e416036403c90b24e2d11dc011aa7cf7c755cf61)) 🔏

### 🔊 Others

  * 💚 Update Gitlab CI from DGS by Romain Deville ([`c98464b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c98464b46d0c8b25afba5ae78f2174e1523a87ca)) 🔏
  * 📝 Update README from DGS by Romain Deville ([`91ddbea`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/91ddbea9fa6d925cc8d287426863752ce4b67596)) 🔏
  * 🔨 Update devenv from DGS by Romain Deville ([`680d926`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/680d926e0f26751df59f1080d226e4e29bb9861b)) 🔏

## v0.1.1 (2024-08-18)

### 🩹 Patch

  * ✏️ Fix typos in configs/default.nix (!3) by Romain Deville ([`522349e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/522349e597d7ecf3202e94834878f3e0e793c2ed))
  * ✏️ Fix typos in configs/default.nix by Romain Deville ([`c58343f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c58343f9bd58147355b74ee896b6e6ecdb820c6f)) 🔏

## v0.1.0 (2024-08-18)

### ✨ Minor

  * ✨ First version of my private NixOS/HM Config (!2) by Romain Deville ([`34e2b74`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/34e2b746af6a243d91d118eb11983c00274a3eef))
  * ✨(hm): Add HM default.nix by Romain Deville ([`838e427`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/838e4273f07221bf1bb92e4857d3134fa6a6ad57)) 🔏
  * ✨(hm/presets/main): Add SSH host config by Romain Deville ([`b11ef5e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/b11ef5efd308b0932083974844ef078815943062)) 🔏
  * ✨(hm/flavors/bin): Add bin flavors to setup my scripts by Romain Deville ([`7a26ac9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7a26ac9985dfbc57b567e7a2d871e7c9222eb3b6)) 🔏
  * ✨ Add config secret rey rdeville by Romain Deville ([`dbab7b0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/dbab7b059a0aa1c0e2500a18e987727c20073a63)) 🔏
  * ✨ Add config account default.nix by Romain Deville ([`9b4425b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9b4425bb64b07ea2b1c80063260545d45ebc5d9f)) 🔏
  * ✨ Add config accounts rdeville by Romain Deville ([`6b7a72c`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/6b7a72ce3c0883d2bcc1333dc52dd5bfa48225da)) 🔏
  * ✨ Add config host default by Romain Deville ([`06c4944`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/06c4944dcda1bd238fc3074f42df50bc3b7522b1)) 🔏
  * ✨ Add config host rey by Romain Deville ([`46fb5e5`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/46fb5e57bd3e7187fd76cf9dc25d84b4185ff1e2)) 🔏
  * ✨ Initialise repo and add host configuration (!1) by Romain Deville ([`3f6f353`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3f6f3538f2afcb2c2c5b6c525cf2d43308d0c6ed))
  * ✨ Add config default.nix by Romain Deville ([`83dce2d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/83dce2dd4ea4ffdb7f30ae6fb23f0ceff8d7bd8f)) 🔏
  * ✨ Add config vms by Romain Deville ([`f314bf2`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f314bf2a0a6919b4e27afca68318028215a3c900)) 🔏
  * ✨ Add config secret rey rdeville by Romain Deville ([`d571817`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/d571817fc090d110dfef56a10e60531a716a99b3)) 🔏
  * ✨ Add config account default.nix by Romain Deville ([`1ef3de3`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1ef3de3f1181c22a6dbcd784af40bca2afc988a3)) 🔏
  * ✨ Add config accounts rdeville by Romain Deville ([`4ef6b5a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/4ef6b5a3d63d2c9625d758c54288e74ade9f37fd)) 🔏
  * ✨ Add config host default by Romain Deville ([`e29c62d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e29c62de95e853c6bd0b464f85921ab66f7e3802)) 🔏
  * ✨ Add config host rey by Romain Deville ([`ed78691`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/ed78691dc03f7da09afeda68432b02175352a3b9)) 🔏

### 🩹 Patch

  * 🔧 Add .dotgit.yaml by Romain Deville ([`26053d7`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/26053d7d0068dd3244e107e9bb7e48161322d03c)) 🔏
  * 🔧 Add .sops.yaml configuration by Romain Deville ([`bd40dac`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/bd40dacf80e9bf8934651f1e4c0f896343484205)) 🔏
  * 🔧 Add .dotgit.yaml by Romain Deville ([`321cf65`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/321cf650024b283c22d83564230762e567f56c64)) 🔏

### 🔊 Others

  * 👷 Add Gitlab CI Build System by Romain Deville ([`13323fd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/13323fd84154041b01fff6a58c2389b352a7912a)) 🔏
  * 👷 Add Gitlab CI Build System by Romain Deville ([`13871f9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/13871f9d8c48ec20ffc6a0e471a3a957b4f8a962)) 🔏
  * 📄 Add LICENSES by Romain Deville ([`0a0d2d0`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/0a0d2d00a62a0d6a575de9106598aba97636a07a)) 🔏
  * 📄 Add LICENSES by Romain Deville ([`a6dfd1d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/a6dfd1de64278be6752a18401d14973e9fb9134f)) 🔏
  * 📝 Update README.md by Romain Deville ([`9ad223a`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/9ad223ab9dc229671489dafc4f0a4cb474bbb90f)) 🔏
  * 📝 Update README.md by Romain Deville ([`3b79cfa`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/3b79cfa39cfb2b6b785f6f6588a8c51181ed02ff)) 🔏
  * 📝 Add CODE_OF_CONDUCT.md by Romain Deville ([`7770cdd`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/7770cddc1ecbd2779d72cd3fb012a3c08f9c69d5)) 🔏
  * 🔨 Add flake.nix and flake.lock by Romain Deville ([`df6343f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/df6343fe0a613f18bdf3454bf60c94e98a51adce)) 🔏
  * 🔨 Add scripts tools by Romain Deville ([`2b5b57f`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/2b5b57f67a6e2112ae6226a96df1e9731346c28d)) 🔏
  * 🔨 Add devbox configuration by Romain Deville ([`e4b41ba`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e4b41ba9841261e453ad540b715b17ffc91989ca)) 🔏
  * 🔨 Add python-semantic-release configuration by Romain Deville ([`5fe7446`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5fe74461464886dd828b14f595e9ec9f919c97be)) 🔏
  * 🔨 Add markdownlint configuration by Romain Deville ([`edd633b`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/edd633b5572da78de97ca8dcd3e66772b8bc03b6)) 🔏
  * 🔨 Add .envrc by Romain Deville ([`f0ab654`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f0ab654f2b7958e7ff0ef95c9a048a216b95f0f6)) 🔏
  * 🔨 Add flake.nix and flake.lock by Romain Deville ([`e4bdf16`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/e4bdf1603af888fbc5bcad4c1cb97349c18cddae)) 🔏
  * 🔨 Add scripts tools by Romain Deville ([`5b28c19`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/5b28c192c51795466a2c73a47962678c8aa4fa4b)) 🔏
  * 🔨 Add devenv.nix configuration by Romain Deville ([`800158e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/800158eae5792f0ebaf7b956d74ad8e8441596e3)) 🔏
  * 🔨 Add devbox configuration by Romain Deville ([`86878e9`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/86878e99d8c696e87182bcf73fd66a2d93f3d18a)) 🔏
  * 🔨 Add python-semantic-release configuration by Romain Deville ([`8e939c8`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8e939c8eb8c45ecd4da2f80857ae1b0ad57ab622)) 🔏
  * 🔨 Add markdownlint configuration by Romain Deville ([`0144460`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/01444606cfcddec26b302a57f6c05e9193d7e49e)) 🔏
  * 🔨 Add commitlint configuration by Romain Deville ([`c5e1b15`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/c5e1b1508072980c50c787bd0ecc6baf830794fe)) 🔏
  * 🔨 Add cspell configuration by Romain Deville ([`f5c9158`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f5c91587614048d9f9da9acf248963fd29f82cc1)) 🔏
  * 🔨 Add pre-commit-config.yaml by Romain Deville ([`88b8b4e`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/88b8b4e3c36e06088e42d21e9e575993d2512147)) 🔏
  * 🔨 Add .editorconfig by Romain Deville ([`8be1297`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/8be1297bc5d1dda32d4fdbf83d19460f0eba2fd5)) 🔏
  * 🔨 Add .envrc by Romain Deville ([`84f5a4d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/84f5a4de773eb5145d2463a436139079de7c71bd)) 🔏
  * 🙈 Add .gitignore by Romain Deville ([`955469d`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/955469de99c18618903597041feaae6eab54d62e)) 🔏
  * 🙈 Add .gitignore by Romain Deville ([`f9f9fde`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/f9f9fdea913cb6b4feae493aaa974ef04b86116d)) 🔏

## v0.0.0 (2024-08-18)

### 🔊 Others

  * 🎉 Initial Commit by Romain Deville ([`1312109`](https://framagit.org/rdeville-private/dotfiles/nixos-config/-/commit/1312109f5250423f42d18dfa0805e4df872a2758)) 🔏
