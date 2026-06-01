{
  disko.devices.disk.main = {
    device = "/dev/vda"; # overridden by `disko-install --disk main /dev/...`
    type = "disk";

    content.type = "gpt";

    content.partitions.boot = {
      name = "boot";
      size = "1M";
      type = "EF02";
    };

    content.partitions.esp = {
      name = "ESP";
      size = "1G";
      type = "EF00";

      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    };

    content.partitions.swap = {
      size = "4G";

      content = {
        type = "swap";
        resumeDevice = true;
      };
    };

    content.partitions.root = {
      name = "root";
      size = "100%";

      content = {
        type = "btrfs";
        extraArgs = ["-f"];

        subvolumes = {
          "/root" = {
            mountOptions = ["subvol=root" "compress=zstd" "noatime"];
            mountpoint = "/";
          };

          "/nix" = {
            mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
            mountpoint = "/nix";
          };
        };
      };
    };
  };
}
