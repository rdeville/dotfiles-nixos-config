let
  persoAccounts = [
    "contact@romaindeville.fr"
    "contact@romaindeville.ovh"
  ];
in (import ./rey.nix {
  accounts = persoAccounts;
})
