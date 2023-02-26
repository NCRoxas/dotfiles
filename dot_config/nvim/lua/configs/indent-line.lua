local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup {
	buftype_exclude = {
		"nofile",
		"terminal",
		"lsp-installer",
		"lspinfo",
	},
	filetype_exclude = {
		"help",
		"startify",
		"aerial",
		"alpha",
		"dashboard",
		"packer",
		"neogitstatus",
		"NvimTree",
		"neo-tree",
		"Trouble",
	},
	context_patterns = {
		"class",
		"return",
		"function",
		"method",
		"^if",
		"^while",
		"jsx_element",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
		"if_statement",
		"else_clause",
		"jsx_element",
		"jsx_self_closing_element",
		"try_statement",
		"catch_clause",
		"import_statement",
		"operation_type",
	},
	char = "▏",
	use_treesitter = true,
	show_current_context = true,
	show_current_context_start = true,
	show_trailing_blankline_indent = false,
}
