set nocompatible

"run local .vimrcs
set exrc
set secure

"map the leader key to komma
let mapleader = ","

"enable pathogen
execute pathogen#infect()
filetype plugin indent on

"allow differences for file types
filetype plugin on
filetype on

"avoid having to save every time I want to switch buffers
set hidden

"enable the :w!! command to save files using root access
cmap w!! w !sudo tee > /dev/null %

"eye candy
syntax on
"set background=dark
"colorscheme solarized
highlight CursorLine cterm=standout "highlight the current line

"redraw the screen and remove search highlighting
nnoremap <silent> <Leader>c :nohl<CR><C-l>

"repeat for each line in selection with .
vnoremap . :normal .<CR>

"file related stuff
noremap <Leader>e :hide edit 
noremap <Leader>f :hide find 
noremap <Leader>b :b 

"debugging
noremap <Leader>p :cprev<CR>
noremap <Leader>n :cnext<CR>
noremap <Leader>c :cclose<CR>
noremap <Leader>o :copen<CR>

"display line numbers
set number
set cursorline "show current cursor line

"don't wrap words
set tw=0

"toggle relative numbers with ,l
noremap <Leader>l :set relativenumber!<CR>

"save quicker
noremap <Leader>w :w<CR>

"make quicker
noremap <Leader>m :call LoadLocalVimrc()<CR>:make<CR><CR>
noremap <Leader>r :call LoadLocalVimrc()<CR>:make run<CR><CR>

function g:LoadLocalVimrc()
    if filereadable($PWD . "/.vimrc")
        source $PWD/.vimrc
    endif
endfunction

let g:netrw_banner=0
let g:netrw_liststyle=3

"be able to search case insensitive, unless capital letters are used
set ignorecase
set smartcase

"nicer linewrap
set linebreak

"nicer search
set incsearch

"search into subfolders
set path=,,**

"display all files in tab complete
set wildmenu

"use 4 tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab "use soft tabs

"auto indent new lines to last lines indent
set autoindent

" file is large from 7mb
let g:LargeFile = 1024 * 1024 * 7
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

"<++> is used as a marker to jump to
nnoremap <Enter> <Esc>/<++><Enter>"_4s

"RUST SPECIFIC

"a macro for generating a function in rust
autocmd FileType rust inoremap ;fn fn<Space><++>(<++>)<Space><++>{<Esc>o}<Esc>O<++><Esc>kI

"a macro for generating a for loop in rust
autocmd FileType rust inoremap ;for for<Space><Space>in<Space><++><Space>{<Esc>o}<Esc>O<++><Esc>k$2bhi

"a macro for generating an if in rust
autocmd FileType rust inoremap ;if if<Space><Space>{<Esc>o}<Esc>O<++><Esc>k$hi

"RUST SPECIFIC END

"STUDENT GRADING SPECIFIC
autocmd FileType comments.txt nnoremap ;a10 IA1:<Space>0P.<Esc>
autocmd FileType comments.txt nnoremap ;a11 IA1:<Space>1P.<Esc>
autocmd FileType comments.txt nnoremap ;a12 IA1:<Space>2P.<Esc>
autocmd FileType comments.txt nnoremap ;a13 IA1:<Space>3P.<Esc>
autocmd FileType comments.txt nnoremap ;a20 IA2:<Space>0P.<Esc>
autocmd FileType comments.txt nnoremap ;a21 IA2:<Space>1P.<Esc>
autocmd FileType comments.txt nnoremap ;a22 IA2:<Space>2P.<Esc>
autocmd FileType comments.txt nnoremap ;a23 IA2:<Space>3P.<Esc>
"STUDENT GRADING SPECIFIC END

"LATEX SPECIFC


"LATEX SPECIFC END
