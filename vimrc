"enable syntax highlighting
syntax on

"redraw the screen and remove search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>

"display line numbers
set number

"don't wrap words
set tw=0

"be able to search case insensitive, unless capital letters are used
set ignorecase
set smartcase

"nicer linewrap
set linebreak

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
