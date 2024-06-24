{ ... }:

{
  services.openssh = {
    enable = true;
    listenAddresses = [
      {
        addr = "127.0.0.1";
        port = 22;
      }
      { # Tailscale
        addr = "100.0.0.0";
        port = 22;
      }
    ];
  };
}