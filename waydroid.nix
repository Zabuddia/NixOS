{ config, pkgs, lib, ... }:

{
  hardware.graphics.enable = true;
  virtualisation.waydroid.enable = true;

  systemd.user.services.organize-waydroid-apps = {
    description = "Put Waydroid apps into the GNOME Waydroid folder (Waydroid.desktop first)";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    path = [ pkgs.glib pkgs.coreutils pkgs.bash ];
    serviceConfig.Type = "oneshot";

    script = ''
      set -euo pipefail
      FOLDER="org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Waydroid/"
      APPDIR="$HOME/.local/share/applications"

      # Build ordered list: Waydroid.desktop FIRST (if present), then all waydroid*.desktop
      declare -a ordered=()

      if [ -f "$APPDIR/Waydroid.desktop" ]; then
        ordered+=( "Waydroid.desktop" )
      fi

      shopt -s nullglob
      for f in "$APPDIR"/waydroid*.desktop; do
        base="$(basename "$f")"
        # Skip if it's exactly Waydroid.desktop (already added) or already present
        if [ "$base" != "Waydroid.desktop" ]; then
          # de-dup
          skip=0
          for e in "''${ordered[@]}"; do
            [ "$e" = "$base" ] && { skip=1; break; }
          done
          [ $skip -eq 0 ] && ordered+=( "$base" )
        fi
      done
      shopt -u nullglob

      # Turn array into gsettings JSON-like array (["a.desktop","b.desktop"])
      if [ "''${#ordered[@]}" -eq 0 ]; then
        apps_list="[]"
      else
        apps_list="[\"''${ordered[0]}\"]"
        for ((i=1; i<''${#ordered[@]}; i++)); do
          apps_list="''${apps_list%]},"\"''${ordered[$i]}\""]"
        done
      fi

      # Ensure folder + set name and app list
      gsettings set "$FOLDER" name 'Waydroid' || true
      gsettings set "$FOLDER" apps "$apps_list"
    '';
  };

  # Optional: live-update whenever .desktop files change
  # systemd.user.paths.organize-waydroid-apps-watch = {
  #   description = "Watch Waydroid .desktop files and update folder";
  #   unit = "organize-waydroid-apps.service";
  #   pathConfig = { PathChanged = "%h/.local/share/applications"; };
  #   wantedBy = [ "graphical-session.target" ];
  # };
}