{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyfetch
    fastfetch
  ];

  home.file.".config/hyfetch.json".text = builtins.toJSON {
    preset = "equal-rights";
    mode = "rgb";
    auto_detect_light_dark = true;
    light_dark = "dark";
    lightness = 0.65;
    color_align = {
      mode = "custom";
      custom_colors = {
        "1" = 0;
        "2" = 1;
      };
    };
    backend = "neofetch";
    args = null;
    distro = null;
    pride_month_disable = false;
    custom_ascii_path = null;
  };
}
