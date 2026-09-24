{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./vol.nix
    ./usbguard.nix
  ];

  options = {
    desktop.enable =
      lib.mkEnableOption "enables desktop stuff";
  };
  config = lib.mkIf config.desktop.enable {

  services.tailscale = {
    # Enable tailscale at startup
    enable = true;

    # If you would like to use a preauthorized key, set
    # authKeyFile = "/run/secrets/tailscale_key";
    # Note: maximum expire time is 90 days
  };
    custom.security.usbguard.enable = true;
    environment.systemPackages = with pkgs; [
      brightnessctl
      pavucontrol
      ffmpeg
      mpv
      # firefox
      librewolf
      dnsutils
      acpi
      ncspot
      swappy
      pinentry-curses
      keepassxc
      glib
      xdg-utils
      lxqt.lxqt-policykit
    ];

    programs.command-not-found.enable = false;
    programs.bash.interactiveShellInit = ''
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';

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
    services.udev.packages = with pkgs; [ yubikey-personalization libfido2 ];
    services.pcscd.enable = true;
    
    home-manager.users.user.sway.enable = true;
    hardware.bluetooth.enable = true;

    services.flatpak.enable = true;
    xdg.portal = {
      enable = true;
      wlr = {
        enable = true;
        settings.screencast = {
          # pick output/region interactively when an app requests a capture
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          max_fps = 30;
        };
      };
      # file chooser / settings / app chooser; wlr only implements screencast
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
      config = {
        sway = {
          default = [ "wlr" "gtk" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        };
        common.default = [ "wlr" "gtk" ];
      };
    };

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
