--------------------------------------------------
-- NEOVIDE CURSOR (Neovide-Cursor)
--------------------------------------------------
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true

  -- cursor effect
  vim.g.neovide_cursor_vfx_mode = ""
end




--------------------------------------------------
-- BASIC SETTINGS
--------------------------------------------------
vim.g.mapleader = " "

--------------------------------------------------
-- CTRL + P FILE SEARCH
--------------------------------------------------
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })



vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.mouse = "a"

--------------------------------------------------
-- FORMAT SHORTCUT
--------------------------------------------------
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })


--------------------------------------------------
-- BOOTSTRAP lazy.nvim
--------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

--------------------------------------------------
-- GLOBAL KEYMAPS (MUST BE OUTSIDE lazy.nvim)
--------------------------------------------------

-- FORMAT (Ctrl + F)
vim.keymap.set("n", "<C-f>", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })

-- FAST FILE SEARCH (Ctrl + P)
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- LIVE GREP
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })




--------------------------------------------------
-- PLUGINS
--------------------------------------------------
require("lazy").setup({
------------------------------------------------
-- TERMINAL (Ctrl + T)
------------------------------------------------
{
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<C-t>]],
    direction = "float",
    float_opts = {
      border = "rounded",
    },
  },
},

  ------------------------------------------------
  -- THEME
  ------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  ------------------------------------------------
  -- ICONS
  ------------------------------------------------
  "nvim-tree/nvim-web-devicons",

  ------------------------------------------------
  -- FILE TREE
  ------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
    end,
  },

  ------------------------------------------------
  -- STATUS LINE
  ------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- SAFE
  },

  ------------------------------------------------
  -- TELESCOPE
  ------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>" },
    },
  },

  ------------------------------------------------
  -- TREESITTER ✅ FIXED
  ------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "json",
        "bash",
      },
      highlight = { enable = true },
    },
  },
------------------------------------------------
-- MASON (LSP INSTALLER)
------------------------------------------------
{
  "williamboman/mason.nvim",
  opts = {},
},

{
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "pyright",   -- Python
      "clangd",    -- C / C++
      "lua_ls",    -- Lua
      "ts_ls",     -- TS / JS
    },
  },
},

------------------------------------------------
-- LSP (Python, C++, TS, Lua)
------------------------------------------------
{
  "neovim/nvim-lspconfig",
  config = function()
    -- Lua
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- Python
    vim.lsp.config("pyright", {})

    -- C / C++
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--background-index" },
    })

    -- TS / JS
    vim.lsp.config("ts_ls", {})
  end,
},

------------------------------------------------
-- AUTOCOMPLETE (CMP + SNIPPETS)
------------------------------------------------
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },
    })
  end,
},

  ------------------------------------------------
  -- COMMENTS
  ------------------------------------------------
  { "numToStr/Comment.nvim", opts = {} },

  ------------------------------------------------
  -- GIT
  ------------------------------------------------
  { "lewis6991/gitsigns.nvim", opts = {} },



  ------------------------------------------------
-- FAST TERMINAL
------------------------------------------------
{
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = {
      border = "rounded",
    },
  },
},


})

