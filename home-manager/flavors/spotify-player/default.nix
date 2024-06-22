{
  userCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  moduleCfg = userCfg.flavors.spotify-player;
in {
  options = {
    spotify-player = {
      enable = lib.mkEnableOption "Install Spotify-Player Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    programs = {
      spotify-player = {
        enable = true;
        # package = with pkgs; [ spotify-player ];
        package = pkgs.spotify-player.override {withAudioBackend = "pulseaudio";};
        settings = {
          theme = "dracula";
          client_id = "5ac4a3019524480dbd73b7bf729cc832";
          client_port = 8080;
          # tracks_playback_limit = 50;
          # app_refresh_duration_in_ms = 32;
          # playback_refresh_duration_in_ms = 0;
          # page_size_in_rows = 20;
          # play_icon = "▶";
          # pause_icon = "▌▌";
          # liked_icon = "❤️ ";
          # border_type = "Plain";
          # progress_bar_type = "Rectangle";
          # playback_window_position = "Top";
          # playback_window_width = 6;
          # enable_media_control = true;
          # notify_streaming_only = true;
          # enable_streaming = "always";
          # enable_cover_image_cache = false;
          default_device = userCfg.hostname;
          # copy_command = {
          #   command = "xclip";
          #   args = [
          #     "-sel"
          #     "c"
          #   ];
          # };
          device = {
            name = userCfg.hostname;
            backend = "pulseaudio";
            device_type = "speaker";
            volume = 100;
            bitrate = 320;
            # audio_cache = true;
            # normalization = false;
          };
        };
      };
    };
  };
}
