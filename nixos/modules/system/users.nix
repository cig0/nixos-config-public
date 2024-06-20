{ pkgs, ... }:

{
  users.mutableUsers = true;

  # User: cig0
  users.users.cig0 = {
    shell = pkgs.zsh;
    isNormalUser = true;
    createHome = true;
    home = "/home/cig0";
    homeMode = "700";
    extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
    useDefaultShell = true;
    description = "This is me";
  };

  # User: fine
  users.users.fine = {
    isNormalUser = true;
    createHome = true;
    home = "/home/fine";
    homeMode = "700";
    extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
    useDefaultShell = true;
    description = "This is fine";
  };

  # anotherUser
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