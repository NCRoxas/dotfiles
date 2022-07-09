local status_inst, lsp_installer = pcall(require, "nvim-lsp-installer")
local status_conf, lsp_config = pcall(require, "lspconfig")
local status_form, lsp_format = pcall(require, "lsp-format")
local status_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not (status_inst and status_conf and status_form and status_cmp) then
  return
end

local servers = { "clangd", "cssls", "dockerls", "eslint", "emmet_ls", "gopls", "html", "jsonls", "tsserver",
  "sumneko_lua", "pylsp", "solc", "volar", "yamlls" }

lsp_installer.setup({
  ensure_installed = servers,
  automatic_installation = true
})

lsp_format.setup {}
local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in ipairs(servers) do
  lsp_config[server].setup({ on_attach = lsp_format.on_attach, capabilities = capabilities })
end
