{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/shell" = {
    enabled-extensions = [
      "dash-to-dock@micxgx.gmail.com"
      "start-overlay-in-application-view@Hex_cz"
      "no-overview@fthx"
      "system-monitor@gnome-shell-extensions.gcampax.github.com"
      "status-icons@gnome-shell-extensions.gcampax.github.com"
      "drive-menu@gnome-shell-extensions.gcampax.github.com"
    ];
  };

    # Configure dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "LEFT";
      dock-fixed = true;
      extend-height = true;
      click-action = "minimize-or-overview";
    };
    
    # Pin apps to dock
    "org/gnome/shell" = {
      favorite-apps = [
        "code.desktop"
        "brave-browser.desktop"
        "app.bluebubbles.BlueBubbles.desktop"
        "org.gnome.Software.desktop"
        "org.gnome.TextEditor.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
    
    # Custom shortcut to open the Console
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Launch GNOME Console";
      binding = "<Control><Alt>T";
      command = "kgx";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    };
    
    # Get the minimize and maximize buttons back
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };
    
    # Make it so windows snap into place and dynamic workspaces and only primary display changes workspaces
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };
    
    # Tell GNOME which folders to show
    "org/gnome/desktop/app-folders" = {
      folder-children = [
        "Office"
        "Productivity"
        "SystemTools"
        "Security"
        "Media"
        "Remote"
        "GNOME"
        "DevTools"
      ];
    };

    # Define the folders
    "org/gnome/desktop/app-folders/folders/Office" = {
      name = "Office";
      apps = [
        "base.desktop"
        "calc.desktop"
        "draw.desktop"
        "impress.desktop"
        "math.desktop"
        "writer.desktop"
        "startcenter.desktop"
      ];
    };
    
    "org/gnome/desktop/app-folders/folders/Productivity" = {
      name = "Productivity";
      apps = [
        "org.gnome.clocks.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Characters.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/SystemTools" = {
      name = "System Tools";
      apps = [
        "org.gnome.SystemMonitor.desktop"
        "org.gnome.DiskUtility.desktop"
        "cups.desktop"
        "org.gnome.baobab.desktop"
        "org.gnome.Logs.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/Security" = {
      name = "Security";
      apps = [ "org.gnome.seahorse.Application.desktop" ];
    };

    "org/gnome/desktop/app-folders/folders/Media" = {
      name = "Media";
      apps = [
        "org.gnome.font-viewer.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.Evince.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.Music.desktop"
        "org.gnome.Snapshot.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/Remote" = {
      name = "Remote";
      apps = [ "org.gnome.Connections.desktop" ];
    };

    "org/gnome/desktop/app-folders/folders/GNOME" = {
      name = "GNOME";
      apps = [
        "org.gnome.Extensions.desktop"
        "yelp.desktop"
        "nixos-manual.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/DevTools" = {
      name = "Dev Tools";
      apps = [ "vim.desktop" ];
    };
  };
}
