{ ... }:

{
  services.displayManager = {
    autoLogin = {
      enable = false;
    };
    sddm = { # The enablement option is managed from the flake.
      enableHidpi = true;
      wayland = {
        enable = true;
      };
    };
  };
}
