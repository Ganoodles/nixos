{ config, pkgs, ... }:
let
  colors = import (../colors.nix);
in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;

    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars

      oxocarbon-nvim tokyonight-nvim jellybeans-vim # theme

      telescope-nvim # file searching
      dashboard-nvim # dashboard if no file/dir specified
      fzf-vim # do :Ag to find code
      vim-commentary # do gcc to comment code out
      nvim-web-devicons # dependency for a lot of stuff
      vim-vsnip
      cmp-nvim-lsp nvim-cmp nvim-lspconfig cmp-buffer cmp-path cmp_luasnip luasnip friendly-snippets

      {
        plugin = indent-blankline-nvim;
        config = "lua require('indent_blankline').setup()";
      }

      nerdtree
      nerdtree-git-plugin
      vim-devicons # space + t to show filetree
      barbar-nvim # tab bar

      {
        plugin = barbar-nvim;
        config = ''
        lua << EOF
        require('barbar').setup {
          icons = {
          button = 'x'
          }
        }
        EOF
        '';
      }

      lualine-nvim # bottom bar
    ];

    extraLuaConfig = ''
	    dofile(os.getenv("NIXOS_CONFIG_DIR") .. "/noodle/applications/neovim/settings.lua")
    '';

    extraConfig = ''
      nnoremap <silent> <Space>f <cmd>Telescope find_files<cr>
      nnoremap <silent> <Space>t <cmd>NERDTreeToggle<cr>

      highlight Cursor gui=nocombine
      set number
      colorscheme jellybeans

      set tabstop=2
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab
    '';
  };
}
