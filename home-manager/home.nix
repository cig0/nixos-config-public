# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module

{ unstablePkgs, ... }:

{
  # Optionally, use home-manager.extraSpecialArgs to pass
  # arguments to home.nix
  home-manager = {
    useGlobalPkgs = true; # Using global packages
    useUserPackages = true; # Allowing user-specific packages

    users.cig0 = { ... }: {
      # Define user-specific packages and configurations
      home.packages = with unstablePkgs; [ ];

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "23.11";
    };
  };
}