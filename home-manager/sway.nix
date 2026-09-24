{ config, lib, pkgs, inputs, ... }:

let
  smartKill = pkgs.writeShellScript "smart-kill" ''
    focused_app=$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.. | objects | select(.focused? == true) | (.app_id // .window_properties.class // "") | select(. != "")' 2>/dev/null | head -1)
    if echo "$focused_app" | grep -qi "emacs"; then
      emacsclient -e '(smart-eat-kill-or-close)' >/dev/null 2>&1 || ${pkgs.sway}/bin/swaymsg kill
    else
      ${pkgs.sway}/bin/swaymsg kill
    fi
  '';
in

{
  options = {
    sway.enable =
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.sway.enable {
    programs.foot.enable = true;
    programs.foot.settings.main.font =  "Fira Code:size=11";
    services.dunst.enable = true;

    home.packages = with pkgs; [
      grim
      wl-clipboard
      slurp
      jq
    ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = rec {
        modifier = "Mod4";
        # terminal = "emacsclient -ce '(new-eat)'";
        terminal = "footclient";
        startup = [
          {command = "lxqt-policykit-agent";}
          {command = "foot --server";}
        ];
        input = {
          "type:keyboard" = {
            xkb_layout = "se";
          };
        };
        keybindings = lib.mkOptionDefault {
          "${modifier}+Shift+q" = "kill";
        };
      };
      extraConfig = ''
	output "AOC 24G2W1G3- 1J4Q1HA010276" mode 1920x1080@165.003Hz
        output "AOC 24G4 12VR9HA002571" mode 1920x1080@180Hz
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
