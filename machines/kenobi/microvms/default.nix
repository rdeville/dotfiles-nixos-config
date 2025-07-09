{...}: {
  imports = [
    ./k8s-dev
    ./k8s-stg
    ./k8s-prd
  ];

  services = {
    nginx = {
      enable = true;

      virtualHosts = {
        "*.tekunix.cloud" = {
          listen = [
            {
              addr = "89.234.140.170";
              port = 80;
            }
            {
              addr = "89.234.140.170";
              port = 443;
            }
          ];

          locations = {
            "/robots.txt" = {
              extraConfig = ''
                rewrite ^/(.*)  $1;
                return 200 "User-agent: *\nDisallow: /";
              '';
            };
          };
        };
      };
    };
  };
}
