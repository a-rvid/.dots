{ config, pkgs, ... }:

{
  imports = [
    ./hyfetch.nix
    ./dev.nix
    ./firefox.nix
    ./mango.nix
    ./sway.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "26.05";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };
}
