{ config, pkgs, ... }:

{
  # Enable gnome remote desktop
  systemd.services."gnome-remote-desktop".wantedBy = [ "graphical.target" ];

  # Create a oneshot service to get the certificates
  systemd.services.setup-gnome-rdp = {
    description = "One-time setup for GNOME Remote Desktop system RDP (cert + enable)";
    wantedBy = [ "multi-user.target" ];
    before = [ "display-manager.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      set -e

      if [ ! -f /var/lib/gnome-remote-desktop/rdp-tls.crt ]; then
        echo "[setup-gnome-rdp] Creating cert dir..."
        mkdir -p /var/lib/gnome-remote-desktop

        echo "[setup-gnome-rdp] Generating TLS cert..."
        ${pkgs.freerdp}/bin/winpr-makecert -silent -rdp -path /var/lib/gnome-remote-desktop rdp-tls

        echo "[setup-gnome-rdp] Enabling system RDP..."
        ${pkgs.gnome-remote-desktop}/bin/grdctl --system rdp enable

        echo "[setup-gnome-rdp] Setting TLS cert and key..."
        ${pkgs.gnome-remote-desktop}/bin/grdctl --system rdp set-tls-cert /var/lib/gnome-remote-desktop/rdp-tls.crt
        ${pkgs.gnome-remote-desktop}/bin/grdctl --system rdp set-tls-key /var/lib/gnome-remote-desktop/rdp-tls.key
      else
        echo "[setup-gnome-rdp] Cert already exists. Skipping setup."
      fi
    '';
  };
}