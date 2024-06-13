# https://github.com/StevenBlack/hosts
{ ... }:

{
  networking.stevenblack = {
    enable = true;
    block = [
      "gambling"
      "porn"
      "social"
    ];
  };
}