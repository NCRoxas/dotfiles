local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {},
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false
  },
  autotag = {
    enable = true
  },
  incremental_selection = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil,
  },
}

