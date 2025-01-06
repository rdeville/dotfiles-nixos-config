{config, lib, ...}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  khardContactsAccounts = builtins.filter (account: account.khard.enable) (
    builtins.attrValues config.accounts.contact.accounts
  );
in lib.mkIf cfg.enable {
  programs = {
    khard = {
      enable = khardContactsAccounts != [];
      settings = {
        general = {
          debug = "no";
          default_action = "list";
          # These are either strings or comma seperated lists
          editor = "vim, -i, NONE";
          merge_editor = "vimdiff";
        };
        "contact table" = {
          # Display names by first or last name: first_name / last_name / formatted_name
          display = "first_name";
          # Group by address book: yes / no
          group_by_addressbook = "no";
          # Reverse table ordering: yes / no
          reverse = "no";
          # Append nicknames to name column: yes / no
          show_nicknames = "yes";
          # Show uid table column: yes / no
          show_uids = "no";
          # Show kind table column: yes / no
          show_kinds = "yes";
          # Sort by first or last name: first_name / last_name / formatted_name
          sort = "first_name";
          # Localize dates: yes / no
          localize_dates = "yes";
          # Set a comma separated list of preferred phone number types in descending priority
          # or nothing for non-filtered alphabetical order
          preferred_phone_number_type = "pref, cell, home";
          # Set a comma separated list of preferred email address types in descending priority
          # or nothing for non-filtered alphabetical order
          preferred_email_address_type = "pref, work, home";
        };
        vcard = {
          # extend contacts with your own private objects
          # these objects are stored with a leading "X-" before the object name in the vcard files
          # every object label may only contain letters, digits and the - character
          # example:
          #   private_objects = Jabber, Skype, Twitter
          # default: ,  (the empty list)
          # private_objects = Jabber, Skype, Twitter
          # Preferred vcard version: 3.0 / 4.0
          preferred_version = "4.0";
          # Look into source vcf files to speed up search queries: yes / no
          search_in_source_files = "yes";
          # Skip unparsable vcard files: yes / no
          skip_unparsable = "no";
        };
      };
    };
  };
}
