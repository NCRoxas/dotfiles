local opt = vim.opt
local g = vim.g

-- Options
opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- Connection to the system clipboard
opt.completeopt = { "menuone", "noselect" } -- Options for insert mode completion
opt.cursorline = true -- Highlight the current line
opt.expandtab = true -- convert tabs to spaces
opt.fileencoding = "utf-8" -- File content encoding for the buffer
opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
opt.history = 100 -- Number of commands to remember in a history table
opt.ignorecase = true -- Case insensitive searching
opt.laststatus = 3 -- globalstatus
opt.lazyredraw = true -- lazily redraw screen
opt.mouse = "a" -- Enable mouse support
opt.number = true -- Show numberline
opt.preserveindent = true -- Preserve indent structure as much as possible
opt.pumheight = 10 -- Height of the pop up menu
opt.relativenumber = true -- Show relative numberline
opt.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
opt.scrolloff = 8 -- Number of lines to keep above and below the cursor
opt.tabstop = 4 -- Number of space in a tab
opt.shiftwidth = 4 -- Number of space inserted for indentation
opt.showmode = false -- Disable showing modes in command line
opt.signcolumn = "yes" -- Always show the sign column
opt.smartcase = true -- Case sensitive searching
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- Splitting a new window below the current one
opt.splitright = true -- Splitting a new window at the right of the current one
opt.swapfile = false -- Disable use of swapfile for the buffer
opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
opt.timeoutlen = 300 -- Length of time to wait for a mapped sequence
opt.undofile = true -- Enable persistent undo
opt.updatetime = 300 -- Length of time to wait before triggering the plugin
opt.wrap = false -- Disable wrapping of lines longer than the width of window

-- Global
g.mapleader = " "
g.highlighturl_enabled = true -- highlight URLs by default
g.zipPlugin = false -- disable zip
g.load_black = false -- disable black
g.loaded_2html_plugin = true -- disable 2html
g.loaded_getscript = true -- disable getscript
g.loaded_getscriptPlugin = true -- disable getscript
g.loaded_gzip = true -- disable gzip
g.loaded_logipat = true -- disable logipat
g.loaded_matchit = true -- disable matchit
g.loaded_netrwFileHandlers = true -- disable netrw
g.loaded_netrwPlugin = true -- disable netrw
g.loaded_netrwSettngs = true -- disable netrw
g.loaded_remote_plugins = true -- disable remote plugins
g.loaded_tar = true -- disable tar
g.loaded_tarPlugin = true -- disable tar
g.loaded_zip = true -- disable zip
g.loaded_zipPlugin = true -- disable zip
g.loaded_vimball = true -- disable vimball
g.loaded_vimballPlugin = true -- disable vimball