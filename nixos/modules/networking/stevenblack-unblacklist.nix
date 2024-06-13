# https://github.com/StevenBlack/hosts
{ pkgs, ... }:

{
  systemd.services.stevenblack-unblacklist = {
    description = "Unblock a few domains from the StevenBlack block lists";
    after = ["multi-user.target"];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.gnused}/bin/sed -i -e '/reddit/d' -e '/whatsapp/d' -e '/linkedin/d' -e '/licdn.com/d' /etc/hosts";
    };
  };
}