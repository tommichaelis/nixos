{ config, pkgs, lib, ... }:

{
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

}
