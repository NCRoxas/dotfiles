local status_ok, catppuccin = pcall(require, "catppuccin")
local t_status_ok, transparent = pcall(require, "transparent")
local n_status_ok, notify = pcall(require, "notify")
if not (status_ok and t_status_ok and n_status_ok) then
    return
end

vim.g.catppuccin_flavour = "macchiato"
vim.cmd "colorscheme catppuccin"

catppuccin.setup {}

transparent.setup {
    enable = true,
}

notify.setup {
    background_colour = "#000000",
    render = "minimal",
}
