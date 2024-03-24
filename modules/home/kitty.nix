{ config, lib, ... }: 
let
graphical = if builtins.hasAttr "cherrykitten" config
  then config.cherrykitten.graphical
  else true;
in
{
  programs.kitty = lib.mkIf graphical {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      enable_audio_bell = false;
      background_opacity = 1;
      copy_on_select = "clipboard";
      hide_window_decorations = true;

      # symbol maps
      # Seti-UI + Custom
      "symbol_map U+E5FA-U+E62B" = "Symbols Nerd Font";
      # Devicons
      "symbol_map U+E700-U+E7C5" = "Symbols Nerd Font";
      # Font Awesome
      "symbol_map U+F000-U+F2E0" = "Symbols Nerd Font";
      # Font Awesome Extension
      "symbol_map U+E200-U+E2A9" = "Symbols Nerd Font";
      # Material Design Icons
      "symbol_map U+F500-U+FD46" = "Symbols Nerd Font";
      # Weather
      "symbol_map U+E300-U+E3EB" = "Symbols Nerd Font";
      # Octicons
      "symbol_map U+F400-U+F4A8,U+2665,U+26A1,U+F27C" = "Symbols Nerd Font";
      # Powerline Extra Symbols
      "symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CC-U+E0D2,U+E0D4" = "Symbols Nerd Font";
      # IEC Power Symbols
      "symbol_map U+23FB-U+23FE,U+2b58" = "Symbols Nerd Font";
      # Font Logos
      "symbol_map U+F300-U+F313" = "Symbols Nerd Font";
      # Pomicons
      "symbol_map U+E000-U+E00D" = "Symbols Nerd Font";

    };
  };
}
