{ config, pkgs, ... }:

{
  # Ensure Flathub is added if it is not already
  systemd.services.setup-flathub = {
    description = "Add Flathub remote for Flatpak";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
    };
  };

  # Install BlueBubbles from Flathub if it isn't already installed
  systemd.services.install-bluebubbles = {
    description = "Install BlueBubbles Flatpak App";
    wantedBy = [ "multi-user.target" ];
    after = [ "setup-flathub.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.flatpak}/bin/flatpak install -y --noninteractive flathub app.bluebubbles.BlueBubbles";
    };
    unitConfig.ConditionPathExists = "!/var/lib/flatpak/app/app.bluebubbles.BlueBubbles";
  };
}
