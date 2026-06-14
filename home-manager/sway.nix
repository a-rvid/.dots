{ config, lib, pkgs, inputs, ... }:

{
  options = {
    sway.enable = 
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.sway.enable {
    programs.foot.enable = true;
    programs.foot.settings.main.font =  "Fira Code:size=11";
    services.dunst.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = rec {
        modifier = "Mod4";
        terminal = "foot";
        startup = [
          {command = "lxqt-policykit-agent";}
        ];
        input = {
          "type:keyboard" = {
            xkb_layout = "se";
          };
        };
      };
      extraConfig = ''
        for_window [title="Authentication Required"] floating enable
        # Brightness
        bindsym XF86MonBrightnessDown exec brightnessctl set -5%
        bindsym XF86MonBrightnessUp exec brightnessctl set -5%

        # Volume
        bindsym XF86AudioRaiseVolume exec 'vol raise 3';
        bindsym XF86AudioLowerVolume exec 'vol lower 3';
        bindsym XF86AudioMute exec 'vol mute'

        bindsym Super+Shift+S exec 'grim -g $(slurp) - | wl-copy'
      ''; 
      extraOptions = [ "--unsupported-gpu" ]; 
    };
  };
}
