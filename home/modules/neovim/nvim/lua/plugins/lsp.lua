return {
  {
    "mfussenegger/nvim-jdtls"
  },
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      --vim.api.nvim_create_autocmd("InsertEnter", {
      --  pattern = "*",
      --  callback = function()
      --    vim.lsp.inlay_hint.enable(false)
      --  end,
      --})

      vim.diagnostic.config({ virtual_lines = true })
      vim.diagnostic.config({ virtual_text = true })
      -- Trigger on leaving insert mode
      vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        callback = function()
          vim.lsp.inlay_hint.enable(true)
        end,
      })
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

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
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true)
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })


      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

      -- For docker-compose files
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "docker-compose*.yml",
        callback = function()
          vim.bo.filetype = "yaml.docker-compose"
        end
      })

      -- For jinja files
      --vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      --  pattern = {"**/templates/**/*.html", "**/templates/*.html"},
      --  callback = function()
      --    vim.bo.filetype = "jinja"
      --  end
      --})
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.name == "basedpyright" then
            local settings = client.config.settings and client.config.settings or { basedpyright = { analysis = {} } }
            local root_dir = client.root_dir
            if root_dir == nil or string.find(root_dir, "iekuatiara") == nil then
              settings.basedpyright.analysis.extraPaths = {}
              client.notify("workspace/didChangeConfiguration", settings)
              return
            end

            settings.basedpyright.analysis.extraPaths = {
              "./misc/python-common",
              "./base/front-end",
              "./base/document-verifier",
              "./base/immutable-storage-registry",
              "./misc/python-oid",
            }
            client.notify("workspace/didChangeConfiguration", settings)
          end
        end
      })

      local util = require 'lspconfig.util'
      require("lspconfig").basedpyright.setup({
        root_dir = function(fname)
          local path = util.root_pattern("pyproject.toml", "setup.py", "requirementx.txt", ".git")(fname)
          if path == nil then
            return path
          end
          local idx = string.find(path, "iekuatiara")
          if idx then
            path = string.sub(path, 1, idx + string.len("iekuatiara") - 1)
          end
          return path
        end,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "off",
            }
          }
        }
      })
      require("lspconfig").clangd.setup({})
      require("lspconfig").dockerls.setup({})
      require("lspconfig").docker_compose_language_service.setup({})
      require("lspconfig").html.setup({})
      require("lspconfig").jsonls.setup({})
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").ts_server.setup({})
      require("lspconfig").jdtls.setup({})
    end
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    cond = not vim.g.vscode,
    keys = {
      {
        '<leader>fb',
        function()
          require('conform').format { async = false, lsp_fallback = true }
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
        return {
          timeout_ms = 2000,
        }
      end,
      formatters_by_ft = {
        -- Conform can also run multiple formatters sequentially
        python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    cond = not vim.g.vscode,
    dependencies = {
      ---- Snippet Engine & its associated nvim-cmp source
      --{
      --  'L3MON4D3/LuaSnip',
      --  build = (function()
      --    -- Build Step is needed for regex support in snippets.
      --    -- This step is not supported in many windows environments.
      --    -- Remove the below condition to re-enable on windows.
      --    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      --      return
      --    end
      --    return 'make install_jsregexp'
      --  end)(),
      --  dependencies = {
      --    -- `friendly-snippets` contains a variety of premade snippets.
      --    --    See the README about individual language/framework/plugin snippets:
      --    --    https://github.com/rafamadriz/friendly-snippets
      --    -- {
      --    --   'rafamadriz/friendly-snippets',
      --    --   config = function()
      --    --     require('luasnip.loaders.from_vscode').lazy_load()
      --    --   end,
      --    -- },
      --  },
      --},
      --'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      --local luasnip = require 'luasnip'
      --luasnip.config.setup {}
      cmp.setup {
        --snippet = {
        --  expand = function(args)
        --    luasnip.lsp_expand(args.body)
        --  end,
        --},
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          --['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          --['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-2),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          --['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          --['<C-l>'] = cmp.mapping(function()
          --  if luasnip.expand_or_locally_jumpable() then
          --    luasnip.expand_or_jump()
          --  end
          --end, { 'i', 's' }),
          --['<C-h>'] = cmp.mapping(function()
          --  if luasnip.locally_jumpable(-1) then
          --    luasnip.jump(-1)
          --  end
          --end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = "nvim_lsp_signature_help" }
          --{ name = 'luasnip' },
          --{ name = 'path' },
        },
      }
      --vim.api.nvim_create_autocmd('FileType', {
      --    pattern = 'cmp_docs',
      --    callback = function()
      --        vim.treesitter.start(0, 'markdown')
      --    end,
      --})
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    cond = false,
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        routes = {
          {
            view = "notify",
            filter = { event = "msg_showmode" },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
          signature = {
            enabled = false
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
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
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
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
  --{
  --  "ray-x/lsp_signature.nvim",
  --  event = "VeryLazy",
  --  opts = {},
  --  config = function()
  --    require "lsp_signature".setup()
  --    vim.api.nvim_create_autocmd("LspAttach", {
  --      callback = function(args)
  --        local bufnr = args.buf
  --        local client = vim.lsp.get_client_by_id(args.data.client_id)
  --        if client == nil or vim.tbl_contains({ 'null-ls' }, client.name) then -- blacklist lsp
  --          return
  --        end
  --        require("lsp_signature").on_attach({
  --          -- ... setup options here ...
  --        }, bufnr)
  --      end,
  --    })
  --  end
  --}
}
