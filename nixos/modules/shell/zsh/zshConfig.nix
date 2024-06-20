# TODO:
#   - Split interactiveShellInit
#   - Split shellAliases

{ pkgs }:

rec {
  setOptions = [
    # https://superuser.com/questions/519596/share-history-in-multiple-zsh-shell
    # https://unix.stackexchange.com/questions/669971/zsh-can-i-have-a-combined-history-for-all-of-my-shells
    # https://github.com/cig0/Phantas0s-dotfiles/blob/master/zsh/zshrc

    # +------------+
    # | NAVIGATION |
    # +------------+
    "AUTO_CD"
    "AUTO_PUSHD"
    "PUSHD_IGNORE_DUPS"
    "PUSHD_SILENT"
    "CORRECT"
    "CDABLE_VARS"

    # +---------+
    # | HISTORY |
    # +---------+
    "EXTENDED_HISTORY"
    "SHARE_HISTORY"
    "HIST_EXPIRE_DUPS_FIRST"
    "HIST_IGNORE_DUPS"
    "HIST_IGNORE_ALL_DUPS"
    "HIST_FIND_NO_DUPS"
    "HIST_IGNORE_SPACE"
    "HIST_SAVE_NO_DUPS"
    "HIST_VERIFY"
  ];


  interactiveShellInit = ''
    umask 0077
    fpath+=~/.zfunc

    # Needs https://github.com/nix-community/nix-index
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

    # ANSI escape codes for colors
    local bold_green="\e[1;32m"
    local bold_white="\e[1;97m"
    # ANSI escape code for resetting text attributes
    local reset="\e[0m"

    # Nix and NixOS
      # Hydra
        hc() {
          # hydra-check example: `hydra-check --arch x86_64-linux --channel unstable starship`
          hydra-check --arch x86_64-linux --channel 24.05 "$1"
        }

        hcs() {
          # hydra-check example: `hydra-check --arch x86_64-linux --channel unstable starship`
          hydra-check --arch x86_64-linux --channel staging "$1"
        }

        hcu() {
          # hydra-check example: `hydra-check --arch x86_64-linux --channel unstable starship`
          hydra-check --arch x86_64-linux --channel unstable "$1"
        }

      # Shell
        # `nix shell` packages from nixpkgs
        nixsh() {
          local p
          for p in "$@"; do
            NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs#$p
          done
        }

        # `nix shell` packages from nixpkgs/nixos-unstable
        nixshu() {
          local p
          for p in "$@"; do
            NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs/nixos-unstable#$p
          done
        }

      # System
        nixcv() {
          local channel_version="$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version')"
          echo -e "\n$bold_greenNix channel version: $bold_white$channel_version$reset"
        }


    # Other functions
    # ls
    a() {
      setopt null_glob
      hidden_found=false
      for entry in .*; do
        [[ $entry != "." && $entry != ".." ]] && hidden_found=true && break
      done
      $hidden_found && ls -dl --color=always --group-directories-first .??* || echo -e '\nNo hidden files found.\e[0m'
      unsetopt null_glob
    }
    la() {
      setopt null_glob
      hidden_found=false
      for entry in .*; do
        [[ $entry != "." && $entry != ".." ]] && hidden_found=true && break
      done
      $hidden_found && ls -dl --color=always --group-directories-first .??* || echo -e '\nNo hidden files found.\e[0m'
      unsetopt null_glob
    }

    # Diff
    diffstring() {
      # Using delta :: https://github.com/dandavison/delta
      d <(echo "$1") <(echo "$2")
    }

    # General
    bkp() {
      source=$1
      cp -i "$source" "$source.bkp"
    }
    freemem() {
      printf '\n=== Superuser password required to elevate permissions ===\n\n'
      su -c "echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\\n%s\\n' 'RAM-cache and Swap Cleared'" root
    }

    # Kubernetes
    kla() {
      # List all resources
      kubectl api-resources --verbs=list --namespaced -o name | xargs -t -n 1 kubectl get --show-kind --ignore-not-found "$@"
    }
    kla_events() {
      # List all events
      for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
        echo "Resource:" $i

        if [ -z "$1" ]
        then
            kubectl get --ignore-not-found $i
        else
            kubectl -n $1 get --ignore-not-found $i
        fi
      done
    }
    kdecrypts() {
      # Secret decrypt
      # $1 = secret name
      # $2 = .data.{OBJECT}
      kubectl get secret "$1" -o jsonpath="{.data.$2}" | base64 --decode
    }

    # Podman
    prminone() {
      podman rmi --force $(podman images | grep -i '<none>' | awk -F' ' '{ print $3 }')
    }

    # Visual Studio Code
    c() {
      /run/current-system/sw/bin/code --profile cig0 $@
    }
  '';


  loginShellInit = interactiveShellInit;


  shellInit = ''
    # Preferred editor for local and remote sessions
    if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR="vim"
    else
      export EDITOR="lvim"
    fi

    # Uncomment the following line to display red dots whilst waiting for completion.
    # You can also set it to another string to have that shown instead of the default red dots.
    # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
    # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
    COMPLETION_WAITING_DOTS="true"

    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # You can set one of the optional three formats:
    # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    # or set a custom format using the strftime function format specifications,
    # see 'man strftime' for details.
    # HIST_STAMPS="mm/dd/yyyy"
    HIST_STAMPS="yyyy-mm-dd"

    # Shell editing Emacs' style
    bindkey -e

    # zsh_reload
    zr() {
      if [ -n "$(jobs)" ]; then
        print -P "Error: %j job(s) in background"
      else
        [[ -n "$ORIGINAL_PATH" ]] && export PATH="$ORIGINAL_PATH"
        exec zsh
      fi
    }
  '';


  # Oh My Zsh Plugins
  ohMyZsh = {
    plugins = [ "fzf" "history-substring-search" ];
  };


  shellAliases = {
    # Nix and NixOS aliases
      # Cleaning
      nhc = "nh clean all --keep 3";
      nixc = "nix-collect-garbage -d 3";

      # Searching
      nixse = "nix search nixpkgs";
      nixseu = "nix search nixpkgs/nixos-unstable#";
      nhs = "nh search";

      # System
      nixinfo = "nix-info --host-os -m";
      nixlg = "nixos-rebuild list-generations";


    # Other aliases
    # AIChat
      # Google Gemini
      aG = "aichat -m gemini";
      aGc = "aichat -m gemini --code";
      aGl = "aichat -m gemini --list-sessions";
      aGs = "aichat -m gemini --session";

    # Bat - A cat(1) clone with syntax highlighting and Git integration.
    # https://github.com/sharkdp/bat
    b = "bat --paging=always --style=plain --theme='Dracula' --wrap=auto"; # Plain + paging=always
    bb = " bat --paging=never --style=plain --theme='Dracula' --wrap=auto"; # Plain, no paging
    bnp = "bat --paging=always --style=numbers --theme='Dracula' --wrap=auto"; # Numbers + paging=always

    # AWS
    aws_account_describe = "aws organizations describe-account --account-id $(aws_account_id)";
    aws_account_id = "aws sts get-caller-identity --query Account --output text";
    aws_account_region = "aws configure get region";
    aws-central-poc = "export AWS_PROFILE=481635650710_AWS-rw-All";

    # Diff
    codif = "colordiff -y -W 212";
    d = "delta --paging=never";
    dp = "delta --paging=auto";
    dt = "difft";

    # Distrobox - https://github.com/89luca89/distrobox
    # https://distrobox.it/
    db = "distrobox";
    dbc = "distrobox create";
    dbe = "db enter";
    dbl = "db list";
    dbr = "db run";

    # Flatpak
    fll = "flatpak list";
    flp = "flatpak ps";
    fls = "flatpak search";

    # General
    _h = "history | grep -i";
    ___ = "_h";
    _fi = "find . -maxdepth 1 -iname";
    _t = "tmux -f $HOME/.config/tmux/tmux-zsh.conf new-session -s $(hostnamectl hostname)";
    cm = "chezmoi --color true --progress true";
    cp = "cp -i";
    dudir = "du -sh ./"; # Use */ for all dirs in the target directory
    g = "gwenview";
    gi = "grep -i --color=always";
    glow = "glow --pager -";
    ic = "imgcat";
    rs = "rsync -Pav";
    surs = "sudo rsync -Pav";
    tt = "oathtool --totp -b $(wl-paste -n -p) | wl-copy -n";
    sw3m = "s -b w3m";
    v = "lvim";

    # GitHub CLI
    ghrw = "gh run watch";
    ghwv = "gh workflow view";

    # Git
    # Adds an extra new line at the beginning of the pretty decoration
    # https://git-scm.com/docs/pretty-formats
    glols = "git log --graph --pretty='\''%n%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%x2C'\'' --stat";
    ga = "git add";
    gaf = "git add --force";
    gb = "git branch";
    gca = "git commit -am";
    gch = "git checkout";
    gcl = "git clone";
    gcl1 = "git clone --depth=1";
    gco = "git commit -m";
    gf = "git fetch";
    gf1 = "git fetch --depth=1";
    gls = "git ls-tree --full-tree --name-only -r HEAD | lines";
    gp = "git pull";
    gpu = "git push";
    grm = "git rm --cached";
    grss = "git restore --staged";
    gd = "git diff";
      # Git Log
      gloH = "git log origin..HEAD --oneline";
      # Git Status
      gsb = "git status --short --branch";
      gst = "git status";
      # Git Switch
      gsw = "git switch";
      gswc = "git switch --create";
      gswm = "git switch $\"\(git_main_branch\)\"";
      gswd = "git switch $\"\(git_develop_branch\)\"";
      gsws = "git switch sandbox";
      # Plus, related aliases/commands
      gg = "lazygit";
      # GitGuardian
      ggs = "ggshield --no-check-for-updates";
      ggssr = "ggshield --no-check-for-updates secret scan repo";

    # Golang
    cdgosrc = "cd $(go env GOPATH)/src";
    go_clean_vcs_cache = "rm -rf $GOPATH/pkg/mod/cache/vcs";

    # GPG
    gpgc = "gpg -c --cipher-algo aes256";
    gpgd = "gpg -d";
    # Compress and encrypt files & dirs using GNU GPG
    gpgtare = "gpgtar --encrypt --symmetric --gpg-args --cipher-algo aes256 --output"; # input_folder/output_file input_folder

    # K8s
    h = "helm";
    k9s = "k9s --headless";
    k = "kubectl";
    kx = "k ctx";
    kn = "k ns";

    # ls
    l = "ls -lh --group-directories-first";
    l1 = "ls -1 --group-directories-first";
    l11 = "ls -1rt";
    ldir = "ls -dl */ --color=always --group-directories-first";
    ll = "ls -1rt";
    lla = "ls -lAh --group-directories-first";
    lm = "ls -lrt --color=always";
    lma = "ls -lartA --color=always";
    lsa = "ls -a --color=always --group-directories-first";
    lsrt = "ls -rt";

    # Hosts
    sperrrkele = "ssh perrrkele";
    ssatama = "ssh satama";
    sterasbetoni = "ssh terasbetoni";
    svittusaatana = "ssh vittusaatana";
    tperrrkele = "ssh perrrkele -t 'tmux attach-session -t'";
    tsatama = "ssh satama -t 'tmux attach-session -t'";
    tterasbetoni = "ssh terasbetoni -t 'tmux attach-session -t'";
    tvittusaatana = "ssh vittusaatana -t 'tmux attach-session -t'";

    # Minikube
    m = "minikube";
    minikube = "minikube-linux-amd64";

    # Navigation (CLI)
      e = "exit";
      jo = "joshuto";
      o = "ranger";

      # Directories shortcuts
      __ = "_0";
      _0 = "cd ~/w/cig0";
      D = "cd ~/Downloads";
      DE = "cd ~/Desktop";
      DOC = "cd ~/Documents";
      P = "cd ~/Pictures";
      S = "cd ~/Sync";
      T = "cd ~/tmp";
      W = "cd ~/w";

    # Podman
    # docker = "podman";
    p = "podman";
    pi = "podman images";
    psa = "podman ps -a";
    ptui = "podman-tui";

    # Rust's Cargo package manager
    cargoApps = "$EDITOR ~/.config/Cargo.apps";

    # SSH commands library
    sshFingerprint = "ssh-keygen -E hash_type -lf /path/to/key"; # Get key fingerprint

    # Terraform / OpenTofu
    ot = "opentofu";
    tf = "terraform";

    # Trans - CLI client for Goolge Translator
      # English
      tenes = "trans en:es";
      tesen = "trans es:en";
      # Suomi
      tenfi = "trans en:fi";
      tfien = "trans fi:en";

    # Trasher - https://crates.io/crates/trasher
    rm = "trasher --exclude /var rm";
    rmp = "trasher --exclude /var rm -p";
    te = "trasher --exclude /var empty";
    tls = "trasher --exclude /var ls";
    tp = "trasher --exclude /var path-of";

    # systemd
    journalctl_boot_err = "journalctl -xep err -b";
  };
}