# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
 # Note!!! Home Manageer is configured to use the unstable release channel, defined in the flake.

# { modulesPath, unstablePkgs, ... }:
{ unstablePkgs, ... }:

{
  # imports = [
  #   (modulesPath + "/profiles/minimal.nix")
  # ];

  home-manager = {
    backupFileExtension = "bkp";
    useGlobalPkgs = false;
    useUserPackages = true;
    users = {
      cig0 = { ... }: {
        # Define user-specific packages and configurations
        home.packages = with unstablePkgs; [
          # AI
          aichat
          (lmstudio.override {
            commandLineArgs = [
              "--enable-features=VaapiVideoDecodeLinuxGL"
              "--ignore-gpu-blocklist"
              "--enable-zero-copy"
              "--enable-features=UseOzonePlatform"
              "--ozone-platform=wayland"
            ];
          })
          oterm

          # Comms
          element-desktop
          shortwave
          telegram-desktop
          zoom-us

          # Infrastructure: CNCF / K8s / OCI / virtualization
          openlens
          podman-desktop

          # Games
          naev

          # Multimedia
          blender
          cinelerra
          darktable
          davinci-resolve
          exiftool
          gimp
          imagemagick
          inkscape
          jp2a
          libheif
          lightworks
          mediainfo
          mpv
          nicotine-plus
          olive-editor
          openshot-qt
          pngcrush
          rawtherapee
          shortwave
          shotcut
          yt-dlp

          # Networking
          wireshark-qt

          # Productivity
          (obsidian.override {
            commandLineArgs = [
              "--enable-features=VaapiVideoDecodeLinuxGL"
              "--ignore-gpu-blocklist"
              "--enable-zero-copy"
              "--enable-features=UseOzonePlatform"
              "--ozone-platform=wayland"
            ];
          })
          todoist-electron

          # Programming
          imhex
          sublime-merge
          sublime4
          vscode-fhs

          # Security
          bitwarden
          keepassxc
          kpcli
          protonvpn-cli
          protonvpn-gui
            # Web
            burpsuite
            mitmproxy
            nikto

          # Storage
          vorta

          # Virtualization
          virt-viewer

          # Web
          librewolf
          tor-browser
          # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})

          # Everything else
          terminal-parrot
          wiki-tui
          zola
        ];

        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "23.11";
      };

      fine = { ... }: {
        home.packages = with unstablePkgs; [
        ];

        home.stateVersion = "23.11";
      };
    };
  };
}