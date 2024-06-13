{ config, inputs, ... }:

{
  sops = {
    age.keyFile = "/home/cig0/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      "syncthing/cig0/password" = { owner = config.users.users.cig0.name; };
      "syncthing/cig0/devices/perrrkele" = { owner = config.users.users.cig0.name; };
      "syncthing/cig0/devices/satama" = { owner = config.users.users.cig0.name; };
      "syncthing/cig0/devices/vittusaatana" = { owner = config.users.users.cig0.name; };
    };
  };
}