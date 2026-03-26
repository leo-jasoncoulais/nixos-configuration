
{ config, lib, pkgs, ... }:

{

  # System packages
  environment.systemPackages = with pkgs; [
    dnsmasq
    gcc
    nasm
  ];

  # Groups configuration
  users.groups.nixos-conf = {};
  users.groups.ubridge = {};

  # Users configuration
  users.users.nit = {
    isNormalUser = true;
    description = "Nit";
    extraGroups = [ "wheel" "libvirtd" "docker" "nixos-conf" ];
    shell = pkgs.bash;
    home = "/home/nit";
    packages = with pkgs; [
      fastfetch
      brave
      discord
      thunderbird
      vscode
      libreoffice-qt
      termius
      bitwarden-desktop
      moonlight-qt
      alsa-utils
      jdk
      tree
      git
      gns3-gui
      realvnc-vnc-viewer
      nmap
      gobuster
      wordlists
      virt-viewer
      iperf
      remmina
      tcpdump
      gns3-server
      btop
      ubridge
      xterm
      inetutils
    ];
  };

  security.wrappers.ubridge = {
    source = "${pkgs.ubridge}/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge"; # Assurez-vous que ce groupe existe ou utilisez "users"
    permissions = "u+rx,g+rx,o+rx";
  };

  # Services and programs
  services.libinput.enable = true;
  services.openssh.enable = true;

  programs.virt-manager.enable = true;
  programs.steam.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;  
}

