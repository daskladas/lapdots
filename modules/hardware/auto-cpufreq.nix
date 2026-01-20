{ pkgs, ... }:
{
  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        turbo = "auto";
        # scaling_max_freq ENTFERNT - das war das Problem für mögliche Lags!
        # Mit amd_pstate regelt energy_performance_preference das besser:
        energy_performance_preference = "balance_power";
      };
    };
  };

  # AMD pstate driver (effizienter für deinen Ryzen)
  boot.kernelParams = [ "amd_pstate=active" ];

  services.power-profiles-daemon.enable = false;
}
