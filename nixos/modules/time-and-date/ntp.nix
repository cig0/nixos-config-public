# https://wiki.nixos.org/wiki/NTP

{ ... }:

{
  networking.timeServers = [
    "1.ar.pool.ntp.org"
    "1.south-america.pool.ntp.org"
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
  ];
}