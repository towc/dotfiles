-- init.lua

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- util {{{
local function str_to_list(str)
  local res = {}
  for i = 1, #str do
    res[i] = str:sub(i, i)
  end
  return res
end

local function on_filetype(ft, cb)
  vim.api.nvim_create_autocmd('FileType', { pattern = ft, callback = cb })
end

local function keymap(modes, ...)
  vim.keymap.set(str_to_list(modes), ...)
end

vim.filetype.add {
  extension = {
    mdx = 'markdown',
    mc = 'monkeyc',
  },
}
--- }}}

-- vim options {{{
vim.o.number = true
vim.o.mouse = 'a' -- enable mouse support
vim.o.showmode = false -- already in statusline
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.foldmethod = 'marker'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- preview substitutions
vim.o.cursorline = true
-- }}} vim options

-- key mappings {{{

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- window/tmux navigation {{{
keymap('niv', '<C-h>', '<esc><C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('niv', '<C-l>', '<esc><C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('niv', '<C-j>', '<esc><C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('niv', '<C-k>', '<esc><C-w><C-k>', { desc = 'Move focus to the upper window' })
-- }}}
keymap('niv', '<C-q>', '<cmd>q<enter>', { desc = 'quit window' })
keymap('niv', '<C-S-q>', '<cmd>qa<enter>', { desc = 'quit all windows' })
keymap('niv', '<C-s>', '<cmd>w<enter><esc>', { desc = 'save buffer and enter normal mode' })
keymap('niv', '<C-t>', '<cmd>tabe %<enter>', { desc = 'open buffer in new tab' }) 
keymap('nv', '<Down>', '<C-e>')
keymap('nv', '<Up>', '<C-y>')
-- sessions (c-p) {{{
keymap('n', '<C-p>', function()
  require('persistence').load()
end, { desc = 'load last session in directory' })
keymap('n', '<C-p><C-p>', function()
  require('persistence').select()
end, { desc = 'select session to load' })
-- }}}
-- config (\c) {{{
keymap('n', '<leader>cc', '<cmd>tabe $MYVIMRC<enter>', { desc = 'open (change) config' })
-- keymap('n', '<leader>cs', '<cmd>source $MYVIMRC<enter>', { desc = 'source config' })
-- }}}
-- runners {{{
on_filetype('javascript', function()
  keymap('nv', '<leader>rr', '<cmd>!node %<cr>')
end)

-- }}}
-- git {{{
keymap('n', '<leader>gg', '<cmd>G<enter>')
keymap('n', '<leader>gp', '<cmd>G push<enter>')
-- }}}
-- writing {{{
keymap('nv', '<leader>wm', '<cmd>ZenMode<cr>', { desc = 'write mode (zen toggle)' })
-- }}}
-- insert (\i) {{{
keymap('n', '<leader>id', "<cmd>pu=strftime('%c')<enter>", { desc = 'insert date' })

-- }}}
-- obsidian (\o) {{{
-- will be overridden once in obsidian project
keymap('nv', '<leader>oo', ':cd /home/user/Documents/obsidian-private/main<cr>:e main.md<cr>', { desc = "open obsidian" })
-- }}}
-- run (\r) {{{
keymap('n', '<leader>rr', '<cmd>!perl %<enter>', { desc = 'run current file' });
-- }}}

-- }}} key mappings

-- misc behaviours {{{
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
-- }}}

-- plugins {{{
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  {
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
    config = function()
      require('guess-indent').setup {}
    end,
  },

  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-fugitive' },

  {
    'nheiich/monkeyc-for-vim',
    ft = 'monkeyc', -- lazy load only for MonkeyC files
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 500,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {},
    },
  },
  { 
    'junegunn/fzf.vim',
    dependencies = {
      'junegunn/fzf' 
    },
    config = function()
      vim.keymap.set('n', '<leader><leader>', '<cmd>Ag<cr>', { desc = 'search contents' })
    end
  },
  -- not fuzzy by default, and c-g gets fans going
  -- {
  --   "ibhagwan/fzf-lua",
  --   -- optional for icon support
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   -- or if using mini.icons/mini.nvim
  --   -- dependencies = { "echasnovski/mini.icons" },
  --   opts = {},

  --   config = function()
  --     require'fzf-lua'.setup({
  --       'fzf-native',
  --     })
  --   end
  -- },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {
            fuzzy = true
          }
        },

        defaults = {
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'fzf_writer')
      pcall(require('telescope').load_extension, 'ui-select')

      local defaulted = function(f)
        return function()
          f({
            hidden = true,
            no_ignore = true,
            file_ignore_patterns = {
              'node_modules',
              '.next',
              '.git',
            },
          })
        end
      end

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader><leader>h', defaulted(builtin.help_tags), { desc = '[/]earch [H]elp' })
      vim.keymap.set('n', '<leader><leader>k', defaulted(builtin.keymaps), { desc = '[/]earch [K]eymaps' })
      vim.keymap.set('n', '<leader><leader>f', defaulted(builtin.find_files), { desc = '[/]earch [F]iles' })
      vim.keymap.set('n', '<leader><leader>s', defaulted(builtin.builtin), { desc = '[/]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader><leader>w', defaulted(builtin.grep_string), { desc = '[/]earch current [W]ord' })
      vim.keymap.set('n', '<leader><leader>g', defaulted(builtin.live_grep), { desc = '[/]earch by [G]rep' })
      vim.keymap.set('n', '<leader><leader>d', defaulted(builtin.diagnostics), { desc = '[/]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader><leader>r', defaulted(builtin.resume), { desc = '[/]earch [R]esume' })
      vim.keymap.set('n', '<leader><leader>.', defaulted(builtin.oldfiles), { desc = '[/]earch Recent Files ("." for repeat)' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      -- Snippets
      -- 'L3MON4D3/LuaSnip',
      -- 'saadparwaiz1/cmp_luasnip',

      -- -- Snippet collection (optional)
      -- 'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require 'cmp'
      -- local luasnip = require 'luasnip'

      -- require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        --snippet = {
        --  expand = function(args)
        --    luasnip.lsp_expand(args.body)
        --  end,
        --},
        mapping = cmp.mapping.preset.insert {
          --['<Tab>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          -- { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      }

      -- Optional: cmdline completion
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'yioneko/nvim-vtsls',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'hrsh7th/nvim-cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local root_dir = vim.fn.getcwd()

          -- local is_deno = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')(root_dir) ~= nil
          --
          -- -- In Deno project: stop tsserver
          -- if is_deno and client.name == 'ts_ls' then
          --   client.stop()
          -- end

          -- -- Not a Deno project: stop denols
          -- if not is_deno and client.name == 'denols' then
          --   client.stop()
          -- end

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.plugins
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                -- callSnippet = 'Replace',
              },
            },
          },
        },
        vtsls = {
          -- Use the default root pattern logic from lspconfig
          root_dir = require('lspconfig').util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
          },
        },
        --denols = {
        --  root_dir = require('lspconfig').util.root_pattern { 'deno.json', 'deno.jsonc' },
        --  single_file_support = false,
        --  settings = {},
        --},
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    -- event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = {
          c = true,
          cpp = true,
          javascript = true,
          typescript = true,
        }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      -- {
      --   'L3MON4D3/LuaSnip',
      --   version = '2.*',
      --   build = (function()
      --     -- Build Step is needed for regex support in snippets.
      --     -- This step is not supported in many windows environments.
      --     -- Remove the below condition to re-enable on windows.
      --     if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      --       return
      --     end
      --     return 'make install_jsregexp'
      --   end)(),
      --   dependencies = {
      --     -- `friendly-snippets` contains a variety of premade snippets.
      --     --    See the README about individual language/framework/plugin snippets:
      --     --    https://github.com/rafamadriz/friendly-snippets
      --     -- {
      --     --   'rafamadriz/friendly-snippets',
      --     --   config = function()
      --     --     require('luasnip.loaders.from_vscode').lazy_load()
      --     --   end,
      --     -- },
      --   },
      --   opts = {},
      -- },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      -- snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  {
    'askfiy/visual_studio_code',
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme visual_studio_code]]
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      --require('mini.starter').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  -- { -- Highlight, edit, and navigate code
  --   'nvim-treesitter/nvim-treesitter',
  --   build = ':TSUpdate',
  --   main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  --   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  --   opts = {
  --     ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
  --     -- Autoinstall languages that are not installed
  --     auto_install = true,
  --     highlight = {
  --       enable = true,
  --       -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
  --       --  If you are experiencing weird indenting issues, add the language to
  --       --  the list of additional_vim_regex_highlighting and disabled languages for indent.
  --       additional_vim_regex_highlighting = { 'ruby' },
  --     },
  --     indent = { enable = true, disable = { 'ruby' } },
  --   },
  --   -- There are additional nvim-treesitter modules that you can use to interact
  --   -- with nvim-treesitter. You should go explore a few and see what interests you:
  --   --
  --   --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --   --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --   --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- },

  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {},
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
      { '<leader>t', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- or would have to press H
        },
        window = {
          mappings = {
            ['<leader>t'] = 'close_window',
          },
        },
      },
    },
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
          linebreak = true,
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus' 
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+10", -- font size increment
        },
      },
    }
  },
  {
    'Ron89/thesaurus_query.vim',
    config = function()
      keymap('nv', '<leader>ws', '<cmd>ThesaurusQueryReplaceCurrentWord<cr>', { desc = 'write synonym (thesaurus)' })
      keymap('nv', '<leader>wS', '<c-u>:Thesaurus ', { desc = 'write synonym from scratch (thesaurus)' })
    end
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    --ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre /home/user/Documents/obsidian-private/**/*",
      "BufNewFile /home/user/Documents/obsidian-private/**/*",
    },
    config = function()
      vim.opt_local.conceallevel = 2
      require 'obsidian'.setup {
        --disable_frontmatter = true,
        workspaces = {
          {
            name = "main",
            path = "~/Documents/obsidian-private/main",
          },
        },
        templates = {
          folder = "templates"
        },

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
          local suffix = ""
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            --suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            suffix = title:gsub("[^A-Za-z0-9 -]", ""):lower()
          else
            -- If no title given
            suffix = suffix .. "tmp"
          end
          return os.date("%Y.%m.%d %H.%M.%S") .. " " .. suffix
        end,
        -- Optional, customize how note file names are generated given the ID, target directory, and title.
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
          local path = spec.dir / tostring(spec.id)
          --return path:with_suffix ".md"
          return tostring(path) .. '.md'
        end,

        frontmatter = {
          func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
              note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end

            return out
          end,
        },
        checkbox = {
          order = { " ", ">", "x" },
        },
        footer = { enabled = false },
        legacy_commands = false,
      }

      keymap('n', 'gf', function() return require("obsidian").util.gf_passthrough() end, { buffer = true });
      keymap('n', '<cr>', function() return require("obsidian").util.smart_action() end, { buffer = true });

      keymap('nv', '<leader>ob', '<cmd>Obsidian backlinks<cr>')
      keymap('nv', '<leader>on', '<cmd>Obsidian new<cr>')
      keymap('nv', '<leader>o#', '<cmd>Obsidian tags<cr>')
      keymap('nv', '<leader>oo', '<cmd>Obsidian open<cr>')
      keymap('nv', '<leader>oc', '<cmd>Obsidian toc<cr>')

      keymap('nv', '<leader>od', '<cmd>Obsidian dailies<cr>')
      keymap('nv', '<leader>oy', '<cmd>Obsidian yesterday<cr>')
      keymap('nv', '<leader>ot', '<cmd>Obsidian today<cr>')
      keymap('nv', '<leader>oT', '<cmd>Obsidian tomorrow<cr>')

      keymap('nv', '<leader>os', '<cmd>Obsidian search<cr>')

      keymap('n', '<leader>or', function ()
        local str_find_literal = function(str, x)
          -- last param is a plain text flag
          return string.find(str, x, 1, true)
        end
        local str_replace_range = function(str, i, j, s)
          return str:sub(1, i-1) .. s .. str:sub(j+1)
        end
        local str_replace_literal = function(str, a, b)
          local i, j = str_find_literal(str, a)
          if i then
            return str_replace_range(str, i, j, b)
          else
            return str
          end
        end

        local path = vim.fn.expand('%:h') -- path without filename
        local extension = vim.fn.expand('%:e')

        local cur_id = vim.fn.expand('%:t:r') -- file name w/o ext, friendlier for input
        local cur_full_path = vim.fn.expand('%:p')

        local new_id = vim.fn.input('Rename to: ', cur_id)
        local new_full_path = path .. '/' .. new_id .. '.' .. extension

        -- could use require 'obsidian.frontmatter',
        -- but the trivial search/replace solution in current file is good enough for me.
        -- If you don't use an alias, you can skip this step:
        local text = vim.fn.readblob(cur_full_path)

        -- - assume filename was id, so update id
        text = str_replace_literal(text, cur_id, new_id)

        -- - assume alias was id with name only, so:
        --   - cur_id - cur_alias = base_id ('ID old' - 'old' = 'ID ')
        --   - new_id - base_id = new_alias ('ID new' - 'ID ' = 'new')
        --   - set new_alias in frontmatter

        local has_alias, alias_start = string.find(text, 'aliases:%s+-%s?')
        if has_alias > 0 then
          local cur_alias = string.match(text, '[^\n]+', alias_start + 1)
          local base_id = str_replace_literal(cur_id, cur_alias, '')
          local new_alias = str_replace_literal(new_id, base_id, '')

          text = str_replace_range(text, alias_start+1, alias_start + #cur_alias, new_alias)
        end

        -- TODO: look for link references to new_name, and rename them?
        -- not my most common usecase, often I just want to not have to worry about changing frontmatter myself

        os.rename(cur_full_path, new_full_path)

        vim.api.nvim_command('edit ' .. vim.fn.fnameescape(new_full_path))
        vim.api.nvim_command('bwipeout #')

        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(text, "\n"))
        vim.api.nvim_buf_set_name(0, new_full_path)
        vim.api.nvim_command('write!')
      end, { desc = 'Obsidian Rename' })
    end
  },
  -- { 'wakatime/vim-wakatime', lazy = false },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = "telescope",
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      {
        "<leader>gi",
        "<CMD>Octo issue list<CR>",
        desc = "List GitHub Issues",
      },
      {
        "<leader>gp",
        "<CMD>Octo pr list<CR>",
        desc = "List GitHub PullRequests",
      },
      {
        "<leader>gd",
        "<CMD>Octo discussion list<CR>",
        desc = "List GitHub Discussions",
      },
      {
        "<leader>gn",
        "<CMD>Octo notification list<CR>",
        desc = "List GitHub Notifications",
      },
      {
        "<leader>gs",
        function()
          require("octo.utils").create_base_search_command { include_current_repo = true }
        end,
        desc = "Search GitHub",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR "ibhagwan/fzf-lua",
      -- OR "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- development
  {
    'towc/nvim-ws-tmux-navigation',
    --'alexghergh/nvim-tmux-navigation',
    config = function()

        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup {
            disable_when_zoomed = true -- defaults to false
        }

        vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

    end
  },
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      vim.keymap.set({ "n", "x" }, "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<leader>as", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>ac", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

      -- vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
      -- vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
    end,
  },
  	{
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")

            -- For logging that is to a file if you wish to trace through requests
            -- for reporting bugs, i would not rely on this, but instead the provided
            -- logging mechanisms within 99.  This is for more debugging purposes
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
			_99.setup({
                -- provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},
                -- When setting this to something that is not inside the CWD tools
                -- such as claude code or opencode will have permission issues
                -- and generation will fail refer to tool documentation to resolve
                -- https://opencode.ai/docs/permissions/#external-directories
                -- https://code.claude.com/docs/en/permissions#read-and-edit
                tmp_dir = "./tmp",

                --- Completions: #rules and @files in the prompt buffer
                completion = {
                    -- I am going to disable these until i understand the
                    -- problem better.  Inside of cursor rules there is also
                    -- application rules, which means i need to apply these
                    -- differently
                    -- cursor_rules = "<custom path to cursor rules>"

                    --- A list of folders where you have your own SKILL.md
                    --- Expected format:
                    --- /path/to/dir/<skill_name>/SKILL.md
                    ---
                    --- Example:
                    --- Input Path:
                    --- "scratch/custom_rules/"
                    ---
                    --- Output Rules:
                    --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
                    --- ... the other rules in that dir ...
                    ---
                    custom_rules = {
                      "scratch/custom_rules/",
                    },

                    --- Configure @file completion (all fields optional, sensible defaults)
                    files = {
                        -- enabled = true,
                        -- max_file_size = 102400,     -- bytes, skip files larger than this
                        -- max_files = 5000,            -- cap on total discovered files
                        -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
                    },
                    --- File Discovery:
                    --- - In git repos: Uses `git ls-files` which automatically respects .gitignore
                    --- - Non-git repos: Falls back to filesystem scanning with manual excludes
                    --- - Both methods apply the configured `exclude` list on top of gitignore

                    --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
                    source = "native", -- "native" (default), "cmp", or "blink"
                },

                --- WARNING: if you change cwd then this is likely broken
                --- ill likely fix this in a later change
                ---
                --- md_files is a list of files to look for and auto add based on the location
                --- of the originating request.  That means if you are at /foo/bar/baz.lua
                --- the system will automagically look for:
                --- /foo/bar/AGENT.md
                --- /foo/AGENT.md
                --- assuming that /foo is project root (based on cwd)
				md_files = {
					"AGENT.md",
				},
			})

            -- take extra note that i have visual selection only in v mode
            -- technically whatever your last visual selection is, will be used
            -- so i have this set to visual mode so i dont screw up and use an
            -- old visual selection
            --
            -- likely ill add a mode check and assert on required visual mode
            -- so just prepare for it now
			vim.keymap.set("v", "<leader>9v", function()
				_99.visual()
			end)

            --- if you have a request you dont want to make any changes, just cancel it
			vim.keymap.set("n", "<leader>9x", function()
				_99.stop_all_requests()
			end)

			vim.keymap.set("n", "<leader>9s", function()
				_99.search()
			end)
		end,
	},
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
-- }}}

-- vim: ts=2 sts=2 sw=2 et
