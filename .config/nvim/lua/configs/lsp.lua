local lspI_S, lsp_installer = pcall(require, "nvim-lsp-installer")
local lspC_S, lsp_config = pcall(require, "lspconfig")
local cmp_S, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local aer_S, aerial = pcall(require, "aerial")
local ts_S, ts = pcall(require, "typescript")
if not (lspI_S and lspC_S and cmp_S and aer_S and ts_S) then
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
ts.setup {}

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
    aerial.on_attach(client, bufnr)
end

for _, server in ipairs(servers) do
    lsp_config[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
