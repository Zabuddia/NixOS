# In configuration.nix or a separate .nix module
{ config, pkgs, ... }:

{
  networking.firewall = {
    enable = true;
    extraCommands = ''
      # Create table if it doesn't exist
      nft list tables | grep -q "inet filter" || nft add table inet filter

      # Create output chain if it doesn't exist
      nft list chain inet filter output >/dev/null 2>&1 || \
        nft add chain inet filter output { type filter hook output priority 0; }

      # Facebook IP ranges
      nft add rule inet filter output ip daddr 31.13.0.0/16 drop
      nft add rule inet filter output ip daddr 157.240.0.0/16 drop
      nft add rule inet filter output ip daddr 69.63.0.0/16 drop
      nft add rule inet filter output ip daddr 66.220.0.0/16 drop
    '';
  };
}
