local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local mappings = {
	n = {
		["<leader>"] = {
			f = { name = "File" },
			l = { name = "LSP" },
			c = { name = "Code Actions" },
			o = { name = "Ollama" },
		},
	},
	v = {
		["<leader>"] = {
			o = { name = "Ollama" },
			s = { name = "Sort" },
		},
	},
}

local extra_sections = {
	g = "Go",
	r = "Replace",
	s = "Sort",
	o = "Ollama",
	c = "Code Actions",
}

which_key.setup {
	plugins = {
		spelling = { enabled = true },
		presets = { operators = false },
	},
	window = {
		border = "none",
		margin = { 2, 2, 2, 2 },
		padding = { 2, 2, 2, 2 },
	},
}

local function init_table(mode, prefix, idx)
	if not mappings[mode][prefix][idx] then
		mappings[mode][prefix][idx] = { name = extra_sections[idx] }
	end
end

init_table("n", "<leader>", "t")
init_table("n", "<leader>", "f")
init_table("n", "<leader>", "g")
init_table("n", "<leader>", "r")

for mode, prefixes in pairs(mappings) do
	for prefix, mapping_table in pairs(prefixes) do
		which_key.register(mapping_table, {
			mode = mode,
			prefix = prefix,
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		})
	end
end
