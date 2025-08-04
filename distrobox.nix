{
  programs.distrobox = {
    enable = true;
    enableSystemdUnit = true;

    containers = {
      debian = {
        image = "docker.io/library/debian:bookworm";
        extraPackages = [
          "sudo"
          "neofetch"
          "git"
        ];
        init = true;
      };

      ubuntu = {
        image = "docker.io/library/ubuntu:22.04";
        extraPackages = [
          "curl"
          "htop"
        ];
      };
    };
  };
}