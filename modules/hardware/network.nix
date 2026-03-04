{
  lib,
  username,
  pkgs,
  ...
}:
{
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      plugins = with pkgs; [
        networkmanager-l2tp
      ];
    };
    
    wireguard.enable = true;
    
    firewall = {
      enable = true;
      trustedInterfaces = [ "wg_config" "wg+" "alberto" "tailscale0" ];
      
      allowedTCPPorts = [
        53317 # localsend
      ];
      allowedUDPPorts = [
        53317 # localsend
        500   # IPsec IKE
        4500  # IPsec NAT-T
        51328 # WireGuard
        41641 # Tailscale
      ];
      
      allowPing = true;
      logReversePathDrops = true;
      logRefusedConnections = true;
    };
  };

  # IPsec/strongSwan Support
  services.strongswan = {
    enable = true;
    secrets = [ "ipsec.d/ipsec.secrets" ];
  };

  # Tailscale VPN
  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    wireguard-tools
    strongswan
    networkmanager-l2tp
    xl2tpd
    tailscale
  ];

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };

  programs.traceroute.enable = true;
}
