# https://wiki.nixos.org/wiki/Podman

{ ... }:

{
  virtualisation = {
    # Enable running Podman containers as systemd services
    oci-containers.backend = "podman";

    # Enable common container config files in /etc/containers
    containers.enable = true;

    # https://wiki.nixos.org/wiki/Podman
    # Options: https://search.nixos.org/options?channel=24.05&show=virtualisation.podman.autoPrune.dates&from=0&size=50&sort=relevance&type=packages&query=virtualisation.podman
    podman = {
      enable = true;
      autoPrune = {
        enable = false;
        dates = "weekly";
        flags = [ "--all" ];
      };
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}