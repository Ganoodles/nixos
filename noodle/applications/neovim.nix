{ config, pkgs, ... }: 
let 
  colors = import (../colors.nix);
in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
			oxocarbon-nvim tokyonight-nvim # theme
      nvim-treesitter
      telescope-nvim
      dashboard-nvim
      fzf-vim
      vim-commentary

			nvim-web-devicons
			# indent-blankline-nvim
      nerdtree nerdtree-git-plugin vim-devicons
			barbar-nvim
      
      lualine-nvim 
			nvim-lspconfig
    ];
    extraConfig = ''
			set number
			colorscheme oxocarbon
			set tabstop=2
			set shiftwidth=2

      nnoremap <silent> <Space>f <cmd>Telescope find_files<cr>
      nnoremap <silent> <Space>t <cmd>NERDTreeToggle<cr>
    '';

    extraLuaConfig = ''
      require('lualine').setup { options = { theme  = 'auto' } }
      require('dashboard').setup {}
			
			require('barbar').setup {
				icons = {
					button = 'ⅹ';
				};
			};
    '';
  };
}
