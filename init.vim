syntax on
filetype plugin indent on

let mapleader = ','
set number
set tabstop=2		" Number of spaces tab is counted for.
set shiftwidth=2	" Number of spaces to use to autoindent
set path+=.,,src/**
set foldmethod=marker
set clipboard=unnamed " Copy into system (*) register.
set wrap!
"set wildmenu				   " Enalbe enhanced tab autocomplete
" set wildmode=list:longest,full " Complete till longes string

" PRovides tab-completion for all file-related task

" silent! helptags ALL " Load help files for all plugins

" ------------------------------------------------------------------------
" functions
" ------------------------------------------------------------------------
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
	  return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

" ---------------------------------
"  MAPPINGS
"  --------------------------------
" Pluging mappings
noremap <leader>n :NERDTreeToggle<cr>
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
noremap <C-f> :GFiles --cached --others --exclude-standard<cr>
noremap <leader><C-f> :Files<cr>

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'

" Save using <Ctrl-u> (u stands for update)
noremap <C-u> :w<cr> 

" Terminal like VS Code
noremap <c-t> :term<CR>

" Escape alternative 

imap jj <Esc>
" Move insert mode
inoremap <A-k> <C-o>k
inoremap <A-j> <C-o>j
inoremap <A-h> <C-o>h
inoremap <A-l> <C-o>l
" Swamp lines
nnoremap <A-K> :m .-2<CR>==
nnoremap <A-J> :m .+1<CR>==
vnoremap <A-J> :m '>+1<CR>gv=gv
vnoremap <A-K> :m '<-2<CR>gv=gv
inoremap <A-J> <Esc>:m .=1<CR>==gi
inoremap <A-K> <Esc>:m .-2<CR>==gi
" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" Buffer
noremap gn :bn<cr>
noremap gp :bp<cr>

" => C# Code Folding ----------------------------------------------{{{1

au FileType cs set omnifunc=syntaxcomplete#Complete
au FileType cs set foldmethod=marker
au FileType cs set foldmarker={,}
au FileType cs set foldtext=subtitute(getline(v:foldstart),'{.*','{...}',)
au FileType cs set foldlevelstart=2

" }}}

" => Closing Tag Config ------------------------------------------{{{2
let g:closetag_filenames = '*.html'

" }}}

" => PLUGINS -----------------------------------------------------{{{3
call plug#begin(stdpath('data') . '/plugged')

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
   Plug 'preservim/nerdtree'
   Plug 'https://tpope.io/vim/unimpaired.git'
   Plug 'https://github.com/tpope/vim-vinegar.git'
   Plug 'tpope/vim-fugitive'
   Plug 'chrisbra/Colorizer'
	 Plug 'tpope/vim-commentary'
"   Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
   Plug 'jelera/vim-javascript-syntax'
   Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	 Plug 'alvan/vim-closetag'
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'
   Plug 'OmniSharp/omnisharp-vim'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'airblade/vim-rooter' 
   Plug 'w0rp/ale'
   Plug 'vim-airline/vim-airline'
	 " Plug 'navarasu/onedark.nvim'
	 " Plug 'tomasiser/vim-code-dark'
	 Plug	'iranhoe/vim-vscode-theme-plus'
call plug#end()
" So I will keep it in mine.
" Not sure if I need to use YouCompleteMe but looks like a good one

"
" }}}

" => THEME ---------------------------------------------------{{{4

" set t_Co =256
" set t_ut=
" colorscheme murphy " Change a colorscheme
" colorscheme dark
" colorscheme onedark
" colorscheme dark_plus
" colorscheme codedark
" let g:airline_theme = 'codedark'

hi Normal guibg=NONE ctermbg=NONE

" }}}
