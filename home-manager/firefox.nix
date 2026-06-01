{ config, lib, pkgs, inputs, ... }:

{
  options = {
    firefox.enable = 
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.firefox.enable {
        programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          EnableTrackingProtection = {
            Value= true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };
      };

      profiles.default = {
        # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.containersForce
        containersForce = true;
        # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.search.force
        search.force = true;

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          ublock-origin
        ];
      };
    };
  };
}
