# https://wiki.nixos.org/wiki/Linux_kernel

{ config, lib, pkgs, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };

  commonKernelSysctl = {
    # ref: https://wiki.archlinux.org/title/Gaming https://wiki.nixos.org/wiki/Linux_kernel
    "compaction_proactiveness" = false;
    "kernel.sysrq" = "1";
    "min_free_kbytes" = "1048576";
    "page_lock_unfairness" = true;
    "swappiness" = "10";
    "watermark_boost_factor" = true;
    "watermark_scale_factor" = "500";
  };

  commonKernelParams = [
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=0"
    "mem_sleep_default=deep"
    "mitigations=auto"
    "page_alloc.shuffle=1"
    "pti=on"
    "randomize_kstack_offset=on"
    "rd.driver.pre=vfio_pci"
    "rd.luks.options=discard"
    "rd.udev.log_level=2"                 # Print warnings and errors.
    "udev.log_level=1"                    # Print only error messages.
  ];
in
{
  hardware.tuxedo-keyboard.enable = false; # Tuxedo kernel parameters

  boot = {
    kernelPackages =
      if hostnameLogic.isRoleServer then pkgs.linuxPackages_hardened
      else if hostnameLogic.isRoleUser then pkgs.linuxPackages_latest
      else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

    kernel.sysctl =
      # net.ipv4.tcp_congestion_control: This parameter specifies the TCP congestion control algorithm to be used for managing congestion in TCP connections.

      if hostnameLogic.isVittusaatana || hostnameLogic.isRoleServer
        then commonKernelSysctl // { "net.ipv4.tcp_congestion_control" = "bbr"; }
        # bbr: A newer algorithm designed for higher throughput and lower latency.
      else if hostnameLogic.isTuxedoInfinityBook
        then commonKernelSysctl // { "net.ipv4.tcp_congestion_control" = "westwood"; }
        # westwood: Aimed at improving performance over wireless networks and other lossy links by using end-to-end bandwidth estimation.
      else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

    kernelParams =
      if hostnameLogic.isTuxedoInfinityBook || hostnameLogic.isChuweiMiniPC
        then commonKernelParams ++ [
        "fbcon=nodefer"                   # Prevent the kernel from blanking plymouth out of the framebuffer.
        "intel_pstate=disable"
        "i915.enable_fbc=1"
        "i915.enable_guc=3"
        "i915.enable_psr=1"
        "logo.nologo=0"
        "init_on_alloc=1"
        "init_on_free=1"
        "intel_iommu=sm_on"
        "iommu=pt"
        # "quiet"
      ]

    else {};

    kernelPatches = [{
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
  };
}


#===== REFERENCE
# kernelParams = [];
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
  #                    0: If you encounter stability issues or if your workload does not benefit from GuC/HuC usage, you might disable them.
  #                    1: If you want to benefit from improved graphics workload scheduling but do not need enhanced media handling.
  #                    3: If you want to take advantage of both improved workload scheduling and enhanced media handling.
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

  # Tuxedo-specific kernel paramenters
  # "tuxedo_keyboard.mode=0"
  # "tuxedo_keyboard.brightness=127"
  # "tuxedo_keyboard.color_left=0xff0a0a"

  # Nvidia
  # "nvidia_drm.fbdev=1"           # Enables the use of a framebuffer device for NVIDIA graphics. This can be useful for certain configurations.
  # "nvidia_drm.modeset=1"         # Enables kernel modesetting for NVIDIA graphics. This is essential for proper graphics support on NVIDIA GPUs.