# See:
# * https://mozilla.github.io/policy-templates
# * about:policies#documentation
{
  AppAutoUpdate = false;
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  BackgroundAppUpdate = false;
  DefaultDownloadDirectory = "$HOME/downloads";
  DisableAppUpdate = true;
  DNSOverHTTPS = {
    Enabled = true;
    ProviderURL = "https://ns1.fdn.fr/dns-query";
    Locked = true;
    ExcludedDomains = [];
    Fallback = true;
  };
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    Exceptions = [];
  };
  ExtensionSettings =
    (import ./policies.extensions.nix)
    // {
      "*" = {
        blocked_install_message = "Not Permitted to Install this type of addon";
        installation_mode = "blocked";
        "allowed_types" = [
          "theme"
          "dictionary"
        ];
      };
    };
  ExtensionUpdate = true;
  FirefoxHome = {
    Search = false;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
    Locked = true;
  };
  # TODO: @rdeville update handlers later, see:
  # https://mozilla.github.io/policy-templates/#handlers
  Handlers = {};
  Homepage = {
    StartPage = "none";
    Locked = true;
  };
  NewTabPage = false;
  NoDefaultBookmarks = true;
  OfferToSaveLogins = false;
  OverrideFirstRunPage = "";
  PasswordManagerEnabled = false;
  PDFjs = {
    Enabled = true;
    EnablePermissions = true;
  };
  Permissions = {
    Camera = {
      Allow = [];
      Block = [];
      BlockNewRequests = false;
      Locked = false;
    };
    Microphone = {
      Allow = [];
      Block = [];
      BlockNewRequests = false;
      Locked = false;
    };
    Location = {
      Allow = [];
      Block = [];
      BlockNewRequests = true;
      Locked = true;
    };
    Notifications = {
      Allow = [];
      Block = [];
      BlockNewRequests = true;
      Locked = true;
    };
    Autoplay = {
      Allow = [];
      Block = [];
      BlockNewRequests = false;
      Locked = true;
    };
    VirtualReality = {
      Allow = [];
      Block = [];
      BlockNewRequests = true;
      Locked = true;
    };
  };
  PictureInPicture = {
    Enabled = true;
    Locked = true;
  };
  PrimaryPassword = true;
  PrintingEnabled = true;
  PromptForDownloadLocation = true;
  RequestedLocales = [
    "en-US"
    "fr-FR"
  ];
  SanitizeOnShutdown = {
    Cache = true;
    Cookies = true;
    Downloads = true;
    FormData = true;
    History = false;
    Sessions = true;
    SiteSettings = false;
    OfflineApps = false;
    Locked = true;
  };
  # ONLY ON ESR
  # SearchEngines = {
  #   Default = "duckduckgo@search.mozilla.org";
  #   DefaultPrivate = "duckduckgo@search.mozilla.org";
  #   Remove = [
  #     "amazon@search.mozilla.org"
  #     "bing@search.mozilla.org"
  #     "qwant@search.mozilla.org"
  #   ];
  # };
  SearchBar = "unified";
  SearchSuggestEnabled = false;
  ShowHomeButton = true;
  StartDownloadsInTempDirectory = true;
  TranslateEnabled = false;
  UserMessaging = {
    WhatsNew = true;
    ExtensionRecommendations = false;
    FeatureRecommendations = false;
    UrlbarInterventions = false;
    SkipOnboarding = true;
    MoreFromMozilla = true;
    Locked = true;
  };
  UseSystemPrintDialog = true;
}
