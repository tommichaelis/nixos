{ config, lib, pkgs, ... }:

{
  users.mutableUsers = false;

  users.extraUsers.tommichaelis = {
    isNormalUser = true;
    home = "/home/tommichaelis";    
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = *****
  };
}
