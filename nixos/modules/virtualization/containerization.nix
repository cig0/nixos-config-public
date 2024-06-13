# https://nixos.wiki/wiki/Podman

{ ... }:

{
  virtualisation = {
    # Enable running Podman containers as systemd services
    oci-containers.backend = "podman";

    # Enable common container config files in /etc/containers
    containers.enable = true;

    # https://nixos.wiki/wiki/Podman
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
