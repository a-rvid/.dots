{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./mullvad-browser.nix
    ./vol.nix
  ];
  
  options = {
    desktop.enable =
      lib.mkEnableOption "enables desktop stuff";
  };

  config = lib.mkIf config.desktop.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
      pavucontrol
      ffmpeg
      mpv
      firefox
      dnsutils
      acpi
      swappy
      keepassxc
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      fira-code
      liberation_ttf
    ];

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true; # if not already enabled
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment the following
      #jack.enable = true;
    };

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

    home-manager.users.user.sway.enable = true;
    hardware.bluetooth.enable = true;

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
      ".local/share/flatpak"
      ".mozilla"
      ".var/app/com.bambulab.BambuStudio/config/BambuStudio"
      ".emacs.d"
    ];

    preservation.preserveAt."/persistent" = {
      directories = [
        "/var/lib/flatpak"
      ];
    };
  };
}
