return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				nil_ls = {
					settings = {
						["nil"] = {
							formatting = {
								command = { "nixpkgs-fmt" },
							},
						},
					},
				},
				rust_analyzer = {
					settings = {
						["rust_analyzer"] = {
							check = {
								command = "clippy",
							},
							completion = {
								fullFunctionSignatures = {
									enable = true,
								},
							},
							diagnostics = {
								styleLints = {
									enable = true,
								},
							},
							imports = {
								granularity = {
									enforce = true,
								},
							},
						},
					},
				},
			},
		},
	},
}
