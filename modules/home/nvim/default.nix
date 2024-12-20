{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      lazygit
      # Telescope
      ripgrep
      ansible-language-server
      nil
      nixpkgs-fmt
      # rust
      rust-analyzer
      rustfmt
      # misc
      nodePackages.prettier
      marksman
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig =
      let
        plugins = with pkgs.vimPlugins; [
          LazyVim
          bufferline-nvim
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          cmp_luasnip
          conform-nvim
          dashboard-nvim
          dressing-nvim
          edgy-nvim
          flash-nvim
          friendly-snippets
          gitsigns-nvim
          indent-blankline-nvim
          lualine-nvim
          neo-tree-nvim
          neoconf-nvim
          neodev-nvim
          noice-nvim
          nui-nvim
          nvim-cmp
          nvim-lint
          nvim-lspconfig
          nvim-notify
          nvim-spectre
          nvim-treesitter
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-ts-autotag
          nvim-ts-context-commentstring
          nvim-web-devicons
          persistence-nvim
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          trouble-nvim
          vim-illuminate
          vim-startuptime
          which-key-nvim
          { name = "LuaSnip"; path = luasnip; }
          { name = "catppuccin"; path = catppuccin-nvim; }
          { name = "mini.ai"; path = mini-nvim; }
          { name = "mini.bufremove"; path = mini-nvim; }
          { name = "mini.comment"; path = mini-nvim; }
          { name = "mini.indentscope"; path = mini-nvim; }
          { name = "mini.pairs"; path = mini-nvim; }
          { name = "mini.surround"; path = mini-nvim; }
        ];
        mkEntryFromDrv = drv:
          if lib.isDerivation drv then
            { name = "${lib.getName drv}"; path = drv; }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          dev = {
            -- reuse files from pkgs.vimPlugins.*
            path = "${lazyPath}",
            patterns = { "." },
            -- fallback to download
            fallback = true,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- The following configs are needed for fixing lazyvim on nix
            -- force enable telescope-fzf-native.nvim
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
            -- disable mason.nvim, use programs.neovim.extraPackages
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },
            { import = "lazyvim.plugins.extras.formatting.black" },
            { import = "lazyvim.plugins.extras.formatting.prettier" },

            { import = "lazyvim.plugins.extras.lang.docker" },
            { import = "lazyvim.plugins.extras.lang.json" },
            { import = "lazyvim.plugins.extras.lang.python" },
            { import = "lazyvim.plugins.extras.lang.rust" },
            { import = "lazyvim.plugins.extras.lang.tailwind" },
            { import = "lazyvim.plugins.extras.lang.typescript" },
            { import = "lazyvim.plugins.extras.lang.yaml" },

            { import = "lazyvim.plugins.extras.linting.eslint" },

            { import = "lazyvim.plugins.extras.coding.luasnip" },
            { import = "lazyvim.plugins.extras.coding.mini-surround" },
            { import = "lazyvim.plugins.extras.coding.mini-comment" },

            -- import/override with your plugins
            { import = "plugins" },
            -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
            { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
          },
        })
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
          c
          lua
        ])).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
}
