{ config, pkgs, lib, userSettings, ... }:

{
  config = {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    boot.kernelModules = [ "v4l2loopback" ];

    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="DroidCam" exclusive_caps=1
    '';

    security.polkit.enable = true;

    users.users.${userSettings.username}.packages = with pkgs; [
      droidcam
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          droidcam-obs
        ];
      })
    ];
  };
}