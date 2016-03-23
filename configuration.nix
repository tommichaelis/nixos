# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  nixpkgs.config = {
    allowUnfree = true;
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./xserver.nix
      ./users.nix
      ./yubikey.nix
      ./emacs.nix
      ./postgres.nix
    ];

  # load fbcon early in boot process
  boot.initrd.kernelModules = [ "fbcon" ];

  # register our root luks device
  boot.initrd.luks.devices = [
    {
      name = "rootfs";
      device = "/dev/sda5";
      preLVM = true;
    }
  ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
    
  networking = {
    hostName = "tom.michaelis";
    networkmanager.enable = true;
  };

  
  time = {
    timeZone = "Europe/London";
  };

  environment.systemPackages = with pkgs; [
    # Editors
    emacs

    # browsers
    firefox

    #utils
    mkpasswd
    pkgconfig
    git
    gcc
    gnumake
    htop
    wget
    curl
    acpi

    rxvt_unicode
  ];

  services.mopidy = {
    enable = true;
    extensionPackages = [ pkgs.mopidy-spotify pkgs.mopidy-moped ];
    configuration = ''
      [spotify]
      enabled = true
      username = tommichaelis
      password = media

      [mopify]
      enabled = true
      debug = true
    '';
  };
  powerManagement.enable = true;
  hardware.pulseaudio.enable = true;
  
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;

    fonts = [
       pkgs.terminus_font
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
