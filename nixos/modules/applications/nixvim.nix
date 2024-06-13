# TODO: configure this module

{ unstablePkgs, ... }:

{
  programs.nixvim = {
    opts = {
      number = true;          # Show line numbers
      relativenumber = true;  # Show relative line numbers
      shiftwidth = 2;         # Tab width should be 2
    };

    extraPlugins = with unstablePkgs.vimPlugins; [
      vim-nix
    ];
  };
}