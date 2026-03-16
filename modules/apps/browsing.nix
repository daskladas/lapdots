{ lib, config, pkgs, ... }:
let
  cfg = config.apps.browsing;
in
{
  options.apps.browsing = {
    enable = lib.mkEnableOption "browsing (Chromium with extensions and policies)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      chromium
    ];

    programs.chromium = {
      enable = lib.mkDefault true;
      extraOpts = {
        "AudioSandboxEnabled" = false;
        "AutofillAddressEnabled" = false;
        "AutofillCreditCardEnabled" = false;
        "BlockThirdPartyCookies" = true;
        "BraveAIChatEnabled" = 0;
        "BraveNewsDisabled" = 1;
        "BraveRewardsDisabled" = 1;
        "BraveTalkDisabled" = 1;
        "BraveVPNDisabled" = 1;
        "BraveWalletDisabled" = 1;
        "DefaultSearchProviderEnabled" = true;
        "RestoreOnStartup" = 4;
        "RestoreOnStartupURLs" = [ "https://start.duckduckgo.com/" ];
        "DefaultSearchProviderName" = "DuckDuckGo";
        "NewTabPageLocation" = "https://start.duckduckgo.com/";
        "DefaultSearchProviderSearchURL" = "https://start.duckduckgo.com/";
        "DefaultSearchProviderSuggestURL" = "https://start.duckduckgo.com/";
        "MetricsReportingEnabled" = false;
        "PasswordManagerEnabled" = false;
        "SafeBrowsingExtendedReportingEnabled" = false;
      };
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "oldceeleldhonbafppcapldpdifcinji" # LanguageTool
        "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
        "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
        "cfhdojbkjhnklbpkdaibdccddilifddb" # Adblock Plus
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "ponfpcnoihfmfllpaingbgckeeldkhle" # YouTube Enhancer
        "fnaicdffflnofjppbagibeoednhnbjhg" # Floccus Bookmarks
      ];
    };
  };
}
