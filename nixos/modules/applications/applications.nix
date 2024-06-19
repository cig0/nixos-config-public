{ config, lib, pkgs, unstablePkgs, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };

  commonPackages = [ # Packages common to all hosts
    # Comms
    unstablePkgs.discordo
    unstablePkgs.iamb
    unstablePkgs.weechat

    # IaaS / PaaS / SaaS
    unstablePkgs.awscli2
    unstablePkgs.eksctl

    # Infrastructure: CNCF / K8s / OCI / virtualization
    unstablePkgs.argocd
    unstablePkgs.boxbuddy
    unstablePkgs.cosign
    unstablePkgs.crc
    unstablePkgs.distrobox
    unstablePkgs.k3d
    unstablePkgs.k9s
    unstablePkgs.kind
    unstablePkgs.krew
    unstablePkgs.kube-bench
    unstablePkgs.kubecolor
    unstablePkgs.kubectl
    unstablePkgs.kubernetes-helm
    unstablePkgs.kubeswitch
    unstablePkgs.minikube
    unstablePkgs.odo # odo is a CLI tool for fast iterative application development deployed immediately to your kubernetes cluster.
                     # https://odo.dev
    unstablePkgs.opentofu
    unstablePkgs.packer
    unstablePkgs.podman-compose
    unstablePkgs.podman-tui
    unstablePkgs.telepresence2
    unstablePkgs.terraformer
    unstablePkgs.tf-summarize
    unstablePkgs.tflint
    unstablePkgs.tfsec
    unstablePkgs.tfswitch
    unstablePkgs.vagrant
    # Virtualization
      unstablePkgs.OVMF

    # Monitoring & Observability
    unstablePkgs.btop
    unstablePkgs.glances
    unstablePkgs.hyperfine
    unstablePkgs.inxi
    unstablePkgs.iotop
    unstablePkgs.lm_sensors
    unstablePkgs.powertop
    unstablePkgs.s-tui
    unstablePkgs.vdpauinfo

    # Networking
    unstablePkgs.aria2
    unstablePkgs.dig
    unstablePkgs.dnstracer
    unstablePkgs.gping # Ping, but with a graph.
                       # https://github.com/orf/gping
    unstablePkgs.grpcurl
    unstablePkgs.httpie
    unstablePkgs.inetutils
    unstablePkgs.iperf
    unstablePkgs.lftp
    unstablePkgs.nfstrace
    unstablePkgs.nmap
    unstablePkgs.ookla-speedtest
    unstablePkgs.prettyping # prettyping is a wrapper around the standard ping tool, making the output prettier, more colorful, more compact, and easier to read.
                            # https://github.com/denilsonsa/prettyping
    unstablePkgs.socat
    unstablePkgs.sshfs-fuse
    unstablePkgs.tcpdump
    unstablePkgs.traceroute
    unstablePkgs.whois

    # Nix
    unstablePkgs.devpod
    unstablePkgs.fh # fh, the official FlakeHub CLI
                    # https://github.com/DeterminateSystems/fh
    unstablePkgs.hydra-check
    unstablePkgs.nh
    unstablePkgs.niv
    unstablePkgs.nix-index
    unstablePkgs.nix-tree
    unstablePkgs.nixfmt-classic
    unstablePkgs.nixpkgs-fmt
    unstablePkgs.nixpkgs-review
    unstablePkgs.rippkgs
    unstablePkgs.vulnix

    # Programming - CLI
      # Go
        unstablePkgs.go # Needed to install individual apps
        # golangci-lint
        # golangci-lint-langserver
        # gopls
      # JS
        # nodejs_latest
      # Nickel
        unstablePkgs.nickel
      # Python
        unstablePkgs.python312Full
        unstablePkgs.python312Packages.ipython
        # uv
      # Rust
        unstablePkgs.cargo-binstall
        unstablePkgs.cargo-cache
        unstablePkgs.chit
      # Everything else...
        unstablePkgs.devbox
        unstablePkgs.gcc
        unstablePkgs.mold
        unstablePkgs.shellcheck
        unstablePkgs.tokei
        unstablePkgs.yamlfmt

    # Security - CLI
    unstablePkgs.age
    unstablePkgs.chkrootkit
    unstablePkgs.gpg-tui
    unstablePkgs.lynis
    unstablePkgs.oath-toolkit
    unstablePkgs.protonvpn-gui
    unstablePkgs.rustscan
    unstablePkgs.sops
    unstablePkgs.vt-cli

    # Storage - CLI
    unstablePkgs.borgbackup
    unstablePkgs.du-dust
    unstablePkgs.duf
    unstablePkgs.dysk
    unstablePkgs.ncdu

    # # Terminal utilities
    unstablePkgs.antora
    unstablePkgs.at
    unstablePkgs.atuin
    unstablePkgs.bat
    unstablePkgs.chezmoi
    unstablePkgs.clinfo
    unstablePkgs.cmatrix
    unstablePkgs.comma
    unstablePkgs.difftastic
    unstablePkgs.delta
    unstablePkgs.dmidecode
    unstablePkgs.dotacat
    unstablePkgs.fastfetch
    unstablePkgs.fd
    unstablePkgs.fdupes
    unstablePkgs.file
    unstablePkgs.fx
    unstablePkgs.fzf
    unstablePkgs.getent
    unstablePkgs.glxinfo
    unstablePkgs.goaccess
    unstablePkgs.gum
    unstablePkgs.joshuto
    unstablePkgs.jq
    unstablePkgs.just # https://github.com/casey/just :: A handy way to save and run project-specific commands
    unstablePkgs.libva-utils
    unstablePkgs.lsof
    unstablePkgs.lunarvim
    unstablePkgs.lurk # A simple and pretty alternative to strace
    unstablePkgs.mc
    unstablePkgs.nushell
    unstablePkgs.osquery
    unstablePkgs.p7zip
    unstablePkgs.pciutils
    unstablePkgs.pipe-rename
    unstablePkgs.rust-petname
    unstablePkgs.pinentry-curses
    unstablePkgs.qrscan
    unstablePkgs.ripgrep
    unstablePkgs.strace
    unstablePkgs.strace-analyzer
    unstablePkgs.tesseract
    unstablePkgs.translate-shell
    unstablePkgs.tree
    unstablePkgs.ugrep
    unstablePkgs.vulkan-tools
    unstablePkgs.wayland-utils
    unstablePkgs.wl-clipboard
    unstablePkgs.zola

    # VCS
      # Git
      unstablePkgs.ggshield
      unstablePkgs.gh # GitHub CLI client.
                      # https://github.com
      unstablePkgs.git
      unstablePkgs.git-lfs
      unstablePkgs.gitui
      unstablePkgs.glab # GitLab CLI client.
                        # https://gitlab.com
      unstablePkgs.jujutsu
      unstablePkgs.tig

      # Radicle
      unstablePkgs.radicle-node
  ];

  userSidePackages = [ # Meant to run in a [role]client device (as opposite on a [role]server device)
    # AI
    unstablePkgs.aichat
    unstablePkgs.lmstudio
    unstablePkgs.oterm

    # Comms
    unstablePkgs.element-desktop-wayland
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
    pkgs.kdePackages.plasma-browser-integration
    unstablePkgs.kdePackages.yakuake

    # Multimedia
    pkgs.ansel
    unstablePkgs.blender
    # unstablePkgs.darktable
    pkgs.darktable
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

    # Security - GUI
    pkgs.bitwarden
    pkgs.keepassxc

    # Storage - GUI
    unstablePkgs.vorta

    # Terminal utilities - GUI
    # unstablePkgs.warp-terminal

    # Virtualization - GUI
    unstablePkgs.virt-viewer

    # Web
    pkgs.ungoogled-chromium
    pkgs.tor-browser
    # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})

    # Everything else
    unstablePkgs.wiki-tui
  ];
in
{
  imports = [
    # ./systemPackages-overrides.nix
  ];

  # Allow lincense-burdened packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # ===== Packages to exclude =====
  ## GNOME Desktop
  environment.gnome.excludePackages = (with unstablePkgs; [ # for packages that are pkgs.***
    gnome-tour
    gnome-connections
      ]) ++ (with unstablePkgs.gnome; [ # for packages that are pkgs.gnome.***
      epiphany # web browser
      geary # email reader
      evince # document viewer
  ]);


  # =====  Managed with NixOS options  =====
  # Applications are enabled per-host or group
  # of hosts using the hostnameLogic variable.

    #===  Emacs
    services = {
      emacs = { # Launches Emacs as server
        enable = false;
        package = unstablePkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
      };
    };

    #===  Firefox
    # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
    programs.firefox = {
      enable = hostnameLogic.isRoleUser;
      preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };
    };

    #===  MTR - https://wiki.nixos.org/wiki/Mtr
    programs.mtr.enable = true; # Network diagnostic tool
    services.mtr-exporter.enable = hostnameLogic.isRoleServer; # Prometheus-ready exporter.

    #===  Ungoogle Chromium
    nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    programs.chromium.enablePlasmaBrowserIntegration = hostnameLogic.isRoleUser;
    security.chromiumSuidSandbox.enable = hostnameLogic.isRoleUser;


  # =====  systemPackages  =====
  # Install packages system-wide based on the host
  environment.systemPackages =
    if hostnameLogic.isPerrrkele then
      commonPackages ++ userSidePackages

    else if hostnameLogic.isRoleServer then
      commonPackages ++ [ unstablePkgs.cockpit ]

    else if hostnameLogic.isVittusaatana then
      commonPackages ++ userSidePackages ++ [ unstablePkgs.nvtop ]

    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
}
