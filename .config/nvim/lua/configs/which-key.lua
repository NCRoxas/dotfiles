local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local is_available = utils.is_available
    local mappings = {
        n = {
            ["<leader>"] = {
                f = { name = "File" },
                p = { name = "Packer" },
                l = { name = "LSP" },
            },
        },
    }

    local extra_sections = {
        g = "Git",
        r = "Search",
        u = "Change case",
        t = "Terminal",
    }

    which_key.setup({
        plugins = {
            spelling = { enabled = true },
            presets = { operators = false },
        },
        window = {
            border = "rounded",
            padding = { 2, 2, 2, 2 },
        },
    })

    local function init_table(mode, prefix, idx)
        if not mappings[mode][prefix][idx] then
            mappings[mode][prefix][idx] = { name = extra_sections[idx] }
        end
    end

    if is_available "textcase" then
        init_table("n", "<leader>", "u")
    end


    if is_available "gitsigns" then
        init_table("n", "<leader>", "g")
    end

    if is_available "toggleterm" then
        init_table("n", "<leader>", "t")
    end

    if is_available "telescope" then
        init_table("n", "<leader>", "f")
        init_table("n", "<leader>", "g")
    end

    init_table("n", "<leader>", "r")

    for mode, prefixes in pairs(mappings) do
        for prefix, mapping_table in pairs(prefixes) do
            which_key.register(mapping_table, {
                mode = mode,
                prefix = prefix,
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            })
        end
    end
end
