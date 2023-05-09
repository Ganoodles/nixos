{ config, pkgs, ... }:
let
  colors = import (../colors.nix);

  remap_config = ''
      nnoremap <silent> <Space>f <cmd>Telescope find_files<cr>
      nnoremap <silent> <Space>t <cmd>NERDTreeToggle<cr>
  '';

in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;

    # lsp

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars

      oxocarbon-nvim
      tokyonight-nvim # theme

      telescope-nvim # file searching
      dashboard-nvim # dashboard if no file/dir specified
      fzf-vim # do :Ag to find code
      vim-commentary # do gcc to comment code out
      nvim-web-devicons # dependency for a lot of stuff
      # indent-blankline-nvim

      nerdtree
      nerdtree-git-plugin
      vim-devicons # space + t to show filetree
      barbar-nvim # tab bar

      lualine-nvim # bottom bar
    ];
    extraConfig = ''
      highlight Cursor gui=nocombine
      set number
      colorscheme oxocarbon

      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab

    '' + remap_config;

    extraLuaConfig = ''
      vim.api.nvim_set_hl(0, "Normal", { bg = "none"} )
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"} )

      require('lualine').setup { options = { theme  = 'auto' } }
      require('dashboard').setup {}

      require('barbar').setup {
          icons = {
          button = 'x'
        	}
      }
    '';
  };
}
