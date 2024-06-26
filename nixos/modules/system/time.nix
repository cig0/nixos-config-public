# TODO dynamically configure NTP pool depending on timezonne/region

{ config, lib, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };

  commonNTPPool = [
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
  ];

  argentinaNTPPool = [
    "1.ar.pool.ntp.org"
    "0.south-america.pool.ntp.org"
  ];

  naNTPPool = [
    "0.north-america.pool.ntp.org"
  ];

  euNTPPool = [
    "0.europe.pool.ntp.org"
  ];
in
{
  # Set NTP servers pool
  networking.timeServers = argentinaNTPPool ++ commonNTPPool;

  time.timeZone =
    if hostnameLogic.isPerrrkele then
      "America/Argentina/Buenos_Aires"

    else if hostnameLogic.isSatama then
      "America/Argentina/Buenos_Aires"

    else if hostnameLogic.isVittusaatana then
      "America/Argentina/Buenos_Aires"

    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

  # Dynamically set the timezone
  # services = {
  #   automatic-timezoned.enable = true;
  #   localtimed.enable = true;
  #   tzupdate.enable = true;
  # };
}