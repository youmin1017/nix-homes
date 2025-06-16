local enabled = {
	"LazyVim",
	"dial.nvim",
	"flit.nvim",
	"lazy.nvim",
	"leap.nvim",
	"mini.ai",
	"mini.comment",
	"mini.move",
	"mini.pairs",
	"mini.surround",
	"nvim-treesitter",
	"nvim-treesitter-textobjects",
	"nvim-ts-context-commentstring",
	"snacks.nvim",
	"ts-comments.nvim",
	"vim-repeat",
	"yanky.nvim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
	return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end
vim.g.snacks_animate = false

---@type LazySpec
return {
	{
		"snacks.nvim",
		opts = {
			bigfile = { enabled = false },
			dashboard = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			notifier = { enabled = false },
			picker = { enabled = false },
			quickfile = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
		},
	},
	{
		"LazyVim/LazyVim",
		config = function(_, opts)
			opts = opts or {}
			-- disable the colorscheme
			opts.colorscheme = function() end
			require("lazyvim").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { highlight = { enable = false } },
	},
}
