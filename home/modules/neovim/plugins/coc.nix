{ lib, config, pkgs, ... }:
let
  helpers = import ./helpers.nix;
  flake8-pyproject = pkgs.python312Packages.buildPythonPackage rec {
    pname = "flake8_pyproject";
    version = "1.2.3";
    format = "wheel";

    # src = pkgs.fetchPypi {
    #   inherit pname version format;
    #
    #   sha256 = "sha256-Ykn+U1RSBa9edoN2RNyAtMEAN+c6Dl24f/Vi11+1vUo=";
    #   python = "py3";
    #   platform = "any";
    #   dist = "py3";
    # };

    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/5f/1d/635e86f9f3a96b7ea9e9f19b5efe17a987e765c39ca496e4a893bb999112/flake8_pyproject-1.2.3-py3-none-any.whl";
      sha256 = "sha256-Ykn+U1RSBa9edoN2RNyAtMEAN+c6Dl24f/Vi11+1vUo=";
    };

    propagatedBuildInputs = [ ];

    pythonImportsCheck = [ ];

    meta = with lib; {
      description = "Flake8 plug-in loading the configuration from pyproject.toml";
      homepage = "https://github.com/john-hen/Flake8-pyproject";
      license = lib.licenses.mit;
    };
  };
in
{
  programs.neovim = {
    withPython3 = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      (helpers.notUsedByVSCode {
        pkg = coc-pyright;
        name = "coc-pyright";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-clangd;
        name = "coc-clangd";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-docker;
        name = "coc-docker";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-java;
        name = "coc-java";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-sumneko-lua;
        name = "coc-sumneko-lua";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-yaml;
        name = "coc-yaml";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-json;
        name = "coc-json";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-sqlfluff;
        name = "coc-sqlfluff";
      })
      (helpers.notUsedByVSCode {
        pkg = coc-nvim;
        name = "coc.nvim";
        extraConfig = /* lua */
          ''
            vim.cmd([[autocmd BufWritePre *.py silent! :call CocAction('runCommand', 'python.sortImports')]])

            function _G.check_back_space()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
            end
            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

            vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
            vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)


            -- Use <c-j> to trigger snippets
            vim.keymap.set("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
            -- Use <c-space> to trigger completion
            vim.keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})


            -- Use `[g` and `]g` to navigate diagnostics
            -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
            vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
            vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

            -- GoTo code navigation
            vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
            vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
            vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
            vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

            -- Use K to show documentation in preview window
            function _G.show_docs()
                local cw = vim.fn.expand('<cword>')
                if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command('h ' .. cw)
                elseif vim.api.nvim_eval('coc#rpc#ready()') then
                    vim.fn.CocActionAsync('doHover')
                else
                    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
                end
            end
            vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


            -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
            vim.api.nvim_create_augroup("CocGroup", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                command = "silent call CocActionAsync('highlight')",
                desc = "Highlight symbol under cursor on CursorHold"
            })


            -- Symbol renaming
            vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


            -- Formatting selected code
            vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
            vim.keymap.set("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


            -- Setup formatexpr specified filetype(s)
            vim.api.nvim_create_autocmd("FileType", {
                group = "CocGroup",
                pattern = "typescript,json",
                command = "setl formatexpr=CocAction('formatSelected')",
                desc = "Setup formatexpr specified filetype(s)."
            })

            -- Update signature help on jump placeholder
            vim.api.nvim_create_autocmd("User", {
                group = "CocGroup",
                pattern = "CocJumpPlaceholder",
                command = "call CocActionAsync('showSignatureHelp')",
                desc = "Update signature help on jump placeholder"
            })

            -- Remap <C-f> and <C-b> to scroll float windows/popups
            ---@diagnostic disable-next-line: redefined-local
            local opts = {silent = true, nowait = true, expr = true}
            vim.keymap.set("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
            vim.keymap.set("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
            vim.keymap.set("i", "<C-f>",
                   'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
            vim.keymap.set("i", "<C-b>",
                   'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
            vim.keymap.set("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
            vim.keymap.set("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

            -- Use CTRL-S for selections ranges
            -- Requires 'textDocument/selectionRange' support of language server
            vim.keymap.set("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
            vim.keymap.set("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

            -- Add `:Format` command to format current buffer
            vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

            -- " Add `:Fold` command to fold current buffer
            vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

            -- Add `:OR` command for organize imports of the current buffer
            vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

            -- Add (Neo)Vim's native statusline support
            -- NOTE: Please see `:h coc-status` for integrations with external plugins that
            -- provide custom statusline: lightline.vim, vim-airline
            vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function',\"\")}")

          '';
      })
    ];

    extraPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [ black flake8 pylint isort ]))
      jdk21
      nil
      nixpkgs-fmt
      clang-tools
      flake8-pyproject
    ];
  };

  xdg.configFile."nvim/coc-settings.json".text = /* json */
    ''
      {
        "python.formatting.provider": "black",
        "coc.preferences.formatOnSave": true,
        "python.pythonPath": "nvim-python3",
        "java.jdt.ls.java.home": "${pkgs.jdk21}/lib/openjdk",
        "diagnostic.virtualTextCurrentLineOnly": false,
        "diagnostic.virtualText": true,
        "workspace.rootPatterns": [
          ".git",
        ],
        "workspace.ignoredFolders": ["**/iekuatiara/**/*", "**/labsec"],
        "languageserver": {
          "nix": {
            "command": "nil",
            "filetypes": ["nix"],
            "rootPatterns": ["flake.nix"],
            "settings": {
              "nil": {
                "formatting": { "command": ["nixpkgs-fmt"] }
              }
            }
          }
        }  
      }
    '';
}
