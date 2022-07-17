local status_ok, null = pcall(require, "null-ls")
if not status_ok then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatting = null.builtins.formatting
local sources = {
    formatting.stylua.with({
        extra_args = { "--quote_style", "ForceDouble", "--call_parentheses", "NoSingleString" },
    }),
    formatting.prettier.with({
        extra_args = function(params)
            return params.options
                and params.options.tabSize
                and {
                    "--tab-width",
                    params.options.tabSize,
                }
        end,
    }),
    formatting.prettierd,
    formatting.eslint_d,
    formatting.black,
    formatting.isort,
    formatting.clang_format,
    formatting.gofmt,
    formatting.goimports,
}

null.setup({
    sources = sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
