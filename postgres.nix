{ config, pkgs, lib, ... }:

{

  services.postgresql = {
    dataDir = "/data/postgresql";
    package = pkgs.postgresql95;
    enableTCPIP = true;
    authentication = lib.mkForce ''
      local all         all              trust
      host  all         all 127.0.0.1/32 trust
      local replication all              trust
      host  replication all 127.0.0.1/32 trust
    '';
  };

  services.postgresql.enable = true;
}
