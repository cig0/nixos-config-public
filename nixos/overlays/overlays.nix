{ ... }:

{
  nixpkgs.overlays = [
    (import ./nixos-option.nix)
  ];
}