local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

cmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "Reload the file when it changed",
	group = augroup("checktime", { clear = true }),
	command = "checktime",
})

cmd("TextYankPost", {
	desc = "Highlight on yanked text",
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

cmd("VimResized", {
	desc = "Resize splits if window got resized",
	group = augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd "tabdo wincmd ="
	end,
})

cmd("FileType", {
	desc = "Wrap and spell check text in text files",
	group = augroup("wrap_text", { clear = true }),
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

cmd("FileType", {
	desc = "Unlist quickfist buffers",
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

cmd("CursorHold", {
	desc = "Show line diagnostics in hover window",
	group = augroup("show_line_diagnostics", { clear = true }),
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})

cmd("User", {
	desc = "Show git conflict markers",
	group = augroup("show_git_conflict_markers", { clear = true }),
	pattern = "GitConflictDetected",
	callback = function()
		vim.notify("Conflict detected in " .. vim.fn.expand "<afile>")
	end,
})

local large_file_size = 100000 -- 100KB
cmd("BufReadPre", {
	desc = "Disable certain features for large files",
	group = augroup("large_file_optimization", { clear = true }),
	callback = function()
		local file_size = vim.fn.getfsize(vim.fn.expand "%")
		if file_size > large_file_size then
			vim.opt_local.syntax = "off"
			vim.opt_local.swapfile = false
			vim.opt_local.bufhidden = "unload"
			vim.opt_local.undofile = false
			vim.opt_local.foldenable = false
			vim.opt_local.spell = false
			vim.opt_local.relativenumber = false
			vim.opt_local.number = false
		end
	end,
})
