_G.utils = {}

utils.user_terminals = {}

function utils.is_available(plugin)
  local status_ok, which_key = pcall(require, plugin)
  if status_ok then
    return true
  else
    return false
  end
end

function utils.toggle_term_cmd(term_details)
  if type(term_details) == "string" then
    term_details = { cmd = term_details, hidden = true }
  end
  local term_key = term_details.cmd
  if vim.v.count > 0 and term_details.count == nil then
    term_details.count = vim.v.count
    term_key = term_key .. vim.v.count
  end
  if utils.user_terminals[term_key] == nil then
    utils.user_terminals[term_key] = require("toggleterm.terminal").Terminal:new(term_details)
  end
  utils.user_terminals[term_key]:toggle()
end

function utils.alpha_button(sc, txt)
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>")
  if vim.g.mapleader then
    sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader)
  end
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

return utils