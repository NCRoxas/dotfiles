local cmp_status_ok, cmp = pcall(require, "cmp")
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not (cmp_status_ok and snip_status_ok) then
	return
end

local select_opts = { behavior = cmp.SelectBehavior.Select }
require("luasnip.loaders.from_vscode").lazy_load()

local cmp_kinds = {
	Text = "󰉿 ",
	Method = "󰆧 ",
	Function = "󰊕 ",
	Constructor = " ",
	Field = "󰜢 ",
	Variable = "󰀫 ",
	Class = "󰠱 ",
	Interface = " ",
	Module = " ",
	Property = "󰜢 ",
	Unit = "󰑭 ",
	Value = "󰎠 ",
	Enum = " ",
	Keyword = "󰌋 ",
	Snippet = " ",
	Color = "󰏘 ",
	File = "󰈙 ",
	Reference = "󰈇 ",
	Folder = "󰉋 ",
	EnumMember = " ",
	Constant = "󰏿 ",
	Struct = "󰙅 ",
	Event = " ",
	Operator = "󰆕 ",
	TypeParameter = " ",
	Codeium = "",
}

local compare = require "cmp.config.compare"

cmp.setup {
	preselect = cmp.PreselectMode.None,
	sorting = {
		priority_weight = 1.0,
		comparators = {
			compare.locality,
			compare.recently_used,
			compare.score,
			compare.offset,
			compare.order,
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	enabled = function()
		-- disable completion in comments
		local context = require "cmp.config.context"
		-- keep command mode completion enabled when cursor is in a comment
		if vim.bo.buftype == "prompt" or vim.bo.buftype == "nofile" then
			return false
		end
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture "comment"
				and not context.in_syntax_group "Comment"
				and not context.in_syntax_group "telescope"
		end
	end,
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(_, vim_item)
			vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
			local strings = vim.split(vim_item.kind, "%s", { trimempty = true })
			vim_item.kind = " " .. strings[1] .. " "
			vim_item.menu = "  (" .. strings[2] .. ")"
			return vim_item
		end,
	},
	duplicates = {
		nvim_lsp = 1,
		lazydev = 1,
		luasnip = 1,
		cmp_tabnine = 1,
		buffer = 1,
		path = 1,
	},
	window = {
		completion = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),
		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	sources = cmp.config.sources {
		{ name = "nvim_lsp", priority = 1000 },
		{ name = "lazydev", priority = 850 },
		{ name = "luasnip", priority = 750 },
		{ name = "buffer", priority = 500 },
		{ name = "path", priority = 250 },
	},
}

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
	view = {
		entries = { name = "wildmenu", separator = "|" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
