# Create a list of the installed packages in `/etc/current-system-packages`
# I can't remember where I took this bit from :/

{ config, pkgs, ... }:

{
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
      formatted;
}