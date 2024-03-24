{ config, pkgs, inputs, ... }:

{

  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        rnix-lsp

        xclip
        wl-clipboard
      ];

      plugins = with pkgs.vimPlugins; [

        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin";
        }

        { plugin = which-key-nvim;
          config = toLua "require(\"which-key\").setup()";
        }

        nvim-cmp
        neodev-nvim

        cmp_luasnip
        cmp-nvim-lsp

        luasnip
        friendly-snippets


        lualine-nvim
        nvim-web-devicons

        vim-nix
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
        ${builtins.readFile ./nvim/keymap.lua}
      '';
    };
}
