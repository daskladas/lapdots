{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Deine gewünschten Fun-Tools
    cmatrix         # Matrix-Regen-Effekt
    sl              # Steam Locomotive für falsch getipptes 'ls'
    cowsay          # Kuh sagt Dinge in Sprechblasen
    figlet          # ASCII-Art Text in großen Buchstaben
    lolcat          # Regenbogen-farbiger Text
    fortune         # Zufällige Sprüche und Weisheiten
    toilet          # Noch mehr ASCII-Art Text-Styles
    asciiquarium    # Aquarium im Terminal
    pipes           # Screensaver mit bunten Rohren
    cbonsai         # Bonsai-Baum wächst im Terminal
    
    # Zusätzliche Tools
    mapscii         # Weltkarte im Terminal
    peaclock        # Terminal-Uhr
    cava            # Audio-Visualizer (der beste für NixOS)
    bastet          # Tetris im Terminal
    gotop           # System-Monitor
    bb              # ASCII-Art Demo
  ];
}
