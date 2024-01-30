{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Enzo Brum";
    userEmail = "darosabrumenzo@gmail.com";

    signing.key = "F26B8684F1D0DD11";
  };
}
