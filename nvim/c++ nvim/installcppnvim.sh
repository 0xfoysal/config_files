#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

echo "Starting Neovim setup for C++ competitive programming on Ubuntu..."

# 1. Update system and install prerequisites
echo "Updating system and installing prerequisites..."
#sudo apt update && sudo apt upgrade -y
sudo apt install -y neovim gcc g++ clang python3 python3-pip nodejs npm git curl unzip ripgrep build-essential

# 2. Install pynvim for Python support in Neovim
echo "Installing pynvim..."
#pip3 install --user pynvim

# 3. Install Lazy.nvim (Plugin Manager)
echo "Installing Lazy.nvim..."
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim

# 4. Create Neovim configuration directory and init.lua
echo "Setting up Neovim configuration..."
mkdir -p ~/.config/nvim

cat > ~/.config/nvim/init.lua << 'EOF'
-- Lazy.nvim setup
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

-- Plugin setup
require("lazy").setup({
  {"neovim/nvim-lspconfig"}, -- LSP configuration
  {"williamboman/mason.nvim"}, -- LSP/DAP installer
  {"williamboman/mason-lspconfig.nvim"}, -- Mason + LSPConfig bridge
  {"hrsh7th/nvim-cmp"}, -- Completion framework
  {"hrsh7th/cmp-nvim-lsp"}, -- LSP completion
  {"hrsh7th/cmp-buffer"}, -- Buffer completion
  {"hrsh7th/cmp-path"}, -- File path completion
  {"saadparwaiz1/cmp_luasnip"}, -- Snippet completion
  {"L3MON4D3/LuaSnip"}, -- Snippet engine
  {"rafamadriz/friendly-snippets"}, -- Predefined snippets
  {"mfussenegger/nvim-dap"}, -- Debug Adapter Protocol
  {"rcarriga/nvim-dap-ui"}, -- DAP UI
  {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}}, -- Fuzzy Finder
  {"nvim-tree/nvim-tree.lua"}, -- File explorer
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}, -- Treesitter for syntax
  {"vim-test/vim-test"}, -- Test runner
  {"lewis6991/gitsigns.nvim"}, -- Git integration
  {"tpope/vim-commentary"}, -- Commenting
  {"akinsho/toggleterm.nvim"}, -- Terminal integration
})

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"clangd"},
})

-- LSP configuration
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})

-- Key mappings
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>TestNearest<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { noremap = true, silent = true })

EOF

# 5. Install LSP tools using Mason
echo "Installing LSP tools..."
nvim --headless -c "Lazy sync" -c "qa"

echo "Setup complete! Launch Neovim with 'nvim' and start coding!"