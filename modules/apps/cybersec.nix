{ lib, config, pkgs, ... }:
let
  cfg = config.cybersec;
in
{
  options.cybersec = {
    enable = lib.mkEnableOption "pentesting toolkit";
    recon.enable = lib.mkEnableOption "reconnaissance tools (nmap, amass, subfinder...)";
    web.enable = lib.mkEnableOption "web application testing (burpsuite, sqlmap, ffuf...)";
    code-scanning.enable = lib.mkEnableOption "code and secret scanning (gitleaks, semgrep...)";
    osint.enable = lib.mkEnableOption "OSINT tools (exiftool, holehe, sherlock...)";
    active-directory.enable = lib.mkEnableOption "Active Directory tools (bloodhound, netexec...)";
    mobile.enable = lib.mkEnableOption "mobile security tools (frida, apkleaks...)";
    network.enable = lib.mkEnableOption "network analysis (wireshark, tcpdump, bettercap...)";
    wireless.enable = lib.mkEnableOption "wireless attack tools (aircrack-ng, wifite2...)";
    crypto.enable = lib.mkEnableOption "crypto and steganography (steghide, hashcat...)";
    voip.enable = lib.mkEnableOption "VoIP testing (sipvicious, sipp)";
    passwords.enable = lib.mkEnableOption "password cracking (hashcat, john, seclists...)";
    privesc.enable = lib.mkEnableOption "privilege escalation tools";
    forensics.enable = lib.mkEnableOption "forensics and data recovery (scalpel, ddrescue...)";
    exploitation.enable = lib.mkEnableOption "exploitation frameworks (metasploit, mimikatz...)";
    reversing.enable = lib.mkEnableOption "reverse engineering (ghidra, radare2, gdb...)";
    enumeration.enable = lib.mkEnableOption "SMB/Windows enumeration (enum4linux, smbmap)";
    utilities.enable = lib.mkEnableOption "pentesting utilities (netcat, socat, openvpn...)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      lib.optionals cfg.recon.enable [
        nmap
        masscan
        rustscan
        amass
        subfinder
        fierce
        dnsrecon
        dnsenum
        theharvester
        nuclei
        feroxbuster
        dnsx
        waybackurls
        qsreplace
      ]
      ++ lib.optionals cfg.web.enable [
        burpsuite
        sqlmap
        nikto
        wpscan
        dirb
        gobuster
        ffuf
        arjun
        commix
        whatweb
        wafw00f
        joomscan
        httpx
        katana
        dalfox
        crlfuzz
        jaeles
      ]
      ++ lib.optionals cfg.code-scanning.enable [
        gitleaks
        trufflehog
        semgrep
        detect-secrets
        git-secrets
        whispers
        gitjacker
        git-dumper
      ]
      ++ lib.optionals cfg.osint.enable [
        exiftool
        holehe
        socialscan
        ghunt
        sherlock
      ]
      ++ lib.optionals cfg.active-directory.enable [
        bloodhound
        netexec
        kerbrute
        coercer
        adidnsdump
        ldapdomaindump
        donpapi
      ]
      ++ lib.optionals cfg.mobile.enable [
        frida-tools
        apkleaks
        python313Packages.pip
        android-tools
        aria2
      ]
      ++ lib.optionals cfg.network.enable [
        wireshark
        tcpdump
        ettercap
        bettercap
        responder
        proxychains
        macchanger
        arping
        netdiscover
      ]
      ++ lib.optionals cfg.wireless.enable [
        aircrack-ng
        wifite2
        reaverwps-t6x
        kismet
        hostapd-mana
        horst
        mdk4
        pixiewps
      ]
      ++ lib.optionals cfg.crypto.enable [
        steghide
        stegseek
        zsteg
        stegsolve
        haiti
      ]
      ++ lib.optionals cfg.voip.enable [
        sipvicious
        sipp
      ]
      ++ lib.optionals cfg.passwords.enable [
        hashcat
        john
        crunch
        cewl
        chntpw
        samdump2
        seclists
        payloadsallthethings
      ]
      ++ lib.optionals cfg.privesc.enable [
        linux-exploit-suggester
        traitor
      ]
      ++ lib.optionals cfg.forensics.enable [
        scalpel
        dcfldd
        ddrescue
      ]
      ++ lib.optionals cfg.exploitation.enable [
        metasploit
        exploitdb
        mimikatz
      ]
      ++ lib.optionals cfg.reversing.enable [
        ghidra
        radare2
        gdb
        ltrace
        strace
        binwalk
        hexedit
      ]
      ++ lib.optionals cfg.enumeration.enable [
        enum4linux
        smbmap
      ]
      ++ lib.optionals cfg.utilities.enable [
        netcat
        socat
        openvpn
        testssl
        brave
      ];
  };
}
