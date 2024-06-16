{ config, lib, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };
in
{
  services.zram-generator.enable = true;
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent =
      if hostnameLogic.isChuweiMiniPC then 5
      else if hostnameLogic.isDesktop then 25
      else if hostnameLogic.isTuxedoInfinityBook then 15
      else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
  };
}