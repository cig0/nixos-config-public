# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module

{ unstablePkgs, ... }:

{
  # Optionally, use home-manager.extraSpecialArgs to pass
  # arguments to home.nix
  home-manager = {
    backupFileExtension = "bkp";
    useGlobalPkgs = true; # Using global packages
    useUserPackages = true; # Allow user-specific packages

    users.cig0 = { ... }: {
      # Define user-specific packages and configurations
      home.packages = [
        # AI
        unstablePkgs.aichat
        unstablePkgs.lmstudio
        unstablePkgs.oterm

        # Comms
        unstablePkgs.element-desktop
        unstablePkgs.shortwave
        unstablePkgs.telegram-desktop
        unstablePkgs.zoom-us

        # Infrastructure: CNCF / K8s / OCI / virtualization
        unstablePkgs.openlens
        unstablePkgs.podman-desktop

        # Games
        unstablePkgs.naev

        # GNOME
        # gnomeExtensions.appindicator

        # KDE
        unstablePkgs.aha # Required by KDE's About this System
        # amarok
        unstablePkgs.kdePackages.alpaka
        unstablePkgs.kdePackages.discover
        unstablePkgs.kdePackages.kio-zeroconf
        unstablePkgs.kdePackages.kjournald
        unstablePkgs.qtcreator
        unstablePkgs.kdePackages.plasma-browser-integration
        unstablePkgs.kdePackages.yakuake

        # Multimedia
        unstablePkgs.ansel
        unstablePkgs.blender
        unstablePkgs.darktable
        unstablePkgs.davinci-resolve
        unstablePkgs.exiftool
        unstablePkgs.gimp
        unstablePkgs.imagemagick
        unstablePkgs.inkscape
        unstablePkgs.jp2a
        unstablePkgs.libheif
        unstablePkgs.mediainfo
        unstablePkgs.mpv
        unstablePkgs.nicotine-plus
        unstablePkgs.pngcrush
        unstablePkgs.shortwave
        unstablePkgs.yt-dlp

        # Networking - GUI
        unstablePkgs.wireshark-qt

        # Productivity
        unstablePkgs.obsidian
        unstablePkgs.todoist-electron

        # Programming - GUI
        unstablePkgs.imhex
        unstablePkgs.sublime-merge
        unstablePkgs.sublime4
        unstablePkgs.vscode-fhs

        # Security
          # GUI
          unstablePkgs.bitwarden
          unstablePkgs.keepassxc
          unstablePkgs.protonvpn-gui
          # Web
          unstablePkgs.burpsuite
          unstablePkgs.mitmproxy
          unstablePkgs.nikto

        # Storage - GUI
        unstablePkgs.vorta

        # Terminal utilities - GUI
        # unstablePkgs.warp-terminal

        # Virtualization - GUI
        unstablePkgs.virt-viewer

        # Web
        unstablePkgs.ungoogled-chromium
        unstablePkgs.librewolf
        unstablePkgs.tor-browser
        # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})

        # Everything else
        unstablePkgs.wiki-tui
      ];

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "23.11";
    };
  };
}