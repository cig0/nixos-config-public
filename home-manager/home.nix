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
      home.packages = with unstablePkgs; [
        # Security - Web
        unstablePkgs.burpsuite
        unstablePkgs.mitmproxy
        unstablePkgs.nikto
      ];

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "23.11";
    };
  };
}