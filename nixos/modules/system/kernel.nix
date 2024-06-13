{ pkgs, ... }:

{
  # TODO: add hostnameLogic for specific per-host settings
  # I.e:
  #   - satama: LTS kernel
  #   - vittu: Nvidia drivers

  # https://wiki.nixos.org/wiki/Linux_kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Kernel args
  hardware.tuxedo-keyboard.enable = false; # Tuxedo

  boot.kernel.sysctl = {
    # ref: https://wiki.archlinux.org/title/Gaming
    # ref: https://wiki.nixos.org/wiki/Linux_kernel
    "compaction_proactiveness" = false;
    "kernel.sysrq" = "1";
    "min_free_kbytes" = "1048576";
    "page_lock_unfairness" = true;
    "swappiness" = "10";
    "watermark_boost_factor" = true;
    "watermark_scale_factor" = "500";
  };
  boot.kernelParams = [
    # Keyboard and Lighting:
    #    tuxedo_keyboard.mode=0 (likely specific to Tuxedo brand keyboards): This argument might control the keyboard mode. Without more information about Tuxedo keyboards, it's difficult to predict the exact behavior.
    #    tuxedo_keyboard.brightness=255 (likely specific to Tuxedo brand keyboards): This sets the keyboard brightness to maximum (255).
    #    tuxedo_keyboard.color_left=0xff0a0a (likely specific to Tuxedo brand keyboards with RGB lighting): This sets the left-side lighting color to a shade of red (hex code #ff0a0a).

    # Power Management and Memory:
    #    mem_sleep_default=deep : This instructs the system to use the deepest possible sleep state for memory when inactive, potentially saving power.
    #    init_on_alloc=1 & init_on_free=1: These arguments might be related to memory initialization/finalization behavior during allocation and freeing. Their specific impact depends on your kernel version and system configuration. Consult kernel documentation for details.

    # Graphics (assuming you have Intel integrated graphics):
    #    i915.enable_fbc=1: Enables Frame Buffer Compression (FBC) for potentially improved video memory usage.
    #    i915.enable_guc=2: Enables the Graphics UCC (Unified Command Center) at level 2, potentially offering more advanced graphics features.
    #    i915.enable_psr=1: Enables Panel Self Refresh (PSR) for potentially reduced power consumption by the display.

    # Storage Encryption (if using LUKS):
    #    rd.luks.options=discard: This tells the LUKS (Linux Unified Key Setup) encryption layer to issue discard commands to the underlying storage when blocks are freed. This can improve performance but might not be supported by all storage devices.

    # Security:
    #    pti=on: Enables protection against certain processor vulnerabilities (like Meltdown).
    #    mitigations=auto: Enables various automated security mitigations based on your system configuration.
    #    randomize_kstack_offset=on: Randomizes the kernel stack location for additional security.

    # Virtualization:
    #    kvm.ignore_msrs=1: Silently ignores unsupported Model-Specific Registers (MSRs) accessed by guest VMs running under KVM. This can improve performance but might mask potential issues if VMs rely on specific MSRs.
    #    kvm.report_ignored_msrs=0: Prevents logging messages about ignored MSRs, reducing clutter in system logs.
    #    rd.driver.pre=vfio_pci: Loads the VFIO PCI driver early during boot, crucial for GPU pass-through to VMs using VFIO.

    # Memory Management:
    #    page_alloc.shuffle=1: Randomizes physical memory page allocation, potentially improving security.
    #    iommu=pt (with caution): Enables IOMMU pass-through for devices assigned to VMs. This can improve performance for VMs using these devices, but verify compatibility and consider using intel_iommu=sm_on instead (see below).

    # "tuxedo_keyboard.mode=0"
    # "tuxedo_keyboard.brightness=127"
    # "tuxedo_keyboard.color_left=0xff0a0a"
    "intel_pstate=disable"
    "mem_sleep_default=deep"
    "i915.enable_fbc=1"
    "i915.enable_guc=2"
    "i915.enable_psr=1"
    "rd.luks.options=discard"
    "init_on_alloc=1"
    "init_on_free=1"
    "intel_iommu=sm_on"
    "iommu=pt"
    "page_alloc.shuffle=1"
    "randomize_kstack_offset=on"
    "pti=on"
    "mitigations=auto"
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=0"
    "rd.driver.pre=vfio_pci"
    "logo.nologo=0"
    "splash"
    # "video=uvesafb:1024x768-16@60"
    # "quiet"
  ];
  boot.kernelPatches = [{
    name = "tux-logo";
    patch = null;
    extraConfig = ''
      FRAMEBUFFER_CONSOLE y
      LOGO y
      LOGO_LINUX_MONO y
      LOGO_LINUX_VGA16 y
      LOGO_LINUX_CLUT224 y
    '';
  }];
}
