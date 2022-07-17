local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    print "Installing packer close and reopen Neovim..."
    vim.cmd "packadd packer.nvim"
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

return packer.startup(function(use)
    -- Main plugins
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used in lots of plugins
    use "rcarriga/nvim-notify" -- Notification Enhancer
    use "famiu/bufdelete.nvim" -- Better buffer closing
    use "akinsho/bufferline.nvim" -- Bufferline
    use "mrjones2014/smart-splits.nvim" -- Smart directional split resizing and navigation
    use "akinsho/nvim-toggleterm.lua" -- Floating terminal

    -- Design
    use({ "catppuccin/nvim", as = "catppuccin" }) -- Theme
    use "goolord/alpha-nvim" -- Dashboard
    use "kyazdani42/nvim-web-devicons" -- Icons
    use "nvim-lualine/lualine.nvim" -- Statusline
    use "lewis6991/gitsigns.nvim" -- Git decorations
    use "norcalli/nvim-colorizer.lua" -- Colorize rgb codes
    use "xiyaowong/nvim-transparent" -- Add transparency

    -- Telescope
    use "nvim-telescope/telescope.nvim" -- File search

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring" -- Context based commenting
    use "windwp/nvim-ts-autotag" -- Autoclose tags
    use "p00f/nvim-ts-rainbow" -- Parenthesis highlighting

    -- Formatting
    use "lukas-reineke/indent-blankline.nvim" -- Indentation
    use "windwp/nvim-autopairs" -- Autoclose Brackets
    use "williamboman/nvim-lsp-installer" -- Manage LSP
    use "neovim/nvim-lspconfig" -- LSP config
    use "johmsalas/text-case.nvim" -- Change text casing
    use "jose-elias-alvarez/null-ls.nvim" -- Lsp hooks

    -- Completion
    use "L3MON4D3/LuaSnip" -- Snippet engine
    use "hrsh7th/nvim-cmp" -- Autocomplete engine
    use "hrsh7th/cmp-nvim-lsp" -- LSP completion
    use "hrsh7th/cmp-buffer" -- Buffer completion
    use "hrsh7th/cmp-path" -- Path completion
    use "hrsh7th/cmp-cmdline" -- Cmd completion
    use "hrsh7th/cmp-nvim-lsp-signature-help" -- Display function signatures
    use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
    use "rafamadriz/friendly-snippets" -- Vscode friendly snippets
    use "crispgm/nvim-go" -- Go stuff

    -- Extras
    use "declancm/cinnamon.nvim" -- Smooth scrolling
    use "max397574/better-escape.nvim" -- Smooth escaping
    use "numToStr/Comment.nvim" -- Smart commenting
    use "folke/which-key.nvim" -- Key popup
    use "stevearc/aerial.nvim" -- Code outline
    use "ms-jpq/chadtree" -- Chadtree
    use "fedepujol/move.nvim" -- Move lines
    use "haya14busa/is.vim" -- Auto clear highlight 
    use "folke/trouble.nvim" -- Diagnostics

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        packer.sync()
    end
end)
