{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      geist-font
      nerd-fonts.geist-mono
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
