# https://github.com/gmodena/nix-flatpak?tab=readme-ov-file

{ pkgs, ... }:

{
  services.flatpak ={
    enable = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
      onActivation = false;
    };

    uninstallUnmanaged = true;
    packages = [
      # { appId = "com.brave.Browser"; origin = "flathub";  }
      "org.kde.akregator"
      "org.kde.arianna"
      "org.kde.digikam"
      "org.kde.francis"
      "org.kde.itinerary"
      "org.kde.kalzium"
      "org.kde.kasts"
      "org.kde.kcachegrind"
      "org.kde.kcalc"
      "org.kde.kcolorchooser"
      "org.kde.kdiff3"
      "org.kde.kfind"
      "org.kde.kget"
      "org.kde.kigo"
      "org.kde.kleopatra"
      "org.kde.krename"
      "org.kde.ksudoku"
      "org.kde.ktimetracker"
      "org.kde.neochat"
      "org.kde.tokodon"
      "io.github.nokse22.asciidraw"
      "com.brave.Browser"
      "com.google.Chrome"
      "com.google.EarthPro"
      "com.github.tchx84.Flatseal"
      "io.github.giantpinkrobots.flatsweep"
      "io.gitlab.gregorni.Letterpress"
      "org.nickvision.tubeconverter"
      "io.github.flattool.Warehouse"
    ];
  };

  systemd.services."flatpak-managed-install" = {
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
    };
  };
}
