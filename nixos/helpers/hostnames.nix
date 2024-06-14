# Hosts mapping.

{ config, lib, ... }:

let
  inherit (lib) mkIf;
  hostName = config.networking.hostName;
in
rec {
  # Export mkIf for reuse.
  mkIf = lib.mkIf;

  # Individual hosts definition.
  isPerrrkele = hostName == "perrrkele";
  isSatama = hostName == "satama";
  isVittusaatana = hostName == "vittusaatana";

  # Hosts grouping definition.
  isIntelHost = isPerrrkele || isSatama;  # Combined condition for Intel iGPU hosts.
  isUserSideHost = isPerrrkele || isVittusaatana;  # Combined condition for user-side hosts.
}


# Notes & examples
# ----------------
#
# - Don't forget to add `config, lib,` to the module you will be importing this module from
# - MYHOST -> proper hostname


# let
#   hostnameLogic = import ../helpers/hostnames.nix { inherit config lib; };
# in
#

  # {
  #   myFunction = hostnameLogic.mkIf hostnameLogic.isMYHOST {
  #     ...
  #   };
  # }

  # {
  #  myFunction =
  #    if hostnameLogic.isPerrrkele then
  #      something
  #    else if hostnameLogic.isSatama then
  #      "something else"
  #    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
  # }