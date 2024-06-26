{ lib, ... }:

{
  # Refs:
  # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  # https://wiki.nixos.org/wiki/Secure_Boot

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}