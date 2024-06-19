# Energy saver

{ ... }:

{
  powerManagement = {
    enable = true;
    powertop.enable = false;
  };

  services.thermald.enable = true;
}