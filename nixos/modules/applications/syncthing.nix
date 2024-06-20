# Syncthing shares
{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "cig0";
    group = "users";
    dataDir = "/home/cig0";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      gui = {
        user = "PLACEHOLDER";
        password = "PLACEHOLDER";
      };
      options = {
        minHomeDiskFree = {
          unit = "GB";
          value = 50;
        };
        maxFolderConcurrency = 2;
        urAccepted = 2; # Send telemetry
      };
      devices = {
        perrrkele ={
          id = "PLACEHOLDER";
        };
        satama = {
          id = "PLACEHOLDER";
        };
        vittusaatana = {
          id = "PLACEHOLDER";
        };
      };
      folders = {
        ".aws" = {
          id = "m3q6z-itat6";
          label = ".aws";
          path = "/home/cig0/.aws";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        ".krew" = {
          id = "zo6vm-ycvnv";
          label = ".krew";
          path = "/home/cig0/.krew";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        ".kube" = {
          id = "cbvut-r9kxc";
          label = ".kube";
          path = "/home/cig0/.kube";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        ".ssh" = {
          id = "7cgim-4pyuc";
          label = ".ssh";
          path = "/home/cig0/.ssh";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        ".terraform.versions" = {
          id = "uoocx-gswyo";
          label = ".terraform.versions";
          path = "/home/cig0/.terraform.versions";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "Default Folder" = {
          id = "default";
          label = "Default Folder";
          path = "/home/cig0/Sync";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "Desktop" = {
          id = "bevao-ecdck";
          label = "Desktop";
          path = "/home/cig0/Desktop";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "Documents" = {
          id = "4plzj-q9hjx";
          label = "Documents";
          path = "/home/cig0/Documents";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "Downloads" = {
          id = "v72dy-fzjsf";
          label = "Downloads";
          path = "/home/cig0/Downloads";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "KeePassXC" = {
          id = "nsqaf-gequ7";
          label = "KeePassXC";
          path = "/home/cig0/KeePassXC";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "Pictures" = {
          id = "zhepz-tkl9u";
          label = "Pictures";
          path = "/home/cig0/Pictures";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "stash" = {
          id = "inznp-cjdxe";
          label = "stash";
          path = "/home/cig0/stash";
          devices = [ "perrrkele" "vittusaatana" ];
        };
        "Videos" = {
          id = "g7amc-cstmt";
          label = "Videos";
          path = "/home/cig0/Videos";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "bin" = {
          id = "mtzdy-xgvcf";
          label = "bin";
          path = "/home/cig0/bin";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
        };
        "w" = {
          id = "rn6um-4btcp";
          label = "w";
          path = "/home/cig0/w";
          devices = [ "perrrkele" "satama" "vittusaatana" ];
          versioning.type = "simple";
        };
      };
    };
  };
}