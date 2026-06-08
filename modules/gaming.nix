{ config, lib, pkgs, ... }:

{
  options = {
    gaming.enable = 
      lib.mkEnableOption "enables gaming stuff";
    gaming.nvidia.enable = 
      lib.mkEnableOption "enables nvidia drivers";
    gaming.amd.enable = 
      lib.mkEnableOption "enables amd drivers";
    gaming.steam.enable = 
      lib.mkEnableOption "enables steam and deps";
  };

  config = lib.mkIf config.gaming.enable {
    environment.systemPackages = with pkgs; [ prismlauncher ];
    preservation.preserveAt."/persistent".users.user.directories = [
        ".local/share/PrismLauncher"
        ".local/share/Steam"
    ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers =
      lib.optionals config.gaming.nvidia.enable ["nvidia"]
      ++ lib.optionals config.gaming.amd.enable ["amdgpu"];

    hardware.nvidia = lib.mkIf config.gaming.nvidia.enable {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      powerManagement.enable = true;
      modesetting.enable = true;
    };

    programs.steam = {
      enable = config.gaming.steam.enable;
      gamescopeSession.enable = config.gaming.steam.enable;
    };
    programs.gamemode.enable = config.gaming.steam.enable;

    # preservation.preserveAt."/persistent".users.user.directories =
    #   lib.optionals config.gaming.steam.enable [ ".local/share/Steam" ];
  };
}
