{ config, lib, pkgs, ... }:

{
  options = {
    dev.enable = 
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.dev.enable {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    home.packages = with pkgs; [
      python3
      rust-analyzer
      gef
      claude-code
    ];
    programs.vscodium = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        wakatime.vscode-wakatime
        yzhang.markdown-all-in-one
      ];
    };
  };
}
