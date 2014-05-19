call pathogen#infect()

set nocompatible 
set hidden
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set cursorline
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=79
set shell=bash
" Prevent vim from clobbering the scrollback buffer
set t_ti= t_te=
set scrolloff=3
set backup
set backupdir=~/.vim-tmp,~/.tmp/,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp/,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set showcmd
syntax enable
filetype plugin indent on
set wildmode=longest,list
set wildmenu
let mapleader=","
set background=dark
colorscheme solarized

augroup vimrcEx
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position if it still exists
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " For ruby and friends, use two space indents
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:&gt;

  " Skip markdown syntax highlighting because it's fubar
  autocmd! FileType mkd setlocal syn=off
augroup END

:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
imap <c-c> <esc>
" Clear the search buffer when hitting return
" :nnoremap <CR> :nohlsearch<cr>
" Double leader switches to alternate file
nnoremap <leader><leader> <c-^>

" Multipurpose tab key indents at the beginning of a line, else completes
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" Shift tab brings up a context menu
inoremap <s-tab> <c-n>

map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Mark Roghelia says uses these, you fool
let vimclojure#HighlightBuiltins = 1
let vimclojure#ParenRainbow = 1
let vimclojure#FuzzyIndent = 1
autocmd FileType clojure setlocal lispwords+=testing,mock,with-redefs,cond->

" Convert hashrockets to symbol maps
nmap <leader>rh :%s/\v:(\w+)\s*\=\>/\1: /g<cr>
