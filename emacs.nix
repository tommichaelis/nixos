{ config, pkgs, ... }:

{
  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    environment = {
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
    };
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
      ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.emacs.enable = true;
}