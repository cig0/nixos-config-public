{ ... }:

{
  networking = {
    nameservers = [ "PLACEHOLDER" "95.85.95.85" "94.140.14.14" ];
    search = [ "PLACEHOLDER" ];
  };
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "208.67.222.123" "8.8.8.8" ];
  };
}


# DNS providers sorted alphabetically (pick your poison)
# ------------------------------------------------------
  # 94.140.14.14      AdGuard DNS default servers :: https://adguard-dns.io/en/public-dns.html
  # 94.140.15.15      AdGuard DNS default servers :: https://adguard-dns.io/en/public-dns.html
  # 208.67.222.123    Cisco OpenDNS
  # 1.1.1.1           Cloudflare
  # 95.85.95.85       GCore Free :: https://gcore.com/public-dns
  # 2.56.220.2        GCore Free :: https://gcore.com/public-dns
  # 8.8.8.8           GoogleDNS
  # 194.242.2.2       Mullvad Public DNS
  # PLACEHOLDER       Tailscale
  # 64.6.64.6         Verisign DNS :: https://www.verisign.com/


# References
# ----------
  # https://wikileaks.org/wiki/Alternative_DNS
  # https://prism-break.org/en/all/#dns
  # https://www.privacyguides.org/en/dns/
  # https://www.privacytools.io/encrypted-dns


# Q & A
# -----
  # Q: Why {foobar} provider isn't listed here?
  # A: Probably I don't know about them, most likely I don't like them.
  # Q: But they are a big a55 corpo!
  # A: That could be one of the reasons.
  # Q: But you already have some big a55 corpos here!
  # A: You're annoying -- go away.
  # Q: That's not fair! You have Google's DNS here! <rage_crying_meme_here>
  # A: Your tears are delightful, you can stay as long as you keep crying.