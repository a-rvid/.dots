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
    vim
    wl-clipboard
    libfido2
    gocryptfs
    btop
    stow
    usbutils
    pciutils
    nushell
  ];

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

  security.pam.services.login.rules.session.run_login_script = {
    order = 20000;
    control = "optional";
    modulePath = "${pkgs.pam}/lib/security/pam_exec.so";
    args = [ "/home/user/.dots/scripts/login.sh" ];
  };

  systemd.user.services.crypt-mount = {
    enable = true;
    description = "Create mount point for gocryptfs";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''/run/current-system/sw/bin/ mkdir -p /home/user/.crypt'';
      User = "user";
      Group = "users";
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
