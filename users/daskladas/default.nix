{ pkgs, username, ... }:
{
  programs.zsh.enable = true;
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    hashedPassword = "$6$njBllPCQRPWKq.BU$0ChHmC6Ec4n5EZYXy3bdZE3EW2b6xaHixRADIrYo0KGj7hCoJpyetRfRtg8/qFKsjhrMS.3k4nZG6yl1VBXSP.";
    extraGroups = [
      "wheel"
      "input"
      "openrazer"
    ];
  };
  users.defaultUserShell = pkgs.zsh;
}
