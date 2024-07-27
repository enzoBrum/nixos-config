{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Enzo Brum";
    userEmail = "darosabrumenzo@gmail.com";

    signing.key = "439D83864D6696DE";
    signing.signByDefault = true;
  };
}
