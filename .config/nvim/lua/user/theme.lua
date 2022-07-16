local status_ok, catppuccin = pcall(require, "catppuccin")
local t_status_ok, transparent = pcall(require, "transparent")
local n_status_ok, notify = pcall(require, "notify")
if not (status_ok and t_status_ok and n_status_ok) then
  return
end

vim.g.catppuccin_flavour = "macchiato"
vim.cmd "colorscheme catppuccin"

catppuccin.setup({
  dim_inactive = true,
  transparent_background = true,
  term_colors = true,
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    coc_nvim = false,
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    gitgutter = true,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
      transparent_panel = false,
    },
    neotree = {
      enabled = false,
      show_root = false,
      transparent_panel = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = true,
    hop = false,
    notify = true,
    telekasten = true,
    symbols_outline = true,
  }
})

transparent.setup({
  enable = true, -- boolean: enable transparent
  -- extra_groups = { -- table/string: additional groups that should be cleared
  --   "BufferLineTabClose",
  --   "BufferlineBufferSelected",
  --   "BufferLineFill",
  --   "BufferLineBackground",
  --   "BufferLineSeparator",
  --   "BufferLineIndicatorSelected",
  -- },
  exclude = {}, -- table: groups you don't want to clear
})

notify.setup({
  background_colour = "#000000",
  render = "minimal",
})
