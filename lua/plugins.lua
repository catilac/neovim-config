-- plugins.lua
-- Bootstrap Lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("Lazy.nvim installed!")
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
return require("lazy").setup({
  -- Treesitter for syntax highlighting (load early)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    priority = 100, -- Load early
  },

  {
      'dense-analysis/ale',
      config = function()
          -- Configuration goes here.
          local g = vim.g

          g.ale_ruby_rubocop_auto_correct_all = 1

          g.ale_linters = {
              rust = { 'analyzer' },
              lua = {'lua_language_server'}
          }
      end
  },

  -- Language Server Protocol support
  {
    "neovim/nvim-lspconfig", -- Base LSP configurations
    dependencies = {
      -- Server installation manager
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- File explorer
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  

  -- Theme (load last after all functionality is configured)
  { 
    "catppuccin/nvim", 
    name = "catppuccin",
    priority = 1000, -- Load last
  },
})
