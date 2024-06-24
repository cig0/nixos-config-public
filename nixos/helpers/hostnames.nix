# Hosts mapping.

{ config, lib, ... }:

let
  inherit (lib) mkIf;
  hostName = config.networking.hostName; # Extra fail-check.
in
rec {
  # Export mkIf for reuse.
  mkIf = lib.mkIf;

  # ====  Define truthiness for the hosts and logical groupings

    # Individual hosts definition.
    isPerrrkele = hostName == "perrrkele";
    isSatama = hostName == "satama";
    isVittusaatana = hostName == "vittusaatana";

    # Logical groupings
      # By hardware
      isChuweiMiniPC = isSatama;
      isDesktop = isVittusaatana;
      isTuxedoInfinityBook = isPerrrkele;

      # Hosts groupings.
      isIntelGPUHost = isChuweiMiniPC || isTuxedoInfinityBook;  # Combined condition for Intel iGPU hosts.
      isRoleServer = isChuweiMiniPC;
      isRoleUser = isDesktop || isTuxedoInfinityBook;  # Combined condition for user-side hosts.
}


# Notes & examples
# ----------------
#
# - Don't forget to add `config, lib,` to the module you will be importing this module from
# - MYHOST -> proper hostname


# let
#   hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };
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