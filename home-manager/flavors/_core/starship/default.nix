{lib, ...}: let
  colors = import ../../../../colors;
  black = "${colors.material-all.black}";
  sep = {
    left = "";
    right = "";
    clr = "${colors.material-all.grey_900}";
  };
  git = {
    bg = colors.material-all.brown_500;
    format = lib.concatStrings [
      "("
      "[${sep.left}](fg:${sep.clr} bg:${git.bg})"
      "[  ](fg:${colors.material-all.red_400} bg:${git.bg})"
      "$git_state"
      "$git_commit"
      "$git_branch"
      "$git_status"
      # "$git_metrics"
      "[ ](fg:${git.bg} bg:${git.bg})"
      "[${sep.left}](fg:${git.bg} bg:${black})"
      ")"
    ];
  };
  folder = {
    bg = "${colors.material-all.grey_900}";
    format = lib.concatStrings [
      # "[${sep.left}](fg:${sep.clr} bg:${folder.bg})"
      "\${custom.direnv}"
      "$nix_shell"
      "$directory"
      "[ ](fg:${folder.bg} bg:${folder.bg})"
      "[${sep.left}](fg:${folder.bg} bg:${black})"
    ];
  };
  stdin = {
    bg = "${colors.material-all.grey_800}";
    format = lib.concatStrings [
      "[${sep.left}](fg:${sep.clr} bg:${stdin.bg})"
      "$shlvl"
      "$shell"
      "$sudo"
      "[ ](fg:${sep.clr} bg:${stdin.bg})"
      "$character"
    ];
  };
in {
  programs = {
    starship = {
      enable = true;
      # See list of policies https://mozilla.github.io/policy-templates/
      settings = {
        # Timeout for starship to scan files (in milliseconds).
        scan_timeout = 30;
        # Timeout for commands executed by starship (in milliseconds).
        command_timeout = 500;
        # Inserts blank line between shell prompts.
        add_newline = true;
        # Follows symlinks to check if they're directories; used in modules such as git.
        follow_symlinks = true;

        # Module configurations
        battery = import ./battery.nix {inherit lib colors sep;};
        cmd_duration = import ./command_duration.nix {inherit lib colors sep;};
        character = import ./character.nix {inherit lib colors sep stdin;};
        container = import ./container.nix {inherit lib colors sep;};
        custom = {
          direnv = import ./custom/direnv.nix {inherit lib colors sep folder;};
        };
        directory = import ./directory.nix {inherit lib colors sep folder;};
        env_var = {
          keepass = import ./env_vars/keepass.nix {inherit lib colors sep folder;};
        };
        fill = import ./fill.nix {inherit lib colors sep;};
        gcloud = import ./gcloud.nix {inherit lib colors sep;};
        # hostname = import ./hostname.nix {inherit lib colors sep;};
        status = import ./status.nix {inherit lib colors sep;};
        # username = import ./username.nix {inherit lib colors sep;};
        git_branch = import ./git/branch.nix {inherit lib colors sep git;};
        git_commit = import ./git/commit.nix {inherit lib colors sep git;};
        git_state = import ./git/state.nix {inherit lib colors sep git;};
        git_metrics = import ./git/metrics.nix {inherit lib colors sep git;};
        git_status = import ./git/status.nix {inherit lib colors sep git;};
        kubernetes = import ./kubernetes.nix {inherit lib colors sep;};
        nix_shell = import ./nix-shell.nix {inherit lib colors sep folder;};
        nodejs = import ./nodejs.nix {inherit lib colors sep;};
        os = import ./os.nix {inherit lib colors sep;};
        package = import ./package.nix {inherit lib colors sep git;};
        python = import ./python.nix {inherit lib colors sep;};
        shell = import ./shell.nix {inherit lib colors sep;};
        shlvl = import ./shlvl.nix {inherit lib colors sep;};
        sudo = import ./sudo.nix {inherit lib colors sep;};
        terraform = import ./terraform.nix {inherit lib colors sep;};
        time = import ./time.nix {inherit lib colors sep;};

        # Configure the format of the right prompt.
        right_format = lib.concatStrings [
          "$status"
          "$cmd_duration"
        ];
        # Configure the format of the prompt.
        format = lib.concatStrings [
          "${folder.format}"
          "$fill"
          "$battery"
          "\${env_var.keepass}"
          "$username"
          "$hostname"
          "$os"
          "$container"
          "$time"
          "$line_break"
          "$nodejs"
          "$python"
          "$package"
          "${git.format}"
          "$fill"
          "$gcloud"
          "$kubernetes"
          "$terraform"
          "$line_break"
          "${stdin.format}"
        ];
      };
    };
  };
}
