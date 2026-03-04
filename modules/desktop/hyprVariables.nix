{
  monitorSetup = {
    Desktop = ''
      # ---- Desktop-specific Monitor Setup ---- #
      monitor = HDMI-A-1, 1920x1080@240, 0x0, 1
      monitor = HDMI-A-2, 1920x1080@240, 1920x0, 1
      workspace = 1,  monitor:HDMI-A-1, default:true
      workspace = 2,  monitor:HDMI-A-2
      workspace = 3,  monitor:HDMI-A-1
      workspace = 4,  monitor:HDMI-A-2
      workspace = 5,  monitor:HDMI-A-1
      workspace = 6,  monitor:HDMI-A-2, default:true
      workspace = 7,  monitor:HDMI-A-1
      workspace = 8,  monitor:HDMI-A-2
      workspace = 9,  monitor:HDMI-A-1
      workspace = 10, monitor:HDMI-A-2
    '';
Laptop = ''
      # ---- Laptop-specific Monitor Setup ---- #
      # Laptop links
      monitor = eDP-1, 1920x1080@60, 0x0, 1
      
      # DP-5 in der Mitte mit 240Hz
      monitor = DP-5, 1920x1080@240, 1920x0, 1
      
      # DP-6 rechts mit 240Hz
      monitor = DP-6, 1920x1080@240, 3840x0, 1
      
      # Workspace-Zuweisung (je 2 pro Monitor)
      # Laptop (eDP-1): 1 und 4
      workspace = 1, monitor:eDP-1, default:true
      workspace = 4, monitor:eDP-1
      
      # Erster externer: 2 und 5
      workspace = 2, monitor:DP-5, default:true
      workspace = 5, monitor:DP-5
      
      # Zweiter externer: 3 und 6
      workspace = 3, monitor:DP-6, default:true
      workspace = 6, monitor:DP-6
      
      # Fallback für unbekannte Monitore
      monitor = , preferred, auto, 1
    '';
  };
  WindowRules = {
    Desktop = ''
      # General layout rule for workspace 2
      workspace    = 2,split:v
      windowrule = workspace 2 silent, match:class ^(discord)$
      windowrule = tile 1, match:class ^(discord)$
      windowrule = workspace 2 silent, match:title ^(Spotify Premium)$
      windowrule = tile 1, match:title ^(Spotify Premium)$
      # General layout rule for workspace 7
      windowrule = workspace 7 silent, match:class ^(steam)$
    '';
    Laptop = '''';
  };
}
