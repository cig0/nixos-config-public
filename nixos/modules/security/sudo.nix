{ ... }:

{
  security.sudo.extraConfig = "Defaults timestamp_timeout=1440"; # Don't timeout for the next 24hs
}