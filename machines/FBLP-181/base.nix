{
  # system = "x86_64-linux";
  system = "aarch64-darwin";
  hostName = builtins.baseNameOf ./.;
  isGui = true;
  isMain = true;
  isDarwin = true;
  isWork = true;
}
