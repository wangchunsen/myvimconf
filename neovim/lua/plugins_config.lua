-------------------------------------------------------------------------------
-- These are example settings to use with nvim-metals and the nvim built-in
-- LSP. Be sure to thoroughly read the the `:help nvim-metals` docs to get an
-- idea of what everything does. Again, these are meant to serve as an example,
-- if you just copy pasta them, then they'll work,  but hopefully after time
-- goes on you'll cater them to your own liking.
--
-- The below configuration also makes use of the following plugins besides
-- nvim-metals, and therefore is a bit opinionated:
--
-- - https://github.com/hrsh7th/nvim-cmpe
--   - hrsh7th/cmp-nvim-lsp for lsp completion sources
--   - hrsh7th/cmp-vsnip for snippet sources
--   - hrsh7th/vim-vsnip for snippet support
--
-- - https://github.com/wbthomason/packer.nvim for package management
-- - https://github.com/mfussenegger/nvim-dap (for debugging)
-------------------------------------------------------------------------------

vim.opt.termguicolors = true

local cmd = vim.cmd

local function map(mode, lhs, fhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, fhs, options)
end

----------------------------------
-- PLUGINS -----------------------
----------------------------------
cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })
  use{
    "neovim/nvim-lspconfig",
    config = function()
        --golang lsp server
        require'lspconfig'.gopls.setup{}
        --clojure 
        require'lspconfig'.clojure_lsp.setup{}
    end
  }

  use {
    "EdenEast/nightfox.nvim",
    config = function () 
        require('nightfox').setup({
            options = {
              inverse = {             -- Inverse highlight for different types
                match_paren = true
              }
            }
        })
        vim.cmd("colorscheme duskfox")
    end
  }   
  use {
    "Yggdroot/indentLine",
    config = function()
      vim.cmd [[
      let g:vim_json_conceal=0
      let g:indentLine_char = ''
      ]]
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    -- tag = 'release' -- To use the latest release
    config = function ()
        require('gitsigns').setup()
    end
  }
  use {
      "phaazon/hop.nvim",
      config = function()
        require('hop').setup()
        vim.api.nvim_set_keymap('n', 'ss', "<cmd>HopChar2<cr>", {})
        vim.api.nvim_set_keymap('n', 'S', "<cmd>HopWord<cr>", {})
        vim.api.nvim_set_keymap('n', 'sl', "<cmd>HopLineStart<cr>", {})
      end

  }
  use { 'echasnovski/mini.nvim', branch = 'stable' ,
    requires =  { 'kyazdani42/nvim-web-devicons' },
    config = function()
        require('mini.comment').setup{
            mappings = {
               -- Toggle comment (like `gcip` - comment inner paragraph) for both
               -- Normal and Visual modes
               comment = 'gc',
               -- Toggle comment on current line
               comment_line = 'gcc',
               -- Define 'comment' textobject (like `dgc` - delete whole comment block)
               textobject = 'gc',
             }
        }
        require('mini.pairs').setup()
        require('mini.statusline').setup()
        require('mini.completion').setup()
        require('mini.starter').setup()
        vim.api.nvim_set_keymap('i', [[<Tab>]],   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
        vim.api.nvim_set_keymap('i', [[<S-Tab>]], [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
    end
  }

  use({
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  })
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = { "p00f/nvim-ts-rainbow" },
    config = function()  
        require("nvim-treesitter.configs").setup {
           rainbow = {
             enable = true,
             -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
             extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
             max_file_lines = nil, -- Do not enable for files with more than n lines, int
             -- colors = {}, -- table of hex strings
             -- termcolors = {} -- table of colour name strings
           }
        }
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function ()
        vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>",  { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>",  { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>g', "<cmd>lua require('telescope.builtin').live_grep()<CR>",  { noremap = true, silent = true })
    end
  }
  -- clojure
  use {
    'Olical/conjure', branch = 'develop',
    requires = {
        'clojure-vim/vim-jack-in' ,
        'radenling/vim-dispatch-neovim' ,
        'tpope/vim-dispatch'
    },
    config = function()
        vim.cmd [[
        let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:false
        ]]
    end
  }
  -- use {
  --     'tpope/vim-fireplace',
  --        requires = {
  --           'clojure-vim/vim-jack-in' ,
  --           'radenling/vim-dispatch-neovim',
  --           'tpope/vim-dispatch'
  --       },
  -- }
  use {
      "guns/vim-sexp",
      config = function()
      end
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings refer to the configuration section below
      }
    end
  }
  use { "udalov/kotlin-vim" }
  use { 
    "airblade/vim-rooter",
    config = function()
        vim.cmd[[
        " only manual mode, use :Rooter to change rooter manually
        let g:rooter_manual_only = 1
        let g:rooter_patterns = ['.git', 'deps.edn', 'project.clj','build.sbt', 'package.json']
        ]]
    end
  }
  use {
      "natecraddock/workspaces.nvim",
      config = function () 
        require("workspaces").setup{            
            hooks = {
                open = { "Telescope find_files" },
            }
        }
        require("telescope").load_extension("workspaces")
        vim.api.nvim_set_keymap('n', '<leader>w', "<cmd>lua require('telescope').extensions.workspaces.workspaces()<CR>",  { noremap = true, silent = true })
      end
  }
end)

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global


-- LSP
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics
map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) -- all workspace errors
map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) -- all workspace warnings
map("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
map("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>")
map("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>")

-- Example mappings for usage with nvim-dap. If you don't use that, you can
-- skip these
map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
map("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
map("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])



require'nvim-tree'.setup()
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
map("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>")
map("n", "<leader>n", "<cmd>NvimTreeFindFile<cr>")



----------------------------------
-- COMMANDS ------------------
----------------------------------
-- LSP
cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
-- NOTE: You may or may not want java included here. You will need it if you want basic Java support
-- but it may also conflict if you are using something like nvim-jdtls which also works on a java filetype
-- autocmd.
cmd([[autocmd FileType java,scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
cmd([[augroup end]])

----------------------------------
-- LSP Setup ---------------------
----------------------------------
metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  serverVersion = "0.10.9+133-9aae968a-SNAPSHOT",
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

-- If you want a :Format command this is useful
cmd([[command! Format lua vim.lsp.buf.formatting()]])
cmd([[command! RunCode lua vim.lsp.codelens.run()]])

map("n", "<A-->", "<cmd>vertical resize -2<cr>", {})
map("n", "<A-=>", "<cmd>vertical resize +2<cr>", {})
map("n", "<A-_>", "<cmd>resize -2<cr>", {})
map("n", "<A-+>", "<cmd>resize +2<cr>", {})

map("i", "jk", "<ESC>", {})
