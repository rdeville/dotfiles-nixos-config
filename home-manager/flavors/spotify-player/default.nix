{
  userCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg =
    if userCfg.flavors ? spotify-player
    then config.spotify-player // userCfg.flavors.spotify-player
    else {
      enable = false;
    };
in {
  options = {
    spotify-player = {
      enable = lib.mkEnableOption "Install Spotify-Player Related Packages";
      audio_backend = lib.mkOption {
        type = lib.types.uniq lib.types.str;
        description = "Audio backend to use (default: rodio)";
        example = "pulseaudio";
        default = "rodio";
      };
      client_id_command = {
        type = lib.types.uniq lib.types.str;
        description = ''
          Command to get Personal client ID to use for the player.
          If you use nix-sops, this could be "cat /path/to/secrets/filename";
        '';
        example = "abcdefgh123456789";
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
          client_id_command = lib.mkIf (cfg ? client_id_command) cfg.client_id_command;
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
          default_device = userCfg.hostname;
          device = {
            name = userCfg.hostname;
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
