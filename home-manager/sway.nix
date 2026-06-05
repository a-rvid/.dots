{ config, lib, pkgs, inputs, ... }:

{
  options = {
    f.enable = 
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.sway.enable {
    programs.foot.enable = true;
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = rec {
        modifier = "Mod4";
        terminal = "foot"; 
      };
    };
  };
}
