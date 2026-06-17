{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pkg-config
    zip
    rustc
    clang-tools
    cargo
    rust-analyzer
    gnumake
    texliveFull
    wakatime-cli
    (writeShellScriptBin "e" ''
      ${emacs}/bin/emacsclient -c "$@"
    '')
    gcc
  ];

  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: with epkgs; [
      nix-mode
      magit
      wakatime-mode
      rainbow-delimiters
      jabber
      vterm
      doom-themes
      nerd-icons
      evil-commentary
      rustic
      lsp-mode
      nixfmt
      vterm
      evil
    ];
    extraConfig = builtins.readFile ../config/emacs.el;
  };
}
