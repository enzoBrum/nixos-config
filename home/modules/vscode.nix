{ vscode-extensions, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ python312 gcc clang-tools neovim zlib openssl.dev pkg-config ]);

    # extensions = with vscode-extensions.vscode-marketplace; [
    #   arrterian.nix-env-selector
    #   asvetliakov.vscode-neovim
    #   catppuccin.catppuccin-vsc
    #   catppuccin.catppuccin-vsc-icons
    #   gitlab.gitlab-workflow
    #   jnoortheen.nix-ide
    #   llvm-vs-code-extensions.vscode-clangd
    #   ms-azuretools.vscode-docker
    #   ms-python.black-formatter
    #   ms-python.flake8
    #   ms-python.isort
    #   ms-python.debugpy
    #   ms-python.pylint
    #   ms-python.python
    #   ms-python.vscode-pylance
    #   ms-vscode.cpptools
    #   ms-vscode.cpptools-extension-pack
    #   ms-vscode.cpptools-themes
    #   ms-vsliveshare.vsliveshare
    #   redhat.java
    #   redhat.vscode-yaml
    #   twxs.cmake
    #   visualstudioexptteam.intellicode-api-usage-examples
    #   visualstudioexptteam.vscodeintellicode
    #   vscjava.vscode-java-debug
    #   vscjava.vscode-java-dependency
    #   vscjava.vscode-java-pack
    #   vscjava.vscode-java-test
    #   vscjava.vscode-maven
    #   yzhang.markdown-all-in-one
    # ];
    # userSettings = {
    #   "gitlab.ignoreCertificateErrors" = true;
    #   "redhat.telemetry.enabled" = false;
    #   "workbench.colorTheme" = "Catppuccin Macchiato";
    #   "editor.lineNumbers" = "relative";
    #   "terminal.integrated.enableMultiLinePasteWarning" = false;
    #   "editor.minimap.enabled" = false;
    #   "security.workspace.trust.untrustedFiles" = "open";
    #   "git.autofetch" = true;
    #   "C_Cpp.default.cppStandard" = "c++20";
    #   "cph.general.defaultLanguage" = "cpp";
    #   "cph.language.cpp.Args" = "-std=c++17 -O2 -g";
    #   "explorer.confirmDelete" = false;
    #   "terminal.integrated.fontFamily" = "MesloLGS NF";
    #   "extensions.experimental.affinity" = {
    #     "asvetliakov.vscode-neovim" = 1;
    #   };
    #   "window.titleBarStyle" = "custom";
    #   "files.watcherExclude" = {
    #     "**/.bloop" = true;
    #     "**/.metals" = true;
    #     "**/.ammonite" = true;
    #   };
    #   "C_Cpp.intelliSenseEngine" = "disabled";
    #   "git.openRepositoryInParentFolders" = "always";
    #   "clangd.arguments" = [
    #     "-pretty"
    #     "--compile-commands-dir=."
    #   ];
    #   "workbench.iconTheme" = "catppuccin-macchiato";
    #   "python.analysis.indexing" = true;
    #   "python.analysis.autoImportCompletions" = true;
    #   "java.jdt.ls.java.home" = "${pkgs.jdk21}/lib/openjdk";
    # };
    #
    # keybindings = [
    #   {
    #     key = "alt+\\";
    #     command = "workbench.action.terminal.openNativeConsole";
    #   }
    #   {
    #     key = "ctrl+shift+c";
    #     command = "-workbench.action.terminal.openNativeConsole";
    #     when = "!terminalFocus";
    #   }
    #   {
    #     key = "ctrl+;";
    #     command = "editor.action.commentLine";
    #     when = "editorTextFocus && !editorReadonly";
    #   }
    #   {
    #     key = "ctrl+/";
    #     command = "-editor.action.commentLine";
    #     when = "editorTextFocus && !editorReadonly";
    #   }
    #   {
    #     key = "ctrl+'";
    #     command = "workbench.action.terminal.focus";
    #   }
    #   {
    #     key = "ctrl+'";
    #     command = "workbench.action.focusActiveEditorGroup";
    #     when = "terminalFocus";
    #   }
    # ];
    #
  };
}
