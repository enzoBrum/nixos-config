{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Enzo Brum";
    userEmail = "darosabrumenzo@gmail.com";

    signing.key = "136DBE7C3E2E3980";
    signing.signByDefault = true;
  };
}
