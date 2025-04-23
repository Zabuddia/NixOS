{ config, pkgs, lib, ... }:

let
  username = "buddia"; # change if needed
in
{
  options = { };

  config = {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    boot.kernelModules = [ "v4l2loopback" ];

    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    security.polkit.enable = true;

    users.users.${username}.packages = with pkgs; [
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          droidcam-obs
        ];
      })
    ];
  };
}