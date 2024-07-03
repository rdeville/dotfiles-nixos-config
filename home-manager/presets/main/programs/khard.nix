{
  config,
  lib,
  pkgs,
  nixpkgs,
  mkLib,
  ...
}: let
  khardContactsAccounts = builtins.filter (account:
    account.khard.enable) (
    builtins.attrValues config.accounts.contact.accounts
  );
  dataPath = config.accounts.contact.basePath;
  listNode =
    builtins.filter (account:
      builtins.pathExists "${dataPath}/${account}")
    # TODO: WILL NEED TO BE UPDATED TO khardContactsAccounts WHEN ISSUE BELOW IS RESOLVED
    (builtins.attrNames config.accounts.contact.accounts);
  addressbooks =
    builtins.map (
      account: let
        accountNode = builtins.readDir "${dataPath}/${account}";
        accountDir = builtins.filter (node: accountNode.${node} == "directory") (builtins.attrNames accountNode);
      in
        builtins.foldl' (acc: elem:
          {
            name = "${account}_${elem}";
            path = "${dataPath}/${account}/${elem}";
          }
          // acc) {}
        accountDir
    )
    listNode;
in {
  # DUE TO CURRENT BUG IN HOME-MANAGER ACCOUNTS AND KHARD, KHARD IS MANAGED
  # MANUALLY FOR THE MOMENT.
  # SEE : https://github.com/nix-community/home-manager/pull/5220
  home = {
    packages = with pkgs; [
      khard
    ];
  };
  xdg.configFile."khard/khard.conf".text = ''
    [addressbooks]
    ${lib.concatMapStringsSep "\n" (acc: ''
        [[${acc.name}]]
        path = ${acc.path}
      '')
      addressbooks}

    [general]
    debug = no
    default_action = list
    # These are either strings or comma seperated lists
    editor = vim, -i, NONE
    merge_editor = vimdiff

    [contact table]
    # Display names by first or last name: first_name / last_name / formatted_name
    display = first_name
    # Group by address book: yes / no
    group_by_addressbook = no
    # Reverse table ordering: yes / no
    reverse = no
    # Append nicknames to name column: yes / no
    show_nicknames = yes
    # Show uid table column: yes / no
    show_uids = no
    # Show kind table column: yes / no
    show_kinds = yes
    # Sort by first or last name: first_name / last_name / formatted_name
    sort = first_name
    # Localize dates: yes / no
    localize_dates = yes
    # Set a comma separated list of preferred phone number types in descending priority
    # or nothing for non-filtered alphabetical order
    preferred_phone_number_type = pref, cell, home
    # Set a comma separated list of preferred email address types in descending priority
    # or nothing for non-filtered alphabetical order
    preferred_email_address_type = pref, work, home

    [vcard]
    # extend contacts with your own private objects
    # these objects are stored with a leading "X-" before the object name in the vcard files
    # every object label may only contain letters, digits and the - character
    # example:
    #   private_objects = Jabber, Skype, Twitter
    # default: ,  (the empty list)
    # private_objects = Jabber, Skype, Twitter
    # Preferred vcard version: 3.0 / 4.0
    preferred_version = 4.0
    # Look into source vcf files to speed up search queries: yes / no
    search_in_source_files = yes
    # Skip unparsable vcard files: yes / no
    skip_unparsable = no
  '';

  # programs = {
  #   khard = {
  #     # TODO: MANUALLY ENABLED KHARD DUE TO ISSUE EXPLAINED BELOW
  #     # enable = khardContactsAccounts != [];
  #     enable = true;
  #     # Writing myself configuration link to accounts definition due to issue
  #     # with khard not able to discover contacts recursively.
  #     # See : https://github.com/nix-community/home-manager/pull/5220
  #     settings = {
  #       general = {
  #         default_action = "list";
  #       };
  #       # addressbooks = addressbooks;
  #       # addressbooks = builtins.foldl'(acc: elem: {} ()
  #       #   "${accountName}" = {}
  #       # }) khardContactsAccounts;
  #     };
  #   };
  # };
}
