{
  programs.distrobox = {
    enable = true;
    enableSystemdUnit = true;

    containers = {
      debian = {
        image = "docker.io/library/debian:bookworm";
        extraPackages = [
          "sudo" "neofetch" "git" "curl" "htop"
          "wget" "lsb-release" "ca-certificates"
          "vim" "gnupg" "build-essential"
          "fonts-dejavu-core" "xdg-utils" "dbus-x11"
          "tree" "man-db" "iproute2" "strace"
          "python3" "python3-pip"
        ];
        init = true;
      };

      ubuntu = {
        image = "docker.io/library/ubuntu:24.04";
        extraPackages = [
          "sudo" "neofetch" "git" "curl" "htop"
          "wget" "lsb-release" "ca-certificates"
          "vim" "gnupg" "build-essential"
          "fonts-dejavu-core" "xdg-utils" "dbus-x11"
          "software-properties-common"
          "tree" "man-db" "iproute2" "strace"
          "python3" "python3-pip"
        ];
        init = true;
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/app-folders/folders/Remote" = {
      name = "Remote";
      apps = [
        "debian.desktop"
        "ubuntu.desktop"
      ];
    };
  };
}
