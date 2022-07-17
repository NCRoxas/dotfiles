local status_ok, gs = pcall(require, "gitsigns")
if not status_ok then
    return
end

gs.setup {
    current_line_blame = true,
}
