local status_ok, pairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

pairs.setup {
	check_ts = true,
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
		java = false,
	},
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", "\"", "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0,
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
}