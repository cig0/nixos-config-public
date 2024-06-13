# Keyboard mapping

{ ... }:

{
  services.keyd = {
    enable = true;

    keyboards = {
      TUXEDOInfinityBookPro = {
        ids = [
          "0001:0001"
        ];
        settings = {
          main = {
            "capslock" = "capslock";
          };
          shift = {
            "capslock" = "insert";
          };
        };
      };

      SINOWealthGaming = {
        ids = [ "258a:002a" ];
        settings = {
          main = {
            "capslock" = "capslock";
          };
          shift = {
            "capslock" = "insert";
          };
        };
      };
    };
  };
}