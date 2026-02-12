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
      wg-docker = {
        ips = [ "10.182.248.21/32" ];
        listenPort = 51840;
        privateKeyFile = config.age.secrets.wg-docker-project-key-nixos.path;


        peers = [
          {
            publicKey = "96J7uow8+162hxlJSaU1jvebsxEeEPztR4WkZirQBD0=";
            presharedKey = "Yy0e8d3IL+XcKEyH32dz2caN8i/Wqm6KWZntrTmOdCE=";
            allowedIPs = [ "192.168.5.0/24" "10.182.248.0/24" ];
            endpoint = secrets.wireguard-docker-endpoint; 
            persistentKeepalive = 15;
          }
        ]; 
      };
    };
  };
}
