if &compatible
  set nocompatible
endif

set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')

  call dein#add('$HOME/.local/share/dein/repos/github.com/Shougo')
  "Git
  call dein#add('tpope/vim-fugitive')

  "Hard Time
  call dein#add('takac/vim-hardtime')

  "General
  call dein#add('tpope/vim-dispatch')
  call dein#add('tpope/vim-projectionist')
  call dein#add('noahfrederick/vim-composer')

  "Getting around
  call dein#add('scrooloose/nerdtree')
  call dein#add('jistr/vim-nerdtree-tabs')
  call dein#add('ctrlpvim/ctrlp.vim')

  "Editing
  call dein#add('tpope/vim-surround')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('tmhedberg/matchit')
  call dein#add('arnaud-lb/vim-php-namespace')

  "GUI
  call dein#add('vim-airline/vim-airline')

  "Language specifics
  call dein#add('pangloss/vim-javascript')
  call dein#add('mattn/emmet-vim')
  call dein#add('noahfrederick/vim-laravel')



  call dein#end()
  call dein#save_state()

  if dein#check_install()
	  call dein#install()
  endif

endif

filetype plugin indent on
syntax enable
