# Nix shortcuts ready to source from Zsh
# # I'm in the process of migrating them a Nix module:
# https://wiki.nixos.org/wiki/Zsh

# Review:
# - https://discourse.nixos.org/t/how-to-make-nixos-rebuild-output-more-informative/25549
# - https://nix.dev/manual/nix/2.22/command-ref/new-cli/nix3-store-diff-closures.html
#

# ANSI escape codes for colors
local bold_green="\e[1;32m"
local bold_white="\e[1;97m"
# ANSI escape code for resetting text attributes
local reset="\e[0m"

# Cleaning
alias nhc='nh clean all --keep 3'
alias nixc='nix-collect-garbage -d 3'

# Hydra
function hc {
  # hydra-check example: `hydra-check --arch x86_64-linux --channel unstable starship`
  hydra-check --arch x86_64-linux --channel unstable "$1"
}

# Get Nix and NixOS information
function nixcv {
  local channel_version="$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version')"
  echo -e "\n${bold_green}Nix channel version: ${bold_white}$channel_version${reset}"
}
#alias nixinfo='nix-info --host-os -m' # DONE

# NixOS System
alias nixlg='nixos-rebuild list-generations'

# Searching
alias nixse='nix search nixpkgs'
alias nixseu='nix search nixpkgs/nixos-unstable#'
alias nhs='nh search'

# Shell
alias nixsh='NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs'
alias nixshu='NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs/nixos-unstable#'

# function nixsh {
#   nix-shell -p "$1" --command zsh
# }
# function nixshr {
#   nix-shell -p "$1" --command "$2"
# }

# Useful on non-NixOS systems
alias nixsu='sudo env PATH=$PATH'
