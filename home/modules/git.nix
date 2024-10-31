{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Enzo Brum";
    userEmail = "darosabrumenzo@gmail.com";

    signing.key = "7FBB0AB79B22FE13";
    signing.signByDefault = true;
  };
}
