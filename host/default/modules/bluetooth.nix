{ pkgs, pkgs-stable, lib, ... }: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  services.pipewire.wireplumber.enable = true;
  # services.pipewire.wireplumber.configPackages = [
  #   (
  #     pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
  #       bluez_monitor.properties = { ["bluez5.enable-sbc-xq"] = true, ["bluez5.enable-msbc"] = true, ["bluez5.enable-hw-volume"] = true, ["bluez5.codecs"] = "[ sbc sbc_xq aac ldac ]", ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]", ["bluez5.a2dp.ldac.quality"] = "hq" }
  #     ''
  #   )
  # ];
}
