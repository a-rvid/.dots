{ config, lib, pkgs, ... }:

{
  options = {
    nixvim.enable =
      lib.mkEnableOption "enables nixvim";
  };

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;
      clipboard.providers.wl-copy.enable = true;
      plugins.comment.enable = true;
      plugins.guess-indent.enable = true;
      plugins.gitsigns.enable = true;
      plugins.treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = false;
      };
      colorschemes.nord.enable = true;
      plugins.comfy-line-numbers.enable = true;
      nvim-autopairs.enable = true;
      plugins.render-markdown.enable = true;
      plugins.markdown-preview.enable = true;

      opts = {
        number = true;
      };
    };

    programs.bash = {
      #enabled = true;
      shellAliases = {
        vimdiff = "nvim -d";
        ls      = "ls --color";
        vim     = "nvim";
        v	      = "nvim";
      };
    };
  };
}
