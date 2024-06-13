{ ... }:

{
  services.sshguard = {
    enable = true;
    blocktime = 300;
    detection_time = 3600;
    services = {
      cockpit
      sshd
    };
  }
}