{ config, pkgs, ... }:

{
  imports = [
    ./hyfetch.nix
    ./emacs.nix
    ./dev.nix
    ./sway.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "26.05";

  programs.keepassxc = {
    autostart = true;
    enable = true;
    settings = {
      # For available settings, see https://github.com/keepassxreboot/keepassxc/blob/develop/src/core/Config.cpp
      FdoSecrets.Enabled = true; # Enable Secret Service Integration
    };
  };

  xdg.autostart.enable = true;

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };
}
