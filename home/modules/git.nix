{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Enzo Brum";
    userEmail = "darosabrumenzo@gmail.com";

    signing.key = config.custom.gitKey;
    signing.signByDefault = true;

    extraConfig = {
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = "true";
        renames = "true";
      };
      push = {
        default = "simple";
        autoSetupRemote = "true";
        followTags = "true";
      };
      fetch = {
        prune = "true";
        pruneTags = "true";
        all = "true";
      };
      help.autocorrect = "prompt";
      commit.verbose = "true";
      rerere = {
        enabled = "true";
        autoupdate = "true";
      };
      core.excludefile = "~/.gitignore";
      rebase = {
        autoSquash = "true";
        autoStash = "true";
        updateRefs = "true";
      };
    };
  };
}
