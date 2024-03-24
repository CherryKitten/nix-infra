{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard

      rustfmt
      black
      isort
      alejandra
      prettierd
      codespell
      stylua
    ];

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      persistence-nvim
      nvim-web-devicons
      nui-nvim

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin-mocha";
      }

      {
        plugin = which-key-nvim;
        config = toLua "require(\"which-key\").setup()";
      }

      {
        plugin = neo-tree-nvim;
        config = toLuaFile ./plugins/neo-tree.lua;
      }

      {
        plugin = conform-nvim;
        config = toLuaFile ./plugins/conform.lua;
      }

      {
        plugin = dressing-nvim;
        config = toLua "require(\"dressing\").setup()";
      }

      {
        plugin = bufferline-nvim;
        config = toLua "require(\"bufferline\").setup()";
      }

      {
        plugin = lualine-nvim;
        config = toLua "require(\"lualine\").setup()";
      }

      {
        plugin = indent-blankline-nvim;
        config = toLua "require(\"ibl\").setup()";
      }
      {
        plugin = noice-nvim;
        config = toLuaFile ./plugins/noice.lua;
      }
      {
        plugin = dashboard-nvim;
        config = toLuaFile ./plugins/dashboard.lua;
      }

      nvim-notify
      vim-nix
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./keymap.lua}
    '';
  };
}
