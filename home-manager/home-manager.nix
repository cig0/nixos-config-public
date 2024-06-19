# TODO: this is a template
# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module

{ ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.jdoe = import ./home.nix;

  # Optionally, use home-manager.extraSpecialArgs to pass
  # arguments to home.nix
}
