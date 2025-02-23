{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        docker
        docker-compose
      ];
    };

    programs = {
      zsh = {
        localVariables = {
          DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";
        };

        zsh-abbr = {
          abbreviations = {
            # Docker
            dkrmui =
              if config.hm.isDarwin
              then "docker images -q -f dangling=true | xargs docker rmi"
              else "docker images -q -f dangling=true | xargs -r docker rmi";
            dk = "docker";
            dklcid = "docker ps -l -q";
            dkps = "docker ps";
            dkpsa = "docker ps -a";
            dki = "docker images";
            dkrmall = "docker rm $(docker ps -a -q)";
            dkrm = "docker rm";
            dkrmiall = "docker rmi $(docker images -q)";
            dkrmi = "docker rmi";
            dkex = "docker exec -it";
            dkri = "docker run --rm -i";
            dkrit = "docker run --rm -it";
            dkip = "docker image prune -a -f";
            dkvp = "docker volume prune -f";
            dksp = "docker system prune -a -f";
            # Docker-Compose
            dco = "docker-compose";
            dcob = "docker-compose build";
            dcoe = "docker-compose exec";
            dcops = "docker-compose ps";
            dcorestart = "docker-compose restart";
            dcorm = "docker-compose rm";
            dcorun = "docker-compose run";
            dcostop = "docker-compose stop";
            dcoup = "docker-compose up";
            dcodown = "docker-compose down";
            dcopull = "docker-compose pull";
            dcostart = "docker-compose start";
            dcolog = "docker-compose logs -f --tail 100";
          };
        };
      };
    };
  };
}
