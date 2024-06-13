{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "Meslo" "UbuntuMono" "UbuntuSans" ]; })
  ];
}