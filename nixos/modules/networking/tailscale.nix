# Check these modules for additional options:
#   - ./dns.nix
#   - ../security/firewall.nix

{ ... }:

{
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--ssh" ];
    # port = 41641; # Default port (0 = autoselect).
  };
}