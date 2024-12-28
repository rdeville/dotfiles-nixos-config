{
  config,
  pkgs,
  lib,
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
          audio_backend = lib.mkOption {
            type = lib.types.uniq lib.types.str;
            description = "Audio backend to use (default: rodio)";
            example = "pulseaudio";
            default = "rodio";
          };
          client_id_command = lib.mkOption {
            type = lib.types.uniq lib.types.str;
            description = ''
              Command to get Personal client ID to use for the player.
              If you use nix-sops, this could be "cat /path/to/secrets/filename";
            '';
            example = "abcdefgh123456789";
            default = "";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      spotify-player = {
        enable = true;
        package = pkgs.spotify-player.override {
          withAudioBackend = cfg.audio_backend;
        };
        settings = {
          theme = "dracula";
          client_id_command = cfg.client_id_command;
          client_port = 8080;
          playback_format = "
            {track} • {artists}
            {album}
            {metadata}";
          tracks_playback_limit = 50;
          app_refresh_duration_in_ms = 32;
          playback_refresh_duration_in_ms = 0;
          page_size_in_rows = 20;
          border_type = "Plain";
          progress_bar_type = "Rectangle";
          playback_window_position = "Top";
          playback_window_width = 6;
          enable_media_control = true;
          notify_streaming_only = true;
          enable_streaming = "Always";
          enable_cover_image_cache = false;
          default_device = config.hm.hostname;
          device = {
            name = config.hm.hostname;
            backend = cfg.audio_backend;
            device_type = "speaker";
            volume = 100;
            bitrate = 320;
            audio_cache = true;
            normalization = false;
          };
        };
      };
    };
  };
}
