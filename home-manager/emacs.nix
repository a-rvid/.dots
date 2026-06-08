{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pkg-config
    gnumake
    gcc
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: with epkgs; [
      nix-mode
      magit
      rainbow-delimiters
      jabber
      doom-themes
      nerd-icons
      evil-commentary
      nixfmt
      evil
    ];
    extraConfig = builtins.readFile ../config/emacs.el;
  };
}
