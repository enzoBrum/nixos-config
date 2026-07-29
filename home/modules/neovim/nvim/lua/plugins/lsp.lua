if vim.g.vscode then
  return {}
else
  return {
    {
      "mfussenegger/nvim-jdtls",
      cond = not vim.g.vscode,
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        { "williamboman/mason.nvim",                  config = true },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

        { 'j-hui/fidget.nvim',                        opts = {} },
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {},
        },
        { "Bilal2453/luvit-meta", lazy = true },

      },
      config = function()
        vim.diagnostic.config({ update_in_insert = true, virtual_lines = true, virtual_text = true, underline = true })

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
          callback = function(event)
            local map = function(keys, func, desc)
              vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-t>.
            map('<leader>rr', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

            -- Find references for the word under your cursor.
            map('gj', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

            -- Fuzzy find all the symbols in your current workspace.
            --  Similar to document symbols, except searches over your entire project.
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- Rename the variable under your cursor.
            --  Most Language Servers support renaming across files, etc.
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            -- Opens a popup that displays documentation about the word under your cursor
            --  See `:help K` for why this keymap.
            map('K', function()
              vim.lsp.buf.hover({ border = "rounded" })
            end, 'Hover Documentation')

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header.
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            map('gd', vim.lsp.buf.definition, '[G]oto [d]efinition')

            local client = vim.lsp.get_client_by_id(event.data.client_id)

            if client and client.name == "pyrefly" then
              vim.defer_fn(function()
                vim.lsp.inlay_hint.enable(true)
              end, 100)
            end

            -- The following autocommand is used to enable inlay hints in your
            -- code, if the language server you are using supports them
            --
            -- This may be unwanted, since they displace some of your code
            if client and client:supports_method('textDocument/inlayHint') and vim.lsp.inlay_hint then
              vim.lsp.inlay_hint.enable(true)
              map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              end, '[T]oggle Inlay [H]ints')
            end
          end,
        })

        -- For docker-compose files
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
          pattern = "docker-compose*.yml",
          callback = function()
            vim.bo.filetype = "yaml.docker-compose"
          end
        })

        -- basedpyright: dynamically inject extraPaths based on the -iek workspace layout
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client ~= nil and client.name == "basedpyright" then
              local settings = client.settings and client.settings or { basedpyright = { analysis = {} } }
              local root_dir = client.root_dir
              if root_dir == nil then
                return
              end

              local path = vim.api.nvim_buf_get_name(0)
              local idx = string.find(path, "-iek")
              local idxx = string.find(path, "iekuatiara")
              if idx then
                local idx2 = string.find(path, "/", idx)
                if idx2 then
                  idx = idx2
                end
                path = string.sub(path, 1, idx)
              elseif idxx ~= nil then
                if string.find(path, "/", idxx) then
                  idxx = string.find(path, "/", idxx)
                end
                path = string.sub(path, 1, idxx)
              else
                return
              end


              settings.basedpyright.analysis.extraPaths = {
                path .. "base/document-signer/libs/document-signer",
                path .. "base/pki/libs/pki",
                path .. "base/reverse-proxy-api/libs/reverse-proxy-api",
                path .. "base/immutable-storage-registry/libs/immutable-storage-registry",
                path .. "base/document-manager/libs/document-manager",
                path .. "base/document-verifier/libs/document-verifier",
                path .. "libs/python-common",
              }
              client:notify("workspace/didChangeConfiguration", { settings = settings })
            end
          end
        })

        -- Global defaults applied to every server via the "*" pseudo-config.
        -- capabilities and handlers only need to be declared once here.
        vim.lsp.config('*', {
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        -- Per-server configuration. Under the new API each key becomes a
        -- vim.lsp.config(name, {...}) call and is started with vim.lsp.enable(name).
        local servers = {
          clangd = {},
          jdtls = { autoattach = false },
          texlab = {},
          basedpyright = {
            root_markers = { "app/", "pyproject.toml", "requirements.txt", "requirements.in", ".git" },
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "off",
                }
              }
            }
          },
          dockerls = {},
          docker_compose_language_service = {},
          html = { filetypes = { "html", "css", "javascript", "htmldjango" } },
          jsonls = {},
          lua_ls = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
        }

        -- Mason just installs the binaries now; it no longer wires up setup().
        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua', -- Used to format Lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        for server, config in pairs(servers) do
          vim.lsp.config(server, config)
          vim.lsp.enable(server)
        end
      end
    },
    { -- Autoformat
      'stevearc/conform.nvim',
      lazy = false,
      keys = {
        {
          '<leader>fb',
          function()
            require('conform').format { async = false, lsp_fallback = true, timeout = 2000, timeout_ms = 2000 }
          end,
          mode = '',
          desc = '[F]ormat [b]uffer',
        },
      },
      opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true, lua = true, xml = true }
          return {
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end,
        formatters_by_ft = {
          -- Conform can also run multiple formatters sequentially
          python = { "isort", "black" },
          xml = { "xmllint" },
        },
      },
    },
    { -- Autocompletion
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        'hrsh7th/cmp-path',
      },
      config = function()
        -- See `:help cmp`
        local cmp = require 'cmp'
        cmp.setup {
          completion = { completeopt = 'menu,menuone,noinsert' },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-2),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping.confirm { select = true },
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<C-Space>'] = cmp.mapping.complete {},
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = "lazydev" },
            { name = 'path' },
          },
        }
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'cmp_docs',
          callback = function()
            vim.treesitter.start(0, 'markdown')
          end,
        })
      end,
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      enabled = true,
      opts = {},
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = function()
        require("noice").setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            signature = {
              enabled = true,
            },
          },
          presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,        -- add a border to hover docs and signature help
          },
        })
        require("notify").setup({
          background_colour = "#000000"
        })
      end
    },
    {
      "mfussenegger/nvim-lint",
      event = "VeryLazy",
      config = function()
        require('lint').linters_by_ft = {
          python = { 'pylint', 'flake8' }
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          callback = function()
            require("lint").try_lint()
          end,
        })
        require('lint').linters.flake8.args = {
          '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
          '--no-show-source',
          '--max-line-length',
          '140',
          '--stdin-display-name',
          function() return vim.api.nvim_buf_get_name(0) end,
          '-',
        }
      end
    },
  }
end
