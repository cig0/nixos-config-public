{ unstablePkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu.ovmf = {
        packages = [ unstablePkgs.OVMF.fd ];
      };
    };
  };
}