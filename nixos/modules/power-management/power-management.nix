# Energy saver

{ ... }:

{
  powerManagement = {
    enable = true;
    powertop.enable = false; # Need to troubleshoot the configured settings, as my wired external keyboard continously goes into low-power mode.
  };

  services.thermald.enable = true;
}