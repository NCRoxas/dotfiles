local lspI_S, lsp_installer = pcall(require, "nvim-lsp-installer")
local lspC_S, lsp_config = pcall(require, "lspconfig")
local cmp_S, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local aer_S, aerial = pcall(require, "aerial")
if not (lspI_S and lspC_S and cmp_S and aer_S) then
    return
end

local servers = {
    "clangd",
    "cssls",
    "dockerls",
    "emmet_ls",
    "gopls",
    "html",
    "jsonls",
    -- "tsserver",
    "sumneko_lua",
    "pyright",
    "solc",
    "volar",
    "yamlls",
}

lsp_installer.setup {
    ensure_installed = servers,
    automatic_installation = true,
}
aerial.setup {}

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
    aerial.on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
end

for _, server in ipairs(servers) do
    lsp_config[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

return {
    capabilities = capabilities,
    on_attach = on_attach
}
