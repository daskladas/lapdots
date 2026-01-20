{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
      };
      Policy = {
        AutoEnable = false;
      };
    };
  };
}
