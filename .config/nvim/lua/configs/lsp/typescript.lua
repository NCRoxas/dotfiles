local status_ok, ts = pcall(require, "typescript")
if not status_ok then
    return
end

ts.setup {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = {
        on_attach = require("configs.lsp.settings").on_attach,
        capabilities = require("configs.lsp.settings").capabilities,
    },
}
