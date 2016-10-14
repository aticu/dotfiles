"map the leader key to komma
let mapleader = ","

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
map <Leader>p :tabp<CR>
map <Leader>n :tabn<CR>
map <Leader>e :tabe 

"display line numbers
set number
set cursorline "show current cursor line

"don't wrap words
set tw=0

"toggle relative numbers with ,r
map <Leader>r :set relativenumber!<CR>
"default to relative numbers
set relativenumber

"be able to search case insensitive, unless capital letters are used
set ignorecase
set smartcase

"nicer linewrap
set linebreak

"nicer search
set incsearch

"better pasting of other files
set paste

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
