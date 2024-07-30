{ inputs, ... }:

{
  # Automatic system cleanup
  nix = {
    settings = {
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      randomizedDelaySec = "720min";
    };
  };

# Auto-upgrade
# Since 24.05 you can also use the awesome `nh` helper tool, which I use extensibly on-demand.
# However, for automated system updates, I prefer to stick to the official method.
# Refs:
#   - https://search.nixos.org/options?channel=24.05&from=0&size=50&sort=relevance&type=packages&query=nh.
#   - https://github.com/viperML/nh (don't forget to star it!)
  system.autoUpgrade = {
    enable = false;
    dates = "daily";
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "nixpkgs-unstable"
      "--commit-lock-file"
      "--no-build-nix"
      "--print-build-logs"
    ];
    flake = inputs.self.outPath;
    operation = "boot";
    randomizedDelaySec = "720min";
    persistent = false; # Do not try to upgrade early to compensate a missed reboot
    allowReboot = false; # Do not allow reboots, we are not switching anyway
  };
}