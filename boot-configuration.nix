
{ config, lib, pkgs, ... }:

{

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        configurationLimit = 3;
        useOSProber = false;
      };
    };
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    kernelPackages = pkgs.linuxPackages_zen;
  };

}

