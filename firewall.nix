{
  networking.extraHosts = ''
    # --- YouTube ---
    0.0.0.0 youtube.com www.youtube.com m.youtube.com youtu.be
    0.0.0.0 googlevideo.com i.ytimg.com yt3.ggpht.com youtubei.googleapis.com
    ::1     youtube.com www.youtube.com m.youtube.com youtu.be
    ::1     googlevideo.com i.ytimg.com yt3.ggpht.com youtubei.googleapis.com

    # --- Facebook ---
    0.0.0.0 facebook.com www.facebook.com m.facebook.com web.facebook.com
    0.0.0.0 fbcdn.net static.xx.fbcdn.net scontent.xx.fbcdn.net
    0.0.0.0 fbsbx.com edge-mqtt.facebook.com connect.facebook.net
    0.0.0.0 messenger.com www.messenger.com
    ::1     facebook.com www.facebook.com m.facebook.com web.facebook.com
    ::1     fbcdn.net static.xx.fbcdn.net scontent.xx.fbcdn.net
    ::1     fbsbx.com edge-mqtt.facebook.com connect.facebook.net
    ::1     messenger.com www.messenger.com
  '';
}
