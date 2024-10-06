{
  cfg,
  userAccount,
  ...
}: {
  # inherit (userAccount)
  #     realName
  #     imap
  #     smtp
  #     aliases
  #     passwordCommand
  #     address
  #     userName
  #     primary
  #   ;
  # alot contactCompletion See [alot's wiki](http://alot.readthedocs.io/en/latest/configuration/contacts_completion.html)
  #
  # imapnotify = {
  #   # enable = true;
  #   # boxes
  #   # extraConfig
  #   # onNotifyPost
  #   # onNotify
  # };
  # mbsync = {
  #   # enable = true;
  #   # create = "both";
  #   # extraConfig = {};
  #   # expunge = false;
  #   # groups = {};
  #   # patterns = "*";
  #   # remove = false;
  #   # subFolders = [];
  # };
  # neomutt = {
  #   # enable = true;
  #   # extraConfig
  #   # extraMailboxes
  #   # mailboxName
  #   # mailboxType
  #   # sendMailCommand
  #   # showDefaultMailbox
  # };
  # notmuch = {
  #   # enable = false;
  #   # neomutt.enable
  #   # neomutt.virtualMailboxes.*.limit
  #   # neomutt.virtualMailboxes.*.name
  #   # neomutt.virtualMailboxes.*.query
  #   # neomutt.virtualMailboxes.*.type
  #   # neomutt.virtualMailboxes
  # };
  thunderbird = {
    enable =
      if userAccount.email ? thunderbird && userAccount.email.thunderbird ? enabled
      then userAccount.email.thunderbird.enabled
      else false;
    # settings
    # perIdentitySettings
    profiles = [cfg.username];
  };
}
