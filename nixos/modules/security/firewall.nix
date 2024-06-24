# Services:
#   - KDE Connect: 1714 to 1764 TCP/UDP
#   - Syncthing: 22000/TCP 21027,22000/UDP


{ ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [];
      allowedTCPPortRanges = [];
      allowedUDPPorts = [];
      allowedUDPPortRanges = [];
      trustedInterfaces = [ "tailscale0" "virbr0" ];
      checkReversePath = "loose";
      # The networking.firewall.checkReversePath option in NixOS controls whether the Linux kernel's
      # reverse path filtering mechanism should be enabled or not, which can enhance security by
      # preventing IP spoofing attacks but may also cause issues in certain network configurations.
    };
  };

  programs.kdeconnect.enable = true;
  services = {
    openssh.openFirewall = false;
    syncthing.openDefaultPorts = true;
    tailscale.openFirewall = false;
  };
}