local status_ok, tr = pcall(require, "trouble")
if not status_ok then
    return
end

tr.setup {
    auto_fold = false,
    use_diagnostic_signs = true,
}
