"We want the latest vim settings
set nocompatible 

"The default leader is \ but a , is much better.
let mapleader = ','

let NVIM_TUI_ENABLE_TRUE_COLOR=1

"Mouse is enabled only in visual mode
set mouse=nv

"Default to non-paste mode
set nopaste

"Disable line wraps 
set nowrap

"Enable hard-time
let g:hardtime_default_on = 0

"----------Visuals------------"

"Enable syntax highlighting
syntax enable

"Terminal 256 colors to play well with most themes
let t_CO=256

"Set dark background
set background=dark

"Set Vim theme.	
colorscheme hybrid_material

"Lets activate line numbers.
:set number 					

"Also let's activate relative line numbers
set relativenumber 

"Make the foreground and background color 
"of the line number the same as the
"terminal background color , 
"gives a nice margin to the left
":highlight LineNr ctermfg=bg
":highlight LineNr ctermbg=bg


"256 colors are avaliable,
"search for xterm_256 colors for reference
hi vertsplit ctermfg=89 ctermbg=89



"----------Search------------"

"Highlight search results"
set hlsearch

"Incremental serach on"
set incsearch



"---------Split Managment------------"


set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>




"----------Plugings------------"

"/
"/CtrlP
"/

"Searching with tags (using ctags)
nnoremap <leader>f :tag<space>

"Clear all cahce
nnoremap <leader>cac :CtrlPClearAllCaches<CR>

"/
"/NERDTree
"/
let NERDTreeHijackNetrw = 0

"Toggle NERDTree menu"
nnoremap <C-n> :NERDTreeTabsToggle<CR>

"/
"/ctags
"/

nnoremap <leader>f :tag<space>

"/
"/vim-Javascript
"/
let g:javascript_plugin_jsdoc = 1


"----------Mappings------------"

"Make it easy to edit the vim.init file
nnoremap <leader>ev :tabedit $MYNVIMRC<cr>

"Add simple highlight removal"
nnoremap <leader><space> :nohlsearch<cr>

"Make esc key map to ii for faster typing"
inoremap  jk <Esc>

"Easir back navigation
nnoremap <leader>b <C-^> 

"Open plugins file 
nnoremap <leader>epl :vsplit ~/.config/nvim/plugins.vim<cr>

"Open custom-scripts folder
nnoremap <leader>ecs :vsplit ~/.config/nvim/custom-scripts.vim<cr>

"Replaces each occurence under the cursor
nnoremap <leader>re :%s/<C-r><C-w>//g<Left><Left>

"Mapping to the start of line in normal mode
nnoremap <leader>s ^

"Mapping to the end of line in normal mode
nnoremap <leader>d $

"Mapping to the start of line in visual mode
vnoremap <leader>s ^

"Mapping to the end of line in visual mode
vnoremap <leader>d $

"Toggle Hard-time
nnoremap <leader>hm :HardTimeToggle<cr>

"Toggle higlight
nnoremap <leader>nh :nohl<cr>

"Add semicolun to end of line
inoremap <leader>m <C-o>A;

"----------Copy and paste-----------"
"Copy to register a
vnoremap <leader>cpa "ay

"Copy word to register a
nnoremap <leader>cpwa "ayiw

"Copy line to register a
nnoremap <leader>cpla "ayy

"Paste register a contents
nnoremap <leader>pa "ap

"Copy to register b
vnoremap <leader>cpb "by

"Copy word to register b
nnoremap <leader>cpwb "byiw

"Copy line to register b
nnoremap <leader>cplb "byy

"Paste register b contents
nnoremap <leader>pb "bp

"Copy to register + (System clipboard)
vnoremap <leader>cp+ "+y

"Copy word to register + (System clipboard)
nnoremap <leader>cpw+ "+yiw

"Copy line to register + (System clipboard)
nnoremap <leader>cpl+ "+yy

"Paste register a contents
nnoremap <leader>p+ "+p


"----------Laravel-specific-Mappings------------"

nnoremap <leader>r :execute ":e " . g:first_project_path."/routes/" <cr>

function! OpenRoutesFile()
endfunction

"For automatic imports of use statments
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

"-----------Auto-commands-------" 

"Automatically source the vimrc file on save"
augroup autosourcing 
	autocmd!
	autocmd BufwritePost init.vim source %
augroup END

"-----------Custom-files------------"

"Source a dedicated file for plugins
so ~/.config/nvim/plugins.vim       

"Source a dedicated file for my custom scripts
so ~/.config/nvim/custom-scripts.vim




if has('nvim')
  " Hack to get C-h working in NeoVim
  nmap <BS> <C-W>h
endif


"Notes and tips 
"
" - Using ctrl+] will get you to the definistion of the method that the cusror
" is standing on
"
" - press zz to instantly center the line where the cusror is located  
"
" - prsss gg to instantly go the top of the file 
"
" - ctrl+w o will make the selected buffer fullscreen
"
" - When replacing with Gsearch , after quering , select the lines you want to
"   change the parameter in  and the hit 's/<old-pattern>/<new-patter>
"
" - shift+G goes to the end of the file 
" 
" - :tag "query" is fast way to find methods and variables , ctags -R should
"   be initialized first in the desired directory
"
" - "ctags" --> :tn to go to next result , :tp to go to the previous , :ts to select from
"   all tags avaliable
"
"
