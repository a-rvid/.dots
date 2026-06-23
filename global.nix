{ pkgs, ... }:

let
  # pam_mount calls mount.fuse -> su user -> gocryptfs, and the resulting
  # PATH does not include /run/wrappers/bin, so go-fuse picks up the
  # un-setuid fusermount from the fuse store path and the kernel rejects
  # the mount. Prepend the wrappers dir so the setuid fusermount wins. Thanks claude, was difficult
  gocryptfsForPam = pkgs.writeShellScriptBin "gocryptfs" ''
    export PATH=/run/wrappers/bin:$PATH
    exec ${pkgs.gocryptfs}/bin/gocryptfs "$@"
  '';
in
{
  environment.systemPackages = with pkgs; [
    git
    fastfetch
    vim
    wl-clipboard
    libfido2
    gocryptfs
    btop
    stow
    usbutils
    pciutils
    nushell
    (lib.hiPrio uutils-coreutils-noprefix)
    uutils-util-linux
    uutils-findutils
    uutils-diffutils
  ];
  security.run0-sudo-shim.enable = true;

  security.pam.mount = {
    enable = true;
    extraVolumes = [
      ''
        <volume
          fstype="fuse"
          mountpoint="/home/user/.crypt"
          path="${gocryptfsForPam}/bin/gocryptfs#/home/user/.dots/encrypt"
          options="nodev,nosuid,quiet"
          user="user"
        />
      ''
    ];
    createMountPoints = true;
  };

  systemd.user.services.stow-crypt = {
    description = "Stow dotfiles from gocryptfs mount";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = "/home/user/.crypt";
      ExecStartPre = "${pkgs.bash}/bin/bash -c 'for _ in $(seq 1 80); do ${pkgs.util-linux}/bin/mountpoint -q /home/user/.crypt && exit 0; sleep 0.25; done; exit 1'";
      ExecStart = "${pkgs.stow}/bin/stow --restow --target=/home/user .";
    };
  };

  services = {
    # tor = {
    #   enable = true;
    #   client.dns.enable = true;
    #   client.enable = true;
    #   settings.ControlPort = 9051;
    #   settings.DNSPort = [{
    #     addr = "127.0.0.1";
    #     port = 53;
    #   }];
    # };
    resolved = {
      enable = true; # For caching DNS requests.
      fallbackDns = [ "" ]; # Overwrite compiled-in fallback DNS servers.
    };
  };


  services.udev.packages = [ pkgs.libfido2 ];

  programs.git = {
    enable = true;
    config = {
      user.name = "a-rvid";
      user.email = "git@rvid.eu";

      core.editor = "nvim";
      merge.tool = "nvim -d";
    };
  };

  environment.sessionVariables = rec {
    EDITOR = "nvim";
  };
}
