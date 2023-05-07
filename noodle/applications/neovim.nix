{ config, pkgs, ... }: 
let 
  colors = import (../colors.nix);
in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim # theme
      nvim-treesitter
      telescope-nvim
      dashboard-nvim
      
      lualine-nvim  nvim-web-devicons
    ];
    extraConfig = ''
      nnoremap <silent> <Space>f <cmd>Telescope find_files<cr>
    '';

    extraLuaConfig = ''
      require('lualine').setup { options = { theme  = 'auto' } }
      require('dashboard').setup {}

      require("tokyonight").setup({
        style = "night",

        on_colors = function(colors)
          colors.bg = "#${colors.base}"
        end
      })

      vim.cmd[[colorscheme tokyonight-night]]
    '';
  };
}
