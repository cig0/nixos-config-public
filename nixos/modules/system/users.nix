{ ... }:

{
  users.mutableUsers = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cig0 = {
    isNormalUser = true;
    createHome = true;
    home = "/home/cig0";
    homeMode = "700";
    extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
    useDefaultShell = true;
    description = "This is me";
  };

  users.users.fine = {
    isNormalUser = true;
    createHome = true;
    home = "/home/fine";
    homeMode = "700";
    extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
    useDefaultShell = true;
    description = "This is fine";
  };

  # users.users.anotherUser = {
  #   isNormalUser = true;
  #   home = "/home/fine";
  #   description = "Fine";
  #   extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
  #   shell = "zsh";
  #   packages = with pkgs; [
  #     some_pckage
  #   ];
  # };
}
