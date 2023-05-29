local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('neoclide/coc.nvim', {branch = 'release'})
Plug('fatih/vim-go', {['do'] = vim.fn['GoUpdateBinaries']})
Plug 'evanleck/vim-svelte'
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'christoomey/vim-tmux-navigator'
Plug('junegunn/fzf', { ['do'] =vim.fn['fzf#install()'] })
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})
Plug('srcery-colors/srcery-vim')
Plug('bluz71/vim-moonfly-colors')
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug('tpope/vim-commentary')
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

vim.call('plug#end')
