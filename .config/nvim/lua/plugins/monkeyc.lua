-- monkeyc LSP configuration based on:
-- https://github.com/cyberang3l/garmin-monkey-c-neovim-language-server

return {
  "neovim/nvim-lspconfig",
  init = function()
    local configs = require("lspconfig.configs")
    local lspconfig = require("lspconfig")

    local function get_monkeyc_language_server_path()
      local current_sdk_cfg_path = "~/.Garmin/ConnectIQ/current-sdk.cfg"
      if vim.g.monkeyc_current_sdk_cfg_path then
        current_sdk_cfg_path = vim.g.monkeyc_current_sdk_cfg_path
      elseif vim.loop.os_uname().sysname == "Darwin" then
        current_sdk_cfg_path = "~/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg"
      end

      local workspace_dir = table.concat(vim.fn.readfile(vim.fn.expand(current_sdk_cfg_path)), "\n")
      local jar_path = workspace_dir .. "/bin/LanguageServer.jar"

      if vim.fn.filereadable(jar_path) == 1 then
        return jar_path
      end
      return nil
    end

    local monkeyc_ls_jar = get_monkeyc_language_server_path()
    if monkeyc_ls_jar then
      local monkeycLspCapabilities = vim.lsp.protocol.make_client_capabilities()
      monkeycLspCapabilities.textDocument.declaration = { dynamicRegistration = true }
      monkeycLspCapabilities.textDocument.implementation = { dynamicRegistration = true }
      monkeycLspCapabilities.textDocument.typeDefinition = { dynamicRegistration = true }
      monkeycLspCapabilities.textDocument.documentHighlight = { dynamicRegistration = true }
      monkeycLspCapabilities.textDocument.hover = { dynamicRegistration = true }
      monkeycLspCapabilities.textDocument.signatureHelp = { contextSupport = true, dynamicRegistration = true }
      monkeycLspCapabilities.workspace = { didChangeWorkspaceFolders = { dynamicRegistration = true } }
      monkeycLspCapabilities.textDocument.foldingRange = { lineFoldingOnly = true, dynamicRegistration = true }

      if not configs.monkeyc_ls then
        local jungleFiles = vim.g.monkeyc_jungle_files or "monkey.jungle"
        local root = lspconfig.util.root_pattern("monkey.jungle", "manifest.xml")
        local developerKeyPath = vim.fn.expand(vim.g.monkeyc_connect_iq_dev_key_path or "~/.Garmin/connect_iq_dev_key.der")
        
        configs.monkeyc_ls = {
          default_config = {
            cmd = {
              "java",
              "-Dapple.awt.UIElement=true",
              "-classpath",
              monkeyc_ls_jar,
              "com.garmin.monkeybrains.languageserver.LSLauncher",
            },
            filetypes = { "monkeyc", "monkey-c", "jungle", "mss" },
            root_dir = root,
            settings = {
              developerKeyPath = developerKeyPath,
              compilerWarnings = true,
              compilerOptions = vim.g.monkeyc_compiler_options or "",
              developerId = "",
              jungleFiles = jungleFiles,
              javaPath = "",
              typeCheckLevel = "Default",
              optimizationLevel = "Default",
              testDevices = {
                vim.g.monkeyc_default_device or "enduro3",
              },
              debugLogLevel = "Default",
            },
            capabilities = monkeycLspCapabilities,
            on_new_config = function(new_config, new_root_dir)
              new_config.init_options = {
                publishWarnings = vim.g.monkeyc_publish_warnings or true,
                compilerOptions = vim.g.monkeyc_compiler_options or "",
                typeCheckMsgDisplayed = false,
                workspaceSettings = {
                  {
                    path = new_root_dir,
                    jungleFiles = {
                      new_root_dir .. "/monkey.jungle",
                    },
                  },
                },
              }
            end,
            on_attach = function(client, bufnr)
              client.server_capabilities.completionProvider = {
                triggerCharacters = { ".", ":" },
                resolveProvider = false,
                documentSelector = {
                  { pattern = "**/*.{mc,mcgen}" },
                },
              }
            end,
          },
        }
      end

      lspconfig.monkeyc_ls.setup({})
    end
  end,
}
