{ pkgs, ... }:

{
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.plymouth.theme = "evil-nixos";
  boot.plymouth.font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
  # boot.plymouth.themePackages = [ (pkgs.callPackage inputs.plymouth-is-underrated.outPath {}) ];
  boot.plymouth.themePackages = [ (pkgs.callPackage "/etc/nixos/modules/plymouth-is-underrated" {}) ];
}