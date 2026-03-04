{ pkgs, username, ... }:
let
  EQPath = ".config/pipewire/EQ.txt";
in
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  # PulseAudio explizit aus (Pipewire übernimmt)
  services.pulseaudio.enable = false;

  environment.systemPackages = [ pkgs.helvum ];

  home-manager.users.${username} = {
    home.file = {
      ".config/pipewire/pipewire.conf.d/my-parametric-equalizer.conf".text = ''
        context.modules = [
          {
            name = "libpipewire-module-parametric-equalizer"
            args = {
              node.name = "parametric-equalizer"
              media.class = "Audio/Sink"
              equalizer.filepath = "${EQPath}"
              equalizer.description = "EQ Sink"
            }
          }
        ]
      '';
      ".config/pipewire/EQ.txt".source = ./parametric.txt;
    };
  };
}
