{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    # ══════════════════════════════════════════════════════════════
    # THUNAR CORE + PLUGINS
    # ══════════════════════════════════════════════════════════════
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.xfconf
    
    # ══════════════════════════════════════════════════════════════
    # FEHLEND: Thumbnails
    # ══════════════════════════════════════════════════════════════
    xfce.tumbler
    ffmpegthumbnailer
    webp-pixbuf-loader
    poppler
    libgsf
    
    # ══════════════════════════════════════════════════════════════
    # FEHLEND: Archive
    # ══════════════════════════════════════════════════════════════
    xarchiver
    p7zip
    unrar
    
    # ══════════════════════════════════════════════════════════════
    # FEHLEND: Netzwerk & Utils
    # ══════════════════════════════════════════════════════════════
    gvfs
    sshfs
    cifs-utils
    fd
    fzf
    trash-cli
    imagemagick
    mediainfo
    file
  ];

  services.gvfs.enable = true;

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar.desktop";
    "inode/mount-point" = "thunar.desktop";
  };

  xfconf.settings = {
    thunar = {
      # Ansicht
      "/default-view" = "ThunarDetailsView";
      "/last-view" = "ThunarDetailsView";
      "/last-icon-view-zoom-level" = "THUNAR_ZOOM_LEVEL_100_PERCENT";
      "/last-details-view-zoom-level" = "THUNAR_ZOOM_LEVEL_50_PERCENT";
      "/last-compact-view-zoom-level" = "THUNAR_ZOOM_LEVEL_25_PERCENT";
      
      # Spalten
      "/last-details-view-column-order" = "THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_SIZE_IN_BYTES,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_DATE_ACCESSED,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_PERMISSIONS";
      "/last-details-view-visible-columns" = "THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED";
      "/last-details-view-fixed-columns" = true;
      
      # Versteckte Dateien & Sortierung
      "/last-show-hidden" = true;
      "/last-sort-column" = "THUNAR_COLUMN_NAME";
      "/last-sort-order" = "GTK_SORT_ASCENDING";
      "/misc-folders-first" = true;
      "/misc-case-sensitive" = false;
      
      # Thumbnails
      "/misc-thumbnail-mode" = "THUNAR_THUMBNAIL_MODE_ALWAYS";
      "/misc-thumbnail-draw-frames" = true;
      "/misc-thumbnail-max-file-size" = 4294967296;
      
      # Verhalten
      "/misc-single-click" = false;
      "/misc-middle-click-in-tab" = true;
      "/misc-open-new-window-as-tab" = true;
      "/misc-directory-specific-settings" = false;
      "/misc-remember-geometry" = true;
      "/misc-show-delete-action" = true;
      "/misc-confirm-move-to-trash" = false;
      "/misc-recursive-permissions" = "THUNAR_RECURSIVE_PERMISSIONS_ASK";
      "/misc-transfer-verify-file" = "THUNAR_TRANSFER_VERIFY_FILE_CHECKSUM_IF_POSSIBLE";
      "/misc-parallel-copy-mode" = "THUNAR_PARALLEL_COPY_MODE_ALWAYS";
      "/misc-full-path-in-tab" = false;
      "/misc-full-path-in-title" = true;
      
      # Darstellung
      "/misc-file-size-binary" = true;
      "/misc-date-style" = "THUNAR_DATE_STYLE_LONG";
      "/misc-text-beside-icons" = false;
      "/misc-symbolic-icons-in-toolbar" = true;
      "/misc-highlighting-enabled" = true;
      
      # Seitenleiste
      "/last-side-pane" = "ThunarShortcutsPane";
      "/last-separator-position" = 200;
      "/shortcuts-icon-size" = "THUNAR_ICON_SIZE_24";
      "/tree-icon-size" = "THUNAR_ICON_SIZE_16";
      "/misc-image-size-in-statusbar" = true;
      
      # Fenster
      "/last-window-width" = 1200;
      "/last-window-height" = 800;
      "/last-window-maximized" = false;
      "/last-menubar-visible" = true;
      "/last-statusbar-visible" = true;
      "/last-location-bar" = "ThunarLocationEntry";
      "/misc-open-new-windows-in-split-view" = false;
      "/last-splitview-separator-position" = 600;
    };

    thunar-volman = {
      "/automount-drives/enabled" = true;
      "/automount-media/enabled" = true;
      "/autoopen/enabled" = false;
      "/autorun/enabled" = false;
    };
  };

  xdg.configFile."tumbler/tumbler.rc".text = ''
    [Tumbler]
    MaxFileSize=4294967296
    
    [DesktopThumbnailer]
    Disabled=false
    
    [FFMpegThumbnailer]
    Disabled=false
    MaxFileSize=4294967296
    
    [PixbufThumbnailer]
    Disabled=false
    
    [PopplerThumbnailer]
    Disabled=false
    
    [OdfThumbnailer]
    Disabled=false
    
    [FontThumbnailer]
    Disabled=false
  '';

  xdg.configFile."gtk-3.0/bookmarks".text = ''
    file:///home/daskladas/Downloads Downloads
    file:///home/daskladas/Documents Dokumente
    file:///home/daskladas/Pictures Bilder
    file:///home/daskladas/Videos Videos
    file:///home/daskladas/Music Musik
    file:///home/daskladas/.config Config
    file:///tmp Temp
    file:///mnt Mounts
  '';

  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- BASIS -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>utilities-terminal</icon>
        <name>Kitty hier</name>
        <submenu></submenu>
        <unique-id>terminal-here</unique-id>
        <command>kitty --directory %f</command>
        <description>Kitty im aktuellen Ordner</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <action>
        <icon>edit-copy</icon>
        <name>Pfad kopieren</name>
        <submenu></submenu>
        <unique-id>copy-path</unique-id>
        <command>echo -n "%f" | wl-copy</command>
        <description>Pfad in Zwischenablage</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>edit-copy</icon>
        <name>Dateiname kopieren</name>
        <submenu></submenu>
        <unique-id>copy-name</unique-id>
        <command>basename "%f" | tr -d '\n' | wl-copy</command>
        <description>Nur Name kopieren</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>folder-open</icon>
        <name>Als Root öffnen</name>
        <submenu></submenu>
        <unique-id>open-root</unique-id>
        <command>pkexec thunar %f</command>
        <description>Mit Root-Rechten</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <action>
        <icon>view-refresh</icon>
        <name>Thumbnails neu laden</name>
        <submenu></submenu>
        <unique-id>refresh-thumbs</unique-id>
        <command>rm -rf ~/.cache/thumbnails/* &amp;&amp; notify-send "Thumbnails" "Cache geleert"</command>
        <description>Thumbnail-Cache leeren</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- INFO -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>dialog-information</icon>
        <name>Größe</name>
        <submenu>Info</submenu>
        <unique-id>calc-size</unique-id>
        <command>notify-send "Größe: %n" "$(du -sh %f | cut -f1)"</command>
        <description>Größe anzeigen</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>dialog-information</icon>
        <name>Details</name>
        <submenu>Info</submenu>
        <unique-id>file-info</unique-id>
        <command>kitty --hold -e bash -c "echo '=== %n ===' &amp;&amp; file '%f' &amp;&amp; echo &amp;&amp; stat '%f'"</command>
        <description>Datei-Details</description>
        <range>1</range>
        <patterns>*</patterns>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>dialog-information</icon>
        <name>EXIF-Daten</name>
        <submenu>Info</submenu>
        <unique-id>exif-info</unique-id>
        <command>kitty --hold -e bash -c "exiftool '%f' | bat --style=plain"</command>
        <description>EXIF anzeigen</description>
        <range>1</range>
        <patterns>*.jpg;*.jpeg;*.png;*.tiff;*.raw;*.cr2;*.nef;*.heic</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>video-x-generic</icon>
        <name>Medien-Info</name>
        <submenu>Info</submenu>
        <unique-id>media-info</unique-id>
        <command>kitty --hold -e mediainfo "%f"</command>
        <description>Video/Audio-Info</description>
        <range>1</range>
        <patterns>*.mp4;*.mkv;*.avi;*.mov;*.webm;*.mp3;*.flac;*.wav;*.ogg</patterns>
        <audio-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>drive-harddisk</icon>
        <name>SHA256</name>
        <submenu>Info</submenu>
        <unique-id>checksum</unique-id>
        <command>hash=$(sha256sum "%f" | cut -d' ' -f1) &amp;&amp; echo -n "$hash" | wl-copy &amp;&amp; notify-send "SHA256" "$hash (kopiert)"</command>
        <description>Hash berechnen</description>
        <range>1</range>
        <patterns>*</patterns>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>folder</icon>
        <name>Ordner-Statistik</name>
        <submenu>Info</submenu>
        <unique-id>folder-stats</unique-id>
        <command>kitty --hold -e bash -c "echo '=== %n ===' &amp;&amp; echo 'Dateien:' $(find '%f' -type f | wc -l) &amp;&amp; echo 'Ordner:' $(find '%f' -type d | wc -l) &amp;&amp; echo 'Größe:' $(du -sh '%f' | cut -f1) &amp;&amp; echo &amp;&amp; echo 'Top 10:' &amp;&amp; find '%f' -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10"</command>
        <description>Statistik</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- BILDER -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>image-x-generic</icon>
        <name>Als Wallpaper (swww)</name>
        <submenu>Bilder</submenu>
        <unique-id>set-wallpaper</unique-id>
        <command>swww img "%f" --transition-type grow --transition-pos center --transition-duration 1</command>
        <description>Als Hintergrund setzen</description>
        <range>1</range>
        <patterns>*.jpg;*.jpeg;*.png;*.webp;*.gif</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>object-rotate-right</icon>
        <name>90° rechts</name>
        <submenu>Bilder</submenu>
        <unique-id>rotate-right</unique-id>
        <command>mogrify -rotate 90 %F &amp;&amp; notify-send "Gedreht" "%N"</command>
        <description>Im Uhrzeigersinn</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.png;*.webp</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>object-rotate-left</icon>
        <name>90° links</name>
        <submenu>Bilder</submenu>
        <unique-id>rotate-left</unique-id>
        <command>mogrify -rotate -90 %F &amp;&amp; notify-send "Gedreht" "%N"</command>
        <description>Gegen Uhrzeigersinn</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.png;*.webp</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>view-fullscreen</icon>
        <name>50% verkleinern</name>
        <submenu>Bilder</submenu>
        <unique-id>resize-50</unique-id>
        <command>for f in %F; do mogrify -resize 50% "$f"; done &amp;&amp; notify-send "Verkleinert" "%N"</command>
        <description>Auf 50%</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.png;*.webp</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>view-fullscreen</icon>
        <name>1920px Breite</name>
        <submenu>Bilder</submenu>
        <unique-id>resize-1920</unique-id>
        <command>for f in %F; do mogrify -resize 1920x "$f"; done &amp;&amp; notify-send "Skaliert" "%N"</command>
        <description>Auf 1920px</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.png;*.webp</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>emblem-photos</icon>
        <name>→ PNG</name>
        <submenu>Bilder</submenu>
        <unique-id>convert-png</unique-id>
        <command>for f in %F; do convert "$f" "''${f%.*}.png"; done &amp;&amp; notify-send "Konvertiert" "%N → PNG"</command>
        <description>Zu PNG</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.webp;*.bmp;*.gif</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>emblem-photos</icon>
        <name>→ JPG</name>
        <submenu>Bilder</submenu>
        <unique-id>convert-jpg</unique-id>
        <command>for f in %F; do convert "$f" -quality 90 "''${f%.*}.jpg"; done &amp;&amp; notify-send "Konvertiert" "%N → JPG"</command>
        <description>Zu JPG</description>
        <range>*</range>
        <patterns>*.png;*.webp;*.bmp;*.gif</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>emblem-photos</icon>
        <name>→ WebP</name>
        <submenu>Bilder</submenu>
        <unique-id>convert-webp</unique-id>
        <command>for f in %F; do convert "$f" "''${f%.*}.webp"; done &amp;&amp; notify-send "Konvertiert" "%N → WebP"</command>
        <description>Zu WebP (kleiner)</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.png;*.bmp</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>edit-clear</icon>
        <name>EXIF entfernen</name>
        <submenu>Bilder</submenu>
        <unique-id>strip-exif</unique-id>
        <command>exiftool -all= -overwrite_original %F &amp;&amp; notify-send "EXIF entfernt" "%N"</command>
        <description>Metadaten löschen</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.png</patterns>
        <image-files/>
      </action>
      
      <action>
        <icon>applications-graphics</icon>
        <name>In GIMP öffnen</name>
        <submenu>Bilder</submenu>
        <unique-id>open-gimp</unique-id>
        <command>gimp %F</command>
        <description>Mit GIMP bearbeiten</description>
        <range>*</range>
        <patterns>*.jpg;*.jpeg;*.png;*.webp;*.gif;*.xcf;*.psd</patterns>
        <image-files/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- VIDEO -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>audio-x-generic</icon>
        <name>Audio → MP3</name>
        <submenu>Video</submenu>
        <unique-id>extract-mp3</unique-id>
        <command>for f in %F; do ffmpeg -i "$f" -vn -acodec libmp3lame -q:a 2 "''${f%.*}.mp3" -y; done &amp;&amp; notify-send "Extrahiert" "%N → MP3"</command>
        <description>Audio als MP3</description>
        <range>*</range>
        <patterns>*.mp4;*.mkv;*.avi;*.mov;*.webm</patterns>
        <video-files/>
      </action>
      
      <action>
        <icon>video-x-generic</icon>
        <name>→ MP4</name>
        <submenu>Video</submenu>
        <unique-id>convert-mp4</unique-id>
        <command>kitty -e bash -c 'for f in %F; do ffmpeg -i "$f" -c:v libx264 -crf 23 -c:a aac "''${f%.*}.mp4" -y; done &amp;&amp; notify-send "Konvertiert" "%N → MP4"'</command>
        <description>Zu MP4</description>
        <range>*</range>
        <patterns>*.mkv;*.avi;*.mov;*.webm;*.wmv</patterns>
        <video-files/>
      </action>
      
      <action>
        <icon>image-x-generic</icon>
        <name>Thumbnail</name>
        <submenu>Video</submenu>
        <unique-id>video-thumb</unique-id>
        <command>for f in %F; do ffmpeg -i "$f" -ss 00:00:05 -vframes 1 "''${f%.*}_thumb.jpg" -y; done &amp;&amp; notify-send "Thumbnail" "%N"</command>
        <description>Screenshot bei 5s</description>
        <range>*</range>
        <patterns>*.mp4;*.mkv;*.avi;*.mov;*.webm</patterns>
        <video-files/>
      </action>
      
      <action>
        <icon>video-x-generic</icon>
        <name>→ GIF (10s)</name>
        <submenu>Video</submenu>
        <unique-id>video-gif</unique-id>
        <command>for f in %F; do ffmpeg -i "$f" -t 10 -vf "fps=15,scale=480:-1" "''${f%.*}.gif" -y; done &amp;&amp; notify-send "GIF erstellt" "%N"</command>
        <description>GIF aus ersten 10s</description>
        <range>*</range>
        <patterns>*.mp4;*.mkv;*.webm</patterns>
        <video-files/>
      </action>
      
      <action>
        <icon>media-playback-start</icon>
        <name>In VLC öffnen</name>
        <submenu>Video</submenu>
        <unique-id>open-vlc</unique-id>
        <command>vlc %F</command>
        <description>Mit VLC abspielen</description>
        <range>*</range>
        <patterns>*.mp4;*.mkv;*.avi;*.mov;*.webm;*.mp3;*.flac</patterns>
        <video-files/>
        <audio-files/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- ARCHIV -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>package-x-generic</icon>
        <name>Hier entpacken</name>
        <submenu>Archiv</submenu>
        <unique-id>extract-here</unique-id>
        <command>for f in %F; do 7z x -o"%d" "$f" -y; done &amp;&amp; notify-send "Entpackt" "%N"</command>
        <description>Im Ordner entpacken</description>
        <range>*</range>
        <patterns>*.zip;*.7z;*.rar;*.tar;*.tar.gz;*.tar.xz;*.tar.bz2;*.tgz;*.gz;*.bz2;*.xz</patterns>
        <other-files/>
      </action>
      
      <action>
        <icon>package-x-generic</icon>
        <name>In Ordner entpacken</name>
        <submenu>Archiv</submenu>
        <unique-id>extract-folder</unique-id>
        <command>for f in %F; do 7z x -o"''${f%.*}" "$f" -y; done &amp;&amp; notify-send "Entpackt" "%N"</command>
        <description>Eigener Ordner</description>
        <range>*</range>
        <patterns>*.zip;*.7z;*.rar;*.tar;*.tar.gz;*.tar.xz;*.tar.bz2;*.tgz</patterns>
        <other-files/>
      </action>
      
      <action>
        <icon>package-x-generic</icon>
        <name>Inhalt anzeigen</name>
        <submenu>Archiv</submenu>
        <unique-id>archive-list</unique-id>
        <command>kitty --hold -e 7z l "%f"</command>
        <description>Archiv-Inhalt</description>
        <range>1</range>
        <patterns>*.zip;*.7z;*.rar;*.tar;*.tar.gz;*.tar.xz;*.tgz</patterns>
        <other-files/>
      </action>
      
      <action>
        <icon>package-x-generic</icon>
        <name>→ ZIP</name>
        <submenu>Archiv</submenu>
        <unique-id>compress-zip</unique-id>
        <command>zip -r "%d/%n.zip" %N &amp;&amp; notify-send "Komprimiert" "%N → ZIP"</command>
        <description>Als ZIP</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>package-x-generic</icon>
        <name>→ 7z</name>
        <submenu>Archiv</submenu>
        <unique-id>compress-7z</unique-id>
        <command>7z a "%d/%n.7z" %N &amp;&amp; notify-send "Komprimiert" "%N → 7z"</command>
        <description>Als 7z (beste Kompression)</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>package-x-generic</icon>
        <name>→ tar.zst</name>
        <submenu>Archiv</submenu>
        <unique-id>compress-zstd</unique-id>
        <command>tar --zstd -cvf "%d/%n.tar.zst" -C "%d" %N &amp;&amp; notify-send "Komprimiert" "%N → tar.zst"</command>
        <description>Als tar.zst (schnell)</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- ÖFFNEN MIT -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>text-editor</icon>
        <name>VSCodium</name>
        <submenu>Öffnen mit</submenu>
        <unique-id>open-vscodium</unique-id>
        <command>codium %F</command>
        <description>In VSCodium öffnen</description>
        <range>*</range>
        <patterns>*</patterns>
        <text-files/>
        <other-files/>
        <directories/>
      </action>
      
      <action>
        <icon>text-editor</icon>
        <name>Neovim</name>
        <submenu>Öffnen mit</submenu>
        <unique-id>open-nvim</unique-id>
        <command>kitty -e nvim %F</command>
        <description>In Neovim öffnen</description>
        <range>*</range>
        <patterns>*</patterns>
        <text-files/>
        <other-files/>
      </action>
      
      <action>
        <icon>text-x-generic</icon>
        <name>bat (Syntax)</name>
        <submenu>Öffnen mit</submenu>
        <unique-id>open-bat</unique-id>
        <command>kitty --hold -e bat --style=full "%f"</command>
        <description>Mit Highlighting</description>
        <range>1</range>
        <patterns>*</patterns>
        <text-files/>
      </action>
      
      <action>
        <icon>document-open</icon>
        <name>Zathura (PDF)</name>
        <submenu>Öffnen mit</submenu>
        <unique-id>open-zathura</unique-id>
        <command>zathura %F</command>
        <description>PDF in Zathura</description>
        <range>*</range>
        <patterns>*.pdf;*.epub;*.djvu</patterns>
        <other-files/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- SUCHEN -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>edit-find</icon>
        <name>Dateien suchen (fd)</name>
        <submenu>Suchen</submenu>
        <unique-id>search-fd</unique-id>
        <command>kitty -e bash -c 'cd "%f" &amp;&amp; echo "Suche in: %f" &amp;&amp; read -p "Name: " q &amp;&amp; fd --color=always "$q" | less -R'</command>
        <description>Nach Name</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <action>
        <icon>edit-find</icon>
        <name>In Dateien suchen (rg)</name>
        <submenu>Suchen</submenu>
        <unique-id>search-rg</unique-id>
        <command>kitty -e bash -c 'cd "%f" &amp;&amp; echo "Suche in: %f" &amp;&amp; read -p "Text: " q &amp;&amp; rg --color=always "$q" | less -R'</command>
        <description>Text in Dateien</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <action>
        <icon>edit-find</icon>
        <name>Große Dateien (&gt;100MB)</name>
        <submenu>Suchen</submenu>
        <unique-id>find-large</unique-id>
        <command>kitty --hold -e bash -c 'find "%f" -type f -size +100M -exec du -h {} + | sort -rh | head -20'</command>
        <description>Dateien &gt;100MB</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- GIT -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>git</icon>
        <name>Status</name>
        <submenu>Git</submenu>
        <unique-id>git-status</unique-id>
        <command>kitty --hold -e git -C "%f" status</command>
        <description>Git Status</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <action>
        <icon>git</icon>
        <name>Log</name>
        <submenu>Git</submenu>
        <unique-id>git-log</unique-id>
        <command>kitty --hold -e git -C "%f" log --oneline --graph -30</command>
        <description>Git Log</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <action>
        <icon>git</icon>
        <name>Pull</name>
        <submenu>Git</submenu>
        <unique-id>git-pull</unique-id>
        <command>kitty --hold -e git -C "%f" pull</command>
        <description>Git Pull</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <action>
        <icon>git</icon>
        <name>GitHub öffnen</name>
        <submenu>Git</submenu>
        <unique-id>gh-browse</unique-id>
        <command>cd "%f" &amp;&amp; gh browse</command>
        <description>Im Browser öffnen</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
      <!-- ═══════════════════════════════════════════════════════════ -->
      <!-- SONSTIGES -->
      <!-- ═══════════════════════════════════════════════════════════ -->
      
      <action>
        <icon>emblem-symbolic-link</icon>
        <name>Symlink erstellen</name>
        <submenu></submenu>
        <unique-id>create-symlink</unique-id>
        <command>for f in %F; do ln -s "$f" "%d/$(basename "$f").link"; done &amp;&amp; notify-send "Symlink" "%N"</command>
        <description>Symbolischen Link</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>folder-new</icon>
        <name>In neuen Ordner</name>
        <submenu></submenu>
        <unique-id>move-to-folder</unique-id>
        <command>name=$(zenity --entry --title="Neuer Ordner" --text="Name:") &amp;&amp; mkdir -p "%d/$name" &amp;&amp; mv %F "%d/$name/" &amp;&amp; notify-send "Verschoben" "%N → $name"</command>
        <description>In Ordner verschieben</description>
        <range>*</range>
        <patterns>*</patterns>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>user-trash</icon>
        <name>In Papierkorb</name>
        <submenu></submenu>
        <unique-id>trash-files</unique-id>
        <command>trash-put %F &amp;&amp; notify-send "Papierkorb" "%N"</command>
        <description>Sicher löschen</description>
        <range>*</range>
        <patterns>*</patterns>
        <directories/>
        <audio-files/>
        <image-files/>
        <other-files/>
        <text-files/>
        <video-files/>
      </action>
      
      <action>
        <icon>edit-clear</icon>
        <name>Leere Ordner löschen</name>
        <submenu></submenu>
        <unique-id>delete-empty</unique-id>
        <command>count=$(find "%f" -type d -empty | wc -l) &amp;&amp; find "%f" -type d -empty -delete &amp;&amp; notify-send "Gelöscht" "$count leere Ordner"</command>
        <description>Leere Unterordner</description>
        <range></range>
        <patterns>*</patterns>
        <directories/>
      </action>
      
    </actions>
  '';

  xdg.configFile."Thunar/accels.scm".text = ''
    (gtk_accel_path "<Actions>/ThunarWindow/open-terminal" "<Primary>Return")
    (gtk_accel_path "<Actions>/ThunarWindow/reload" "F5")
    (gtk_accel_path "<Actions>/ThunarWindow/show-hidden" "<Primary>h")
    (gtk_accel_path "<Actions>/ThunarWindow/zoom-in" "<Primary>plus")
    (gtk_accel_path "<Actions>/ThunarWindow/zoom-out" "<Primary>minus")
    (gtk_accel_path "<Actions>/ThunarWindow/zoom-reset" "<Primary>0")
    (gtk_accel_path "<Actions>/ThunarWindow/view-as-detailed-list" "<Primary>1")
    (gtk_accel_path "<Actions>/ThunarWindow/view-as-icons" "<Primary>2")
    (gtk_accel_path "<Actions>/ThunarWindow/view-as-compact-list" "<Primary>3")
    (gtk_accel_path "<Actions>/ThunarStandardView/create-folder" "<Primary><Shift>n")
    (gtk_accel_path "<Actions>/ThunarWindow/toggle-split-view" "F3")
    (gtk_accel_path "<Actions>/ThunarWindow/new-tab" "<Primary>t")
    (gtk_accel_path "<Actions>/ThunarWindow/close-tab" "<Primary>w")
    (gtk_accel_path "<Actions>/ThunarWindow/close-window" "<Primary>q")
    (gtk_accel_path "<Actions>/ThunarStandardView/select-all-files" "<Primary>a")
    (gtk_accel_path "<Actions>/ThunarWindow/open-parent" "<Alt>Up")
    (gtk_accel_path "<Actions>/ThunarWindow/back" "<Alt>Left")
    (gtk_accel_path "<Actions>/ThunarWindow/forward" "<Alt>Right")
    (gtk_accel_path "<Actions>/ThunarStandardView/rename" "F2")
    (gtk_accel_path "<Actions>/ThunarStandardView/trash-delete" "Delete")
    (gtk_accel_path "<Actions>/ThunarWindow/open-location" "<Primary>l")
    (gtk_accel_path "<Actions>/ThunarWindow/search" "<Primary>f")
  '';
}
