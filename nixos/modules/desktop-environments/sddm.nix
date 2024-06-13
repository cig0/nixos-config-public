{ ... }:

{
  services.displayManager = {
    autoLogin = {
      enable = false;
      user = "cig0";
    };
    defaultSession = "plasma";
    sddm = {
      # enable = true;
      enableHidpi = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
  };
}