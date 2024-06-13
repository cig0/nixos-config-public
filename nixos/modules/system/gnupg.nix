{ ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      default-cache-ttl = 86400;
      max-cache-ttl = 86400;
    };
  };
}
