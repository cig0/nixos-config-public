{ config, lib, pkgs, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };

  commonEnvSessionVars =  rec {
    EGL_PLATFORM = "wayland";
    EGL_LOG_LEVEL = "fatal";

    # https://wiki.nixos.org/wiki/Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";

    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border"; # Fuzzy finder.
    GDK_DPI_SCALE = 1.13; # Flatpak applications display scaling.
    LD_BIND_NOW = "1";
    PAGER = "${pkgs.less}/bin/less";

    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_HOME        = "$HOME";
    XDG_STATE_HOME  = "$HOME/.local/state";

    PATH = [
      "$HOME/.cargo/bin"
      "$HOME/.krew/bin"
      "$HOME/.npm_global/bin"
      "$HOME/exe"
      "$HOME/go/bin"
    ];

    # https://stackoverflow.com/questions/76591674/nix-gives-no-space-left-on-device-even-though-nix-has-lots
    TMPDIR = "/tmp";
  };

  intelEnvSessionVars = {
    LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
    EGL_DRIVER = "mesa";
  };
in
{
  environment = {
    homeBinInPath = true;
    localBinInPath = true;
  };

  environment.sessionVariables =
    if hostnameLogic.isIntelGPUHost then commonEnvSessionVars // intelEnvSessionVars
    else if hostnameLogic.isNvidiaGPUHost then commonEnvSessionVars
    else {};
}