# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = # Include the results of the hardware scan.
    [
      ./hardware-configuration.nix
    ];


  # Complementary options for hardware-configuration.nix. Hint: run nixos-generate-config --dir ~/tmp to create a fresh set of configuration.nix and hardware-configuration.nix.
    boot = { # Bootloader
      initrd.luks.devices."luks-e74bc2fe-fb37-4407-9592-0442f5c329bc".device = "/dev/disk/by-uuid/e74bc2fe-fb37-4407-9592-0442f5c329bc"; # Encrypted swap partition.
      loader = {
        # systemd-boot.configurationLimit = 5;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
        tmp.cleanOnBoot = true;
    };

      # Automatically mount the LUKS-encrypted internal storage
      systemd.services.ensure-run-media-corsair-dir = {
        description = "Ensure /run/media/corsair directory exists";
        wantedBy = [ "multi-user.target" ];
        serviceConfig.ExecStart = [
          "${pkgs.coreutils}/bin/mkdir -p /run/media/corsair"
          "${pkgs.coreutils}/bin/chown -R root:cig0 /run/media/corsair"
        ];
        # Ensure the service runs as root
        serviceConfig.User = "root";
        serviceConfig.Group = "root";
      };

      systemd.paths.ensure-run-media-corsair-dir = {
        description = "Path unit to trigger directory creation";
        pathConfig.PathExists = "/run/media/corsair";
        unitConfig.WantedBy = [ "multi-user.target" ];
      };

      environment.etc.crypttab.text = ''
        # Unlock the internal data storage as /dev/mapper/corsair
        corsair UUID=75e285f3-11c0-45f0-a3e7-a81270c22725 /root/.config/crypttab/corsair.key
      '';

      fileSystems = { # /etc/fstab mount options.
        "/" = {
          options = [ "commit=15" "data=journal" "discard" "errors=remount-ro" "noatime"  ];
        };
        "/run/media/corsair" = {
          device = "/dev/disk/by-uuid/ad32c7c0-ddba-4526-8d72-aa2948dac99b"; # /dev/mapper/data
          fsType = "xfs";
          label = "data";
          options = [ "allocsize=64m" "defaults" "discard" "inode64" "logbsize=256k" "logbufs=8" "noatime" "nodiratime" "nofail" "users" ];
        };
        "/home/cig0/media" = {
          device = "/run/media";
          fsType = "none";
          label = "data";
          options = [ "bind" ];
        };
      };

    swapDevices = [{
        device = "/dev/disk/by-uuid/0c641660-76fb-4b3d-8074-3a34c26de27f";
        priority = 1; # Set the lowest priority to allow zRAM to kick in before swapping to disk.
    }];

    services.fstrim.enable = true; # Enable periodic SSD TRIM of mounted partitions in background.


  nix = { # General settings
    settings = {
      allowed-users = [ "@builders" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  networking = { # Enable networking
    hostName = "perrrkele"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };
  };


  hardware = { # Enable bluetooth
    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };
  };


  # HARDENING - https://xeiaso.net/blog/paranoid-nixos-2021-07-18/
  security.sudo = {
    execWheelOnly = true;
    enable = true;
  };


  # LOCALE - Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };
    wireplumber.configPackages = [
	    (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
	    	  bluez_monitor.properties = {
	    	  	["bluez5.enable-sbc-xq"] = true,
	    	  	["bluez5.enable-msbc"] = true,
	    	  	["bluez5.enable-hw-volume"] = true,
	    	  	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
	    	  }
	    '')
    ];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}