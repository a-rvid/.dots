{ config, lib, pkgs, inputs, ... }:

{
  options = {
    sway.enable = 
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.sway.enable {
    programs.foot.enable = true;
    programs.foot.settings.main.font =  "Fira Code:size=11";
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = rec {
        modifier = "Mod4";
        terminal = "foot";
        input = {
          "type:keyboard" = {
            xkb_layout = "se";
          };
        };
      };
    };
  };
  }
