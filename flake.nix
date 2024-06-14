{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    auto-cpufreq = { # Energy efficiency
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

    # home-manager = { # Maybe in the future
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    #   url = "github:nix-community/home-manager";
    # };

    lanzaboote = {
      inputs.nixpkgs.follows = "nixpkgs"; # Optional but recommended to limit the size of your system closure.
      url = "github:nix-community/lanzaboote/v0.3.0";
    };

    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.4.1.tar.gz"; # Declarative Flatpak management

    # nixos-cosmic = {
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    #   url = "github:lilyinstarlight/nixos-cosmic";
    # };

    nix-index.url = "github:nix-community/nix-index";

    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database"; # TODO: review
    };

    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1.1656.tar.gz"; # Hardware-specific optimizations

    nixvim = { # The intended way to configure Neovim?
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };

    rust-overlay.url = "github:oxalica/rust-overlay"; # Crabby dancing sideways

    # sops-nix.url = "github:Mic92/sops-nix"; # Secure secrets
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable,
    auto-cpufreq,             # Energy efficiency.configDir
    # home-manager,             # User-specific settings and packages
    lanzaboote,               # Secure Boot for NixOS
    nix-flatpak,              # Enhanced Flatpak support
    nix-index,                # A files database for nixpkgs
    # nix-index-database,       # A files database for nixpkgs
    # nixos-cosmic,             # COSMIC Desktop Environment
    nixos-hardware,           # Hardware configuration
    nixvim,                   # Neovim configuration
    rust-overlay,             # Rust overlay
    # sops-nix,                 # SOPS for managing secrets
  ... }:

  let
    commonModules = [
        auto-cpufreq.nixosModules.default
        ./nixos/modules/power-management/auto-cpufreq.nix

        # home-manager.nixosModules.home-manager

        lanzaboote.nixosModules.lanzaboote
        ({ lib, ... }: {
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
        })

        # nix-index-database.nixosModules.nix-index
        # { programs.nix-index-database.comma.enable = true; }

        nixvim.nixosModules.nixvim
        ./nixos/modules/applications/nixvim.nix

        ({ pkgs, ... }: { # Rust
          nixpkgs.overlays = [ rust-overlay.overlays.default ];
          environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
        })

        # sops-nix.nixosModules.sops
        # ./nixos/modules/security/sops.nix

      ./nixos/modules/applications/applications.nix
      ./nixos/modules/applications/current-system-packages.nix
      ./nixos/modules/applications/ollama.nix
      ./nixos/modules/applications/syncthing.nix
      ./nixos/modules/networking/dns.nix
      ./nixos/modules/networking/stevenblack.nix
      ./nixos/modules/networking/stevenblack-unblacklist.nix
      ./nixos/modules/networking/tailscale.nix
      ./nixos/modules/observability/observability.nix
      ./nixos/modules/power-management/power-management.nix
      ./nixos/modules/security/firewall.nix
      ./nixos/modules/security/openssh.nix
      ./nixos/modules/shell/starship.nix
      ./nixos/modules/shell/zsh.nix
      ./nixos/modules/system/cups.nix
      ./nixos/modules/system/fwupd.nix
      ./nixos/modules/system/gnupg.nix
      ./nixos/modules/system/hwaccel.nix
      ./nixos/modules/system/kernel.nix
      ./nixos/modules/system/keyd.nix
      ./nixos/modules/system/maintenance.nix
      ./nixos/modules/system/ucode.nix
      ./nixos/modules/system/users.nix
      ./nixos/modules/system/zram.nix
      ./nixos/modules/time-and-date/ntp.nix
      ./nixos/modules/time-and-date/timezone.nix
      ./nixos/modules/virtualization/containerization.nix
      ./nixos/modules/virtualization/incus.nix
      ./nixos/modules/virtualization/libvirt.nix
      ./nixos/overlays/overlays.nix
    ];

    userSideModules = [
        # nixos-cosmic.nixosModules.default
        # ./nixos/modules/desktop-environments/cosmic.nix

        nix-flatpak.nixosModules.nix-flatpak
        ./nixos/modules/applications/nix-flatpak.nix

      ./nixos/modules/system/fonts.nix
      ./nixos/modules/desktop-environments/kdeconnect.nix
      ./nixos/modules/desktop-environments/sddm.nix
      ./nixos/modules/desktop-environments/xdg-desktop-portal.nix
    ];

    system = "x86_64-linux";

    unstablePkgs = import "${nixpkgs-unstable}" {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "openssl-1.1.1w" ]; # Sublime 4
      };
    };
  in
  {
    nixosConfigurations = {
      satama = nixpkgs.lib.nixosSystem { # headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
        inherit system;
        specialArgs = { inherit inputs system unstablePkgs; };
        modules = commonModules ++ [
          # Main configuration file
          ./nixos/hosts/satama/configuration.nix

          {
          }
        ];
      };

      perrrkele = nixpkgs.lib.nixosSystem { # laptop: Intel CPU & GPU
        inherit system;
        specialArgs = { inherit inputs system unstablePkgs; };
        modules = commonModules ++ userSideModules ++ [
          nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7

          # Main configuration file
          ./nixos/hosts/perrrkele/configuration.nix

          {
            services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
            programs.dconf.enable = true; # https://nixos.wiki/wiki/KDE#Installation

            # ===== DISPLAY MANAGERS =====
            # Only one at a time can be active
              #####  THIRD-PARTY MODULES  #####
              # services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
            services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
          }

        ];
      };

      vittusaatana = nixpkgs.lib.nixosSystem { # desktop: Intel CPU, Nvidia GPU
        inherit system;
        specialArgs = { inherit inputs system unstablePkgs; };
        modules = commonModules ++ userSideModules ++ [
          # Main configuration file
          ./nixos/hosts/vittusaatana/configuration.nix

          {
            services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
            programs.dconf.enable = true; # https://nixos.wiki/wiki/KDE#Installation

            # ===== DISPLAY MANAGERS =====
            # Only one at a time can be active
              #####  THIRD-PARTY MODULES  #####
              # services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
            services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
          }

          # TODO: Nvidia drivers
        ];
      };
    };
  };
}