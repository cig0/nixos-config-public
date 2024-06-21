{ pkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu.ovmf = {
        packages = [ pkgs.OVMF.fd ];
      };
    };
  };
}