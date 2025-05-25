{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      libkrb5 alsa-lib cups libudev0-shim vulkan-loader
      (pkgs.pkgsi686Linux.alsa-lib)
      (pkgs.pkgsi686Linux.cups)
      (pkgs.pkgsi686Linux.libkrb5)
      (pkgs.pkgsi686Linux.vulkan-loader)
    ];
    fontPackages = with pkgs; [ noto-fonts ];
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [ mesa ];
  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [ mesa ];

  # Optional tools you might want
  environment.systemPackages = with pkgs; [
    steam-run gamemode mangohud protonup-qt
  ];
}