return {
	"nvimdev/dashboard-nvim",
	opts = function()
		local logo = [[
Nyanyanyanyanyanyanyanyanyanyanyanyanyanyanyanyanyanya
██╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		require("dashboard").setup({
			theme = "doom",
			hide = {
				statusline = false,
				tabline = true, -- hide the tabline
			},
			config = {
				header = vim.split(logo, "\n"),
		-- stylua: ignore
		center = {
			{ action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
			{ action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
			{ action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
			{ action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
			{ action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
			{ action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
		},
				footer = { "Meow!!!" }, --your footer
			},
		})
	end,
}
