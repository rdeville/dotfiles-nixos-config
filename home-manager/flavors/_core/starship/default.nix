{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};
in {
  imports = [
    ./modules
  ];

  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;

            scan_timeout = lib.mkOption {
              type = lib.types.int;
              description = "Timeout for starship to scan files (in milliseconds).";
              default = 30;
            };

            command_timeout = lib.mkOption {
              type = lib.types.int;
              description = "Timeout for commands executed by starship (in milliseconds).";
              default = 500;
            };

            add_newline = lib.mkOption {
              type = lib.types.bool;
              description = "Inserts blank line between shell prompts.";
              default = true;
            };

            follow_symlinks = lib.mkOption {
              type = lib.types.bool;
              description = "Follows symlinks to check if they're directories; used in modules such as git.";
              default = true;
            };

            right_format = lib.mkOption {
              type = lib.types.str;
              description = "Format of the right prompt.";
              default = lib.concatStrings [
                "$status"
                "$cmd_duration"
              ];
            };

            format = lib.mkOption {
              type = lib.types.str;
              description = "Format of the prompt.";
              default = lib.concatStrings [
                "\${custom.init}"
                "$direnv"
                "$nix_shell"
                "$directory"
                "\${custom.sep}"
                "$fill"
                "$battery"
                "\${env_var.keepass}"
                "$username"
                "$hostname"
                "$os"
                "$container"
                "$time"
                "$line_break"
                "\${custom.init}"
                "$kubernetes"
                "$nodejs"
                "$python"
                "$package"
                "("
                "\${custom.git_symbol}"
                "$git_state"
                "$git_commit"
                "$git_branch"
                "$git_status"
                "$git_metrics"
                ")"
                "\${custom.sep}"
                "$fill"
                "$gcloud"
                "$terraform"
                "$line_break"
                "\${custom.init}"
                "$shell"
                "$shlvl"
                "$sudo"
                "$character"
              ];
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      starship = {
        inherit (cfg) enable;
        # See list of policies https://mozilla.github.io/policy-templates/
        settings = {
          inherit
            (cfg)
            scan_timeout
            command_timeout
            add_newline
            follow_symlinks
            right_format
            format
            ;
        };
      };
    };
  };
}
