{
  config,
  lib,
  ...
}: let
  name = "python";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.light_green_500;
  fg = mkLib.colors.grey_900;
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";

    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "left";
    };
  };

  config = {
    programs = {
      starship = {
        settings = {
          ${name} = {
            inherit
              (cfg)
              disabled
              ;
            # A format string representing the symbol of Python
            symbol = "󰌠 ";
            # The version format. Available vars are raw, major, minor, & patch
            version_format = "v\${raw}";
            # Use pyenv to get Python version
            pyenv_version_name = false;
            # Prefix before pyenv version display, only used if pyenv is used
            pyenv_prefix = "pyenv";
            # Configures the python binaries that Starship should executes when getting the version.
            python_binary = ["python" "python3" "python2"];
            # Which extensions should trigger this module
            detect_extensions = ["py"];
            # Which filenames should trigger this module
            detect_files = [".python-version" "Pipfile" "__init__.py" "pyproject.toml" "requirements.txt" "setup.py" "tox.ini"];
            # Which folders should trigger this module
            detect_folders = [];
            # The style of the module.
            style = "bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol$version:$virtualenv ]($style)"
            ];
          };
        };
      };
    };
  };
}
