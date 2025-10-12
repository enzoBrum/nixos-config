if not vim.g.vscode then
  local home = vim.fn.expand("$HOME") -- or os.getenv("HOME")
  local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
  local workspace = home .. "/.cache/jdtls_dir"
  vim.fn.mkdir(workspace, "p")
  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

      -- 💀
      'java', -- or '/path/to/java21_or_newer/bin/java'
      -- depends on if `java` is in your $PATH env variable and if it points to the right version.

      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-javaagent:' .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",

      -- 💀
      '-jar',
      jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
      -- Must point to the                                                     Change this to
      -- eclipse.jdt.ls installation                                           the actual version


      -- 💀
      '-configuration', jdtls_path .. '/config_linux',
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
      -- Must point to the                      Change to one of `linux`, `win` or `mac`
      -- eclipse.jdt.ls installation            Depending on your system.


      -- 💀
      -- See `data directory configuration` section in the README
      '-data', workspace
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    --
    -- vim.fs.root requires Neovim 0.10.
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          --updateBuildConfiguration = "interactive",
          runtimes = {
            {
              name = "JavaSE-21",
              path = os.getenv("JAVA_HOME")
            }
          },
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = "all",
          },
        },

        format = {
          enabled = true,
          settings = {
            url = "/home/erb/containers/labsec/iekuatiara/.vscode/java-formatter.xml",
            --profile = "JavaConventions", -- profile name inside XML
          },
        },
      },
    },
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      bundles = {}
    },
  }
  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  --function printTable(t, indent)
  --  indent = indent or 0
  --  for k, v in pairs(t) do
  --    local formatting = string.rep("  ", indent) .. tostring(k) .. ": "
  --    if type(v) == "table" then
  --      print(formatting)
  --      printTable(v, indent + 1)
  --    else
  --      print(formatting .. tostring(v))
  --    end
  --  end
  --end
  --
  --printTable(config)
  require('jdtls').start_or_attach(config)
end
