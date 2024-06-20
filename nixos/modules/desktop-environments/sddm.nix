{ ... }:

{
  services.displayManager = {
    autoLogin = {
      enable = false;
      user = "cig0";
    };
    defaultSession = "plasma";
    sddm = { # The enable option is managed from the flake.
      enableHidpi = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
  };
}