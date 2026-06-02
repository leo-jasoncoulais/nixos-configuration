{ config, inputs, ... }:
let
  secrets = import /etc/nixos/secrets/secrets.nix;
in
{
  age.identityPaths = [ "/etc/ssh/system-wg-ssh-key" ];
  age.secrets.wg-key-nixos = {
    file = /etc/nixos/secrets/keys/wg-key-nixos.age;
  };
  age.secrets.wg-checkpoint-key-nixos = {
    file = /etc/nixos/secrets/keys/wg-checkpoint-key-nixos.age;
  };
  age.secrets.wg-docker-project-key-nixos = {
    file = /etc/nixos/secrets/keys/wg-docker-project-key-nixos.age;
  };


  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.resolvconf.extraConfig = ''
    name_servers="172.30.0.2"
  '';

  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        ips = [ "172.30.0.5/32" ];
        listenPort = 51820;
        privateKeyFile = config.age.secrets.wg-key-nixos.path;
	mtu = 1400;        

        peers = [
          {
            publicKey = "nQ2/+sCfQAlR1xslmlOTqAkekVxJLFdhMPEIXmCVKiI=";
            allowedIPs = [ "172.30.0.0/24" ];
            endpoint = secrets.wireguard-endpoint;
            persistentKeepalive = 15;
          }
        ];
      };
      checkpoint = {
        ips = [ "172.40.0.6/32" ];
        listenPort = 51830;
        privateKeyFile = config.age.secrets.wg-checkpoint-key-nixos.path;


        peers = [
          {
            publicKey = "nQ2/+sCfQAlR1xslmlOTqAkekVxJLFdhMPEIXmCVKiI=";
            allowedIPs = [ "172.40.0.0/24" ];
            endpoint = secrets.wireguard-endpoint; 
            persistentKeepalive = 15;
          }
        ]; 
      };
    };
  };
}
