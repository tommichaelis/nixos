{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkbVariant = "mac";
  services.xserver.xkbOptions = "terminate:ctrl_alt_bksp";
  services.xserver.multitouch = {
    enable = true;
    invertScroll = true;
    ignorePalm = true;
    buttonsMap = [ 1 0 3 ];
    additionalOptions = ''
      Option "Sensitivity" "0.3"
      Option "TapButton1" "1"
      Option "TapButton2" "1"
      Option "TapButton3" "1"
      Option "ButtonZonesEnabled" "true"
    '';
  };

  services.xserver.windowManager.stumpwm.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.resolutions = [
    {x = 1920; y = 1200; }
  ];

  services.xserver.xrandrHeads = [ "eDP1" "DP1" ];
}
