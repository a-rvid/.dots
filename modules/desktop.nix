{ config, inputs, lib, pkgs, ... }:

{
  options = {
    desktop.enable =
      lib.mkEnableOption "enables desktop stuff";
  };

  config = lib.mkIf config.desktop.enable {
    environment.systemPackages = with pkgs; [
      ffmpeg
      mpv
      swappy
      keepassxc
    ];

    home-manager.users.user.sway.enable = true;
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      fira-code
      liberation_ttf
    ];


    security.polkit.enable = true;
    # services.displayManager.ly = {
    #   enable = true;
    #   settings = {
    #     animate = true;
    #     animation = "gameoflife"; 
    #     clock = "%c";
    #     bigclock = true;
    #   };
    # };

    services.flatpak.enable = true;
    xdg.portal.enable = true;
    xdg.portal.wlr.enable = true;

    preservation.preserveAt."/persistent".users.user.directories = [
      "Documents"
      "Videos"
      "Projects"
      ".local/state/wireplumber"
      ".local/state/pipewire"
      ".config/pulse"
      ".config/wireplumber"
      ".local/share/keyrings"
      ".local/share/flatpak"
    ];

    preservation.preserveAt."/persistent" = {
      directories = [
        "/var/lib/flatpak"
      ];
    };
  };
}
