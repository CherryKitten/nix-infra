require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettier" },
		rust = { "rustfmt" },
		nix = { "alejandra" },
		["*"] = { "codespell" },
	},
	log_level = vim.log.levels.ERROR,
  notify_on_error = true,
})
