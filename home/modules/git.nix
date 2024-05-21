{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Enzo Brum";
    userEmail = "darosabrumenzo@gmail.com";

    signing.key = "BA80BD27C7ADC955";
    signing.signByDefault = true;
  };
}
