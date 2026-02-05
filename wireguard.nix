{ config, inputs, ... }:
let
  secrets = import ./secrets/secrets.nix;
in
{
  age.identityPaths = [ "/etc/ssh/system-wg-ssh-key" ];
  age.secrets.wg-key-nixos = {
    file = ./secrets/keys/wg-key-nixos.age;
  };
  age.secrets.wg-checkpoint-key-nixos = {
    file = ./secrets/keys/wg-checkpoint-key-nixos.age;
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
        

        peers = [
          {
            publicKey = "nQ2/+sCfQAlR1xslmlOTqAkekVxJLFdhMPEIXmCVKiI=";
            presharedKey = "cxRMeype8/V1MMtakr8DU+pM2G0BcmFK2l0WwU7VRZw=";
            allowedIPs = [ "172.30.0.0/24" ];
            endpoint = secrets.wireguard-endpoint;
            persistentKeepalive = 15;
          }
        ];
      };
      wg0-check = {
        ips = [ "172.40.0.6/32" ];
        listenPort = 51830;
        privateKeyFile = config.age.secrets.wg-checkpoint-key-nixos.path;


        peers = [
          {
            publicKey = "nQ2/+sCfQAlR1xslmlOTqAkekVxJLFdhMPEIXmCVKiI=";
            presharedKey = "QppaG5WlcnRgri0PNInASGnR5yFhCIRSLy+pB4BqQy8=";
            allowedIPs = [ "172.40.0.0/24" ];
            endpoint = secrets.wireguard-endpoint; 
            persistentKeepalive = 15;
          }
        ]; 
      };
    };
  };
}
