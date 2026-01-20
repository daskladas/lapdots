{ lib, pkgs, ... }:
{
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
      "BraveAIChatEnabled" = 0; # Disable Brave AI Chat
      "BraveNewsDisabled" = 1; # Disable Brave News
      "BraveRewardsDisabled" = 1; # Disable Brave Rewards
      "BraveTalkDisabled" = 1; # Disable Brave Talk
      "BraveVPNDisabled" = 1; # Disable Brave VPN
      "BraveWalletDisabled" = 1; # Disable Brave Wallet
      "DefaultSearchProviderEnabled" = true;
      "RestoreOnStartup" = 4; # Restore specified pages
      "RestoreOnStartupURLs" = [ "https://start.duckduckgo.com/" ]; # Default Startup URL
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
}
