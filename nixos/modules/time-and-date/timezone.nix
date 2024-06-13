{ config, lib, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };
in
{
  time.timeZone =
    if hostnameLogic.isPerrrkele then
      "America/Argentina/Buenos_Aires"

    else if hostnameLogic.isSatama then
      "America/Argentina/Buenos_Aires"

    else if hostnameLogic.isVittusaatana then
      "America/Argentina/Buenos_Aires"

    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
}