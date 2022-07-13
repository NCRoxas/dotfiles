local inst_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
local conf_status_ok, lsp_config = pcall(require, "lspconfig")
local form_status_ok, lsp_format = pcall(require, "lsp-format")
local cmp_status_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local aeri_status_ok, aerial = pcall(require, "aerial")
if not (inst_status_ok and conf_status_ok and form_status_ok and cmp_status_ok and aeri_status_ok) then
  return
end

local servers = { "clangd", "cssls", "dockerls", "eslint", "emmet_ls", "gopls", "html", "jsonls", "tsserver",
  "sumneko_lua", "pylsp", "solc", "volar", "yamlls" }

lsp_installer.setup({
  ensure_installed = servers,
  automatic_installation = true
})

lsp_format.setup {}
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
