{ config, username, ... }:
{
  security.sudo.extraRules = [{
    users = [ username ];
    commands = [{
      command = "/run/current-system/sw/bin/killall";
      options = [ "NOPASSWD" ];
    }];
  }];
}
