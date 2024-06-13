{ ... }:

{
  services.openssh = {
    enable = true;
    # openFirewall = false; # Managed in ./firewall.nix
  };
}