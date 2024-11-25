return {
	{
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				-- Configuration options for Catppuccin
				flavour = "mocha", -- "latte", "frappe", "macchiato", "mocha"
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
