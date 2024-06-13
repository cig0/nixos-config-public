{ ... }:

{
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  services.zram-generator.enable = true;
}