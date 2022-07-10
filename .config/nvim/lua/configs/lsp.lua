local status_inst, lsp_installer = pcall(require, "nvim-lsp-installer")
local status_conf, lsp_config = pcall(require, "lspconfig")
local status_form, lsp_format = pcall(require, "lsp-format")
local status_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local status_aer, aerial = pcall(require, "aerial")
if not (status_inst and status_conf and status_form and status_cmp and status_aer) then
  return
end

local servers = { "clangd", "cssls", "dockerls", "eslint", "emmet_ls", "gopls", "html", "jsonls", "tsserver",
  "sumneko_lua", "pylsp", "solc", "volar", "yamlls" }

lsp_installer.setup({
  ensure_installed = servers,
  automatic_installation = true
})

lsp_format.setup {}
aerial.setup({
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>z', '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
    -- Jump up the tree with '[[' or ']]'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
  end
})

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client)
  lsp_format.on_attach(client)
  aerial.on_attach(client)
end

for _, server in ipairs(servers) do
  lsp_config[server].setup({ on_attach = on_attach, capabilities = capabilities })
end
