# TODO: configure this module

{ pkgs, ... }:

{
  programs.nixvim = {
    opts = {
      number = true;          # Show line numbers
      relativenumber = true;  # Show relative line numbers
      shiftwidth = 2;         # Tab width should be 2
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
