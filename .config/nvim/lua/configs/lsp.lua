local lspI_S, lsp_installer = pcall(require, "nvim-lsp-installer")
local lspC_S, lsp_config = pcall(require, "lspconfig")
local lspF_S, lsp_format = pcall(require, "lsp-format")
local cmp_S, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local aer_S, aerial = pcall(require, "aerial")
if not (lspI_S and lspC_S and lspF_S and cmp_S and aer_S) then
  return
end

local servers = { "clangd", "cssls", "dockerls", "emmet_ls", "gopls", "html", "jsonls", "tsserver",
  "sumneko_lua", "pyright", "solc", "volar", "yamlls" }

lsp_installer.setup({
  ensure_installed = servers,
  automatic_installation = true
})
lsp_format.setup {
  typescript = { tab_width = 4 },
  yaml = { tab_width = 2 },
}
aerial.setup {}

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
  lsp_format.on_attach(client, bufnr)
  aerial.on_attach(client, bufnr)
end

for _, server in ipairs(servers) do
  lsp_config[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
  })
end
