{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    
    # === RECONNAISSANCE ===
    nmap              # Network port scanner
    masscan           # Fast port scanner
    rustscan          # Ultra-fast port scanner
    amass             # Subdomain enumeration
    subfinder         # Subdomain discovery
    fierce            # DNS reconnaissance
    dnsrecon          # DNS enumeration
    dnsenum           # DNS information gathering
    theharvester      # Email/domain OSINT
    sherlock          # Username search across platforms
    nuclei            # Fast vulnerability scanner based on YAML templates
    feroxbuster       # Recursive content discovery
    dnsx              # Multi-purpose dns scanner
    waybackurls       # Fetcher for Wayback-Machine
    qsreplace         # Replace query string values in URLs    

    # === WEB APPLICATION TESTING ===
    burpsuite         # Web vulnerability scanner/proxy
    sqlmap            # SQL injection tool
    nikto             # Web server scanner
    wpscan            # WordPress vulnerability scanner
    dirb              # Web directory brute-forcer
    gobuster          # Directory/DNS brute-forcer
    ffuf              # Fast web fuzzer
    arjun             # HTTP parameter discovery
    commix            # Command injection exploiter
    whatweb	      # Web Scanner
    wafw00f	      # Scanner for WAF
    joomscan	      # Scanner for Joomla
    httpx             # Muli-purpose HTTP toolkit
    katana 	      # Next-gen web crawler
    dalfox            # Parameter analysis and XSS scanning tool
    crlfuzz           # CRLF vulnerability scanner
    jaeles            # Automated web application testing framework

    # === CODE/SECRET SCANNING ===
    gitleaks          # Scan git repos for secrets
    trufflehog        # Find credentials in git repositories
    semgrep           # Lightweight static analysis for many languages
    detect-secrets    # Enterprise tool for preventing secrets in code
    git-secrets       # Prevents committing secrets to git repos
    whispers          # Identify hardcoded secrets in static structured text
    gitjacker         # Hijack traffic from vulnerable .git folders
    git-dumper        # Tool to dump git repos from websites  
   
    # === OSINT ===
    exiftool          # Read/write metadata from files
    holehe            # Check if email exists on 120+ sites
    socialscan        # Check email/username availability on platforms
    ghunt             # Investigate Google accounts with emails

    # === ACTIVE DIRECTORY ===
    bloodhound        # AD attack path analysis
    netexec           # fork of CrackMapExec
    kerbrute          # Kerberos bruteforce
    coercer           # Windows hosts to authenticate to attacker
    adidnsdump        # Dump AD Integrated DNS records
    ldapdomaindump    # Dump domain information via LDAP
    donpapi	      # Dump secrets using DPAPI

    # === MOBILE ===
    frida-tools       # Dynamic instrumentation toolkit
    apkleaks          # Scanning APK files for URIs, endpoints & secrets
    python313Packages.pip       # python 3 language
    android-tools     # needed for rooting phones
    aria2             # download ROMs for rooting phones  

    # === NETWORK ANALYSIS ===
    wireshark         # Network protocol analyzer
    tcpdump           # Packet capture tool
    ettercap          # Network MITM framework
    bettercap         # Network attack/monitoring
    responder         # LLMNR/NBT-NS poisoner
    proxychains       # Route connections through proxy chains
    macchanger        # MAC-Adress spoofer
    arping	      # Broadcast who arp answers
    netdiscover       # Simple ARP
    
    # === WIRELESS ATTACKS ===
    aircrack-ng       # WiFi security testing suite
    wifite2           # Automated WiFi attack tool
    reaverwps-t6x     # WPS attack tool
    kismet            # Wireless network detector
    hostapd-mana      # Rogue access point
    horst             # Wireless 802.11 network monitor
    mdk4              # Wireless fuzzing/testing tool
    pixiewps          # WPS Pixie Dust attack    
  
    # === CRYPTO & STEGANOGRAPHY ===
    steghide          # Hide data in images/audio
    stegseek          # Steghide password cracker
    zsteg             # Detect stegano-hidden data in PNG/BMP
    stegsolve         # Steganography analysis tool with filters
    haiti             # Hash type identifier (modern)
    
    # === VOIP TESTING ===  
    sipvicious        # SIP protocol security tools
    sipp              # SIP protocol traffic generator

    # === PASSWORD CRACKING ===
    hashcat           # GPU-accelerated password cracker
    john              # CPU-based password cracker
    crunch            # Wordlist generator
    cewl              # Custom wordlist from websites
    chntpw            # Windows Password Editor
    samdump2          # Dump password hashes by NT/XP
    seclists          # Collection of multiple types of security wordlists
    payloadsallthethings # List of useful payloads and bypasses

    # === PRIVILEGE ESCALATION ===
    linux-exploit-suggester  # Suggest exploits based on Linux kernel version
    traitor                  # Automatic linux privilege escalator

    # === FORENSICS & DATA RECOVERY ===
    scalpel           # Fast file carving tool
    dcfldd	      # Enhanced dd for forensics
    ddrescue          # Data recovery from failing drives

    # === EXPLOITATION ===
    metasploit        # Exploitation framework
    exploitdb         # Exploit database
    mimikatz          # Windows credential dumper
    
    # === REVERSE ENGINEERING ===
    ghidra            # Software reverse engineering suite
    radare2           # Reverse engineering framework
    gdb               # GNU debugger
    ltrace            # Library call tracer
    strace            # System call tracer
    binwalk           # Firmware analysis tool
    hexedit           # Terminal hex editor

    # === ENUMERATION ===
    enum4linux        # SMB/Windows enumeration
    smbmap            # SMB share enumerator
    
    # === UTILITIES ===
    netcat            # Network connection utility
    socat             # Bidirectional data relay
    openvpn           # VPN client
    testssl           # TLS/SSL security tester
    brave             # Privacy-focused browser
  ];
}
