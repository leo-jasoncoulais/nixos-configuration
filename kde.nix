
{config, lib, pkgs, ...}:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.discover
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.printer_manager
    kdiff3
    kdePackages.partitionmanager
    wayland-utils
    wl-clipboard
  ];
}
