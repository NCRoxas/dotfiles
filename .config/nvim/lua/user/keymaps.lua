local is_available = utils.is_available
local map = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--Remap space as leader key
map("", "<Space>", "<Nop>")

-- Standard Operations
map("n", "<leader><leader>", ":source $MYVIMRC<cr>", { desc = "Reload config" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })
map("n", "Q", "<Nop>")

-- Normal --
-- Navigate buffers
if is_available "bufferline" then
    map("n", "<A-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
    map("n", "<A-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer tab" })
    map("n", ">b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer tab right" })
    map("n", "<b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer tab left" })
else
    map("n", "<A-.>", "<cmd>bnext<cr>", { desc = "Next buffer" })
    map("n", "<A-,>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
end

-- Buffer delete
if is_available "bufdelete" then
    map("n", "<leader>c", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
    map("n", "<leader>?", "<cmd>Bwipeout<cr>", { desc = "Wipeout buffer" })
else
    map("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
end

-- Chadtree
if is_available "chadtree" then
    map("n", "<leader>e", "<cmd>CHADopen<cr>", { desc = "Open Chadtree" })
end

-- Trouble
if is_available "trouble" then
    map("n", "<leader>x", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
end

-- Search and replace
map("n", "<leader>rr", ":%s///g<Left><Left>", { desc = "Replace all in current buffer" })
map("n", "<leader>rw", "cgn", { desc = "Replace current word" }) -- Repeat with . jump with n

-- Aerial
if is_available "aerial" then
    map("n", '<leader>z', '<cmd>AerialToggle!<CR>', { desc = "Toggle Outline" })
    map("n", '{', '<cmd>AerialPrev<CR>', { desc = "Previous Function" })
    map("n", '}', '<cmd>AerialNext<CR>', { desc = "Next Function" })
    map("n", '[[', '<cmd>AerialPrevUp<CR>', { desc = "Jump down tree" })
    map("n", ']]', '<cmd>AerialNextUp<CR>', { desc = "Jump up tree" })
end

-- Typescript
if is_available "nvim-lsp-ts-utils" then
    map("n", '<leader>it', ":TSLspOrganize<CR>", { desc = "TS Organize imports" })
    map("n", '<leader>ir', ":TSLspRenameFile<CR>", { desc = "TS Rename File" })
    map("n", '<leader>ia', ":TSLspImportAll<CR>", { desc = "TS Import all" })
end

-- Text case
if is_available "textcase" then
    map("n", "<leader>uu", function()
        require("textcase").current_word("to_upper_case")
    end, { desc = "Upper case" })
    map("n", "<leader>ul", function()
        require("textcase").current_word("to_lower_case")
    end, { desc = "Lower case" })
    map("n", "<leader>us", function()
        require("textcase").current_word("to_snake_case")
    end, { desc = "Snake case" })
    map("n", "<leader>up", function()
        require("textcase").current_word("to_pascal_case")
    end, { desc = "Pascal case" })
    map("n", "<leader>uc", function()
        require("textcase").current_word("to_camel_case")
    end, { desc = "Camel case" })
    map("n", "<leader>uo", function()
        require("textcase").current_word("to_constant_case")
    end, { desc = "Constant case" })
end

-- Smart Splits
if is_available "smart-splits" then
    -- Better window navigation
    map("n", "<leader>v", "<C-w>v", { desc = "Create vertical split" })
    map("n", "<A-h>", function()
        require("smart-splits").move_cursor_left()
    end, { desc = "Move to left split" })
    map("n", "<A-j>", function()
        require("smart-splits").move_cursor_down()
    end, { desc = "Move to below split" })
    map("n", "<A-k>", function()
        require("smart-splits").move_cursor_up()
    end, { desc = "Move to above split" })
    map("n", "<A-l>", function()
        require("smart-splits").move_cursor_right()
    end, { desc = "Move to right split" })

    -- Resize with arrows
    map("n", "<C-Up>", function()
        require("smart-splits").resize_up()
    end, { desc = "Resize split up" })
    map("n", "<C-Down>", function()
        require("smart-splits").resize_down()
    end, { desc = "Resize split down" })
    map("n", "<C-Left>", function()
        require("smart-splits").resize_left()
    end, { desc = "Resize split left" })
    map("n", "<C-Right>", function()
        require("smart-splits").resize_right()
    end, { desc = "Resize split right" })
else
    map("n", "<leader>.", "<C-w>v", { desc = "Create vertical split" })
    map("n", "<A-h>", "<C-w>h", { desc = "Move to left split" })
    map("n", "<A-j>", "<C-w>j", { desc = "Move to below split" })
    map("n", "<A-k>", "<C-w>k", { desc = "Move to above split" })
    map("n", "<A-l>", "<C-w>l", { desc = "Move to right split" })
    map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
    map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
    map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
    map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })
end

-- Comment
if is_available "Comment" then
    map("n", "<leader>a", function()
        require("Comment.api").toggle_current_linewise()
    end, { desc = "Comment line" })
    map(
        "v",
        "<leader>a",
        "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
        { desc = "Toggle comment line" }
    )
end

-- GitSigns
if is_available "gitsigns" then
    map("n", "<leader>gj", function()
        require("gitsigns").next_hunk()
    end, { desc = "Next git hunk" })
    map("n", "<leader>gk", function()
        require("gitsigns").prev_hunk()
    end, { desc = "Previous git hunk" })
    map("n", "<leader>gl", function()
        require("gitsigns").blame_line()
    end, { desc = "View git blame" })
    map("n", "<leader>gp", function()
        require("gitsigns").preview_hunk()
    end, { desc = "Preview git hunk" })
    map("n", "<leader>gh", function()
        require("gitsigns").reset_hunk()
    end, { desc = "Reset git hunk" })
    map("n", "<leader>gr", function()
        require("gitsigns").reset_buffer()
    end, { desc = "Reset git buffer" })
    map("n", "<leader>gs", function()
        require("gitsigns").stage_hunk()
    end, { desc = "Stage git hunk" })
    map("n", "<leader>gu", function()
        require("gitsigns").undo_stage_hunk()
    end, { desc = "Unstage git hunk" })
    map("n", "<leader>gd", function()
        require("gitsigns").diffthis()
    end, { desc = "View git diff" })
end

-- Telescope
if is_available "telescope" then
    map("n", "<leader>fw", function()
        require("telescope.builtin").live_grep()
    end, { desc = "Live grep" })
    map("n", "<leader>gt", function()
        require("telescope.builtin").git_status()
    end, { desc = "Git status" })
    map("n", "<leader>gb", function()
        require("telescope.builtin").git_branches()
    end, { desc = "Git branchs" })
    map("n", "<leader>gc", function()
        require("telescope.builtin").git_commits()
    end, { desc = "Git commits" })
    map("n", "<leader>ff", function()
        require("telescope.builtin").find_files()
    end, { desc = "Search files" })
    map("n", "<leader>fb", function()
        require("telescope.builtin").buffers()
    end, { desc = "Search buffers" })
    map("n", "<leader>fh", function()
        require("telescope.builtin").help_tags()
    end, { desc = "Search help" })
    map("n", "<leader>fk", function()
        require("telescope.builtin").marks()
    end, { desc = "Search marks" })
    map("n", "<leader>fo", function()
        require("telescope.builtin").oldfiles()
    end, { desc = "Search history" })
    map("n", "<leader>fm", function()
        require("telescope.builtin").man_pages()
    end, { desc = "Search man" })
    map("n", "<leader>fy", function()
        require("telescope.builtin").keymaps()
    end, { desc = "Search keymaps" })
    map("n", "<leader>fc", function()
        require("telescope.builtin").commands()
    end, { desc = "Search commands" })
    map("n", "<leader>fr", function()
        require("telescope.builtin").lsp_references()
    end, { desc = "Search references" })
    map("n", "<leader>fd", function()
        require("telescope.builtin").diagnostics()
    end, { desc = "Search diagnostics" })
    map("n", "<leader>ft", "<cmd>TextCaseOpenTelescope<cr>", { desc = "Text case Info" })
end

-- LSP Installer
if is_available "nvim-lsp-installer" then
    map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
    map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "LSP installer" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Refactor" })
end

-- Terminal
if is_available "toggleterm" then
    local toggle_term_cmd = utils.toggle_term_cmd
    map("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    map("n", "<leader>tg", function()
        toggle_term_cmd "lazygit"
    end, { desc = "ToggleTerm lazygit" })
    map("n", "<leader>tn", function()
        toggle_term_cmd "node"
    end, { desc = "ToggleTerm node" })
    map("n", "<leader>tu", function()
        toggle_term_cmd "ncdu"
    end, { desc = "ToggleTerm NCDU" })
    map("n", "<leader>tt", function()
        toggle_term_cmd "htop"
    end, { desc = "ToggleTerm htop" })
    map("n", "<leader>tp", function()
        toggle_term_cmd "python"
    end, { desc = "ToggleTerm python" })
    map("n", "<leader>tl", function()
        toggle_term_cmd "lazygit"
    end, { desc = "ToggleTerm lazygit" })
    map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
    map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" })
    map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })
end

-- Alpha
if is_available "alpha" then
    map("n", "<leader>d", "<cmd>Alpha<cr>", { desc = "Alpha Dashboard" })
end

-- Packer
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer Compile" })
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer Install" })
map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer Sync" })
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer Status" })
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer Update" })

-- Move text up and down
map('n', '<A-Down>', ":MoveLine(1)<CR>", opts)
map('n', '<A-Up>', ":MoveLine(-1)<CR>", opts)
map('v', '<A-Down>', ":MoveBlock(1)<CR>", opts)
map('v', '<A-Up>', ":MoveBlock(-1)<CR>", opts)
map('n', '<A-Right>', ":MoveHChar(1)<CR>", opts)
map('n', '<A-Left>', ":MoveHChar(-1)<CR>", opts)
map('v', '<A-Right>', ":MoveHBlock(1)<CR>", opts)
map('v', '<A-Left>', ":MoveHBlock(-1)<CR>", opts)

-- Extras
map('i', '<C-d>', "<Del>", opts) -- forward delete
map('i', '<C-H>', "<C-w>", opts) -- delete word
map('i', '<C-x>', "<Esc>ddi", opts) -- delete line
map('n', '<C-o>', "o<Esc>k", opts) -- newline

-- Insert --
map("i", "jj", "<esc>", opts)

-- Visual --
map("v", "p", '"_dP', opts)
