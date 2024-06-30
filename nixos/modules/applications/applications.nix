{ config, lib, pkgs, unstablePkgs, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };

  commonPackages = [ # Packages common to all hosts
    # Comms
    unstablePkgs.iamb
    unstablePkgs.weechat

    # IaaS / PaaS / SaaS
    unstablePkgs.awscli2
    unstablePkgs.eksctl

    # Infrastructure: CNCF / K8s / OCI / virtualization
    unstablePkgs.argocd
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
    unstablePkgs.odo # odo is a CLI tool for fast iterative application development deployed immediately to your kubernetes cluster :: https://odo.dev
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

    # Monitoring & Observability
    unstablePkgs.btop
    unstablePkgs.glances
    unstablePkgs.hyperfine
    unstablePkgs.inxi
    pkgs.iotop
    pkgs.lm_sensors
    pkgs.powertop
    unstablePkgs.s-tui
    pkgs.vdpauinfo

    # Networking
    unstablePkgs.aria2
    pkgs.bind
    pkgs.dnstracer
    unstablePkgs.gping # Ping, but with a graph :: https://github.com/orf/gping
    unstablePkgs.grpcurl
    unstablePkgs.httpie
    pkgs.inetutils
    pkgs.iperf
    unstablePkgs.lftp
    pkgs.nfstrace
    pkgs.nmap
    unstablePkgs.ookla-speedtest
    unstablePkgs.prettyping # prettyping is a wrapper around the standard ping tool, making the output prettier, more colorful, more compact, and easier to read :: https://github.com/denilsonsa/prettyping
    pkgs.socat
    pkgs.sshfs-fuse
    pkgs.tcpdump
    pkgs.traceroute
    pkgs.whois

    # Nix
    unstablePkgs.devpod
    unstablePkgs.fh # fh, the official FlakeHub CLI :: https://github.com/DeterminateSystems/fh
    pkgs.hydra-check
    pkgs.nh
    pkgs.niv
    pkgs.nix-index
    pkgs.nix-tree
    pkgs.nixfmt-classic
    pkgs.nixpkgs-fmt
    pkgs.nixpkgs-review
    pkgs.rippkgs
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
        pkgs.nickel
      # Python
        pkgs.python312Full
        pkgs.python312Packages.ipython
        # uv
      # Rust
        unstablePkgs.cargo-binstall
        unstablePkgs.cargo-cache
        unstablePkgs.chit
      # Everything else...
        unstablePkgs.devbox
        pkgs.gcc
        pkgs.mold
        pkgs.shellcheck
        unstablePkgs.tokei
        unstablePkgs.yamlfmt

    # Security - CLI
    unstablePkgs.age
    unstablePkgs.chkrootkit
    unstablePkgs.gpg-tui
    unstablePkgs.lynis
    unstablePkgs.oath-toolkit
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
    pkgs.at
    unstablePkgs.atuin
    unstablePkgs.bat
    unstablePkgs.chezmoi
    pkgs.clinfo
    unstablePkgs.cmatrix
    unstablePkgs.comma
    unstablePkgs.difftastic
    unstablePkgs.delta
    pkgs.dmidecode
    unstablePkgs.dotacat
    unstablePkgs.fastfetch
    unstablePkgs.fd
    unstablePkgs.fdupes
    pkgs.file
    unstablePkgs.fx
    unstablePkgs.fzf
    pkgs.getent
    pkgs.glxinfo
    unstablePkgs.goaccess
    unstablePkgs.gum
    unstablePkgs.joshuto
    unstablePkgs.jq
    unstablePkgs.just # https://github.com/casey/just :: A handy way to save and run project-specific commands
    pkgs.libva-utils
    pkgs.lsof
    unstablePkgs.lunarvim
    unstablePkgs.lurk # A simple and pretty alternative to strace
    unstablePkgs.mc
    unstablePkgs.nushell
    unstablePkgs.osquery
    unstablePkgs.p7zip
    pkgs.pciutils
    unstablePkgs.pipe-rename
    unstablePkgs.rust-petname
    pkgs.pinentry-curses
    unstablePkgs.qrscan
    unstablePkgs.ripgrep
    pkgs.strace
    pkgs.strace-analyzer
    unstablePkgs.tesseract
    unstablePkgs.tmux
    unstablePkgs.translate-shell
    pkgs.tree
    unstablePkgs.ugrep
    pkgs.vulkan-tools
    pkgs.wayland-utils
    pkgs.wl-clipboard
    unstablePkgs.zola

    # VCS
      # Git
      unstablePkgs.ggshield # GitGuardian
      unstablePkgs.gh # GitHub CLI client.
      unstablePkgs.git
      unstablePkgs.git-lfs
      unstablePkgs.gitui
      unstablePkgs.glab # GitLab CLI client.
      unstablePkgs.jujutsu
      unstablePkgs.tig
      # Radicle
      unstablePkgs.radicle-node
  ];

  userSidePackages = [ # Meant to run in a [role]client device (as opposite on a [role]server device)
    #
    # Note: user-side applications were moved to Home Manager
    #
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
    # services = {
    #   emacs = { # Launches Emacs as server
    #     enable = false;
    #     package = pkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
    #   };
    # };

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
