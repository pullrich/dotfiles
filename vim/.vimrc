let workvimrc = expand('~/work.vimrc.vim')
if filereadable(workvimrc)
    :silent !echo "sourcing work.vimrc.vim"
    exec 'source' workvimrc
else
    :silent !echo "not sourcing work.vimrc.vim"
endif

" fileencoding for this file: utf-8
set nocompatible
set noerrorbells
"filetype off       " required by vundle??

set tabstop=4 softtabstop=4
set expandtab
set smartindent " ? check!
set smartcase " ? check!
set shiftwidth=4
set history=20  
set ruler          " Show the cursor position all the time
set number relativenumber
set showtabline=2  " Always show the tabline.
"set nohlsearch
set ignorecase

" see: https://shapeshed.com/vim-statuslines/
set laststatus=2     " Always show status line (for window)
set statusline=      " Start with a clear statusline
set statusline+=%F   " Always show the full path of the current file in the status line.
set statusline+=\    
set statusline+=\ %y " filetype eg. .txt .cob
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%  " % position in file
set statusline+=\ %l:%c " cursor line:column

set hidden         " Allow modified buffers to be hidden.
set noswapfile     " Do not create .swp files. - Use undodir and -file instead.
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nowrap

set colorcolumn=72,80,160
"colorscheme evening
" colorscheme evening does not work as expected in windows/gvim.
" in combination with the following 
"     [highlight ColorColumn ctermbg=0 guibg=LightGrey]
" line the result ist red (!!) ColorColumns instead of LightGray. 
highlight ColorColumn ctermbg=0 guibg=LightGrey

set guifont=Hack:h9
"syntax on

" Vundle

"    " For Vundle info see: https://github.com/VundleVim/Vundle.vim
"    " set the runtime path to include Vundle and initialize
"    set rtp+=~/.vim/bundle/Vundle.vim
"    call vundle#begin()
"    
"    " let Vundle manage Vundle, required
"    Plugin 'VundleVim/Vundle.vim'
"    
"    Plugin 'tpope/vim-surround'
"    Plugin 'tpope/vim-repeat'
"    
"    Plugin 'MarcWeber/vim-addon-mw-utils'
"    Plugin 'tomtom/tlib_vim'
"    Plugin 'garbas/vim-snipmate'
"    Plugin 'honza/vim-snippets'
"    
"    " All of your Plugins must be added before the following line
"    call vundle#end()            " required

" Plug
" https://github.com/junegunn/vim-plug/wiki/tips#migrating-from-other-plugin-managers
call plug#begin('~/.vim/bundle')
"Plug 'junegunn/seoul256.vim'
"Plug 'junegunn/goyo.vim'
"Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'vim-perl/vim-perl'
call plug#end()

"filetype plugin indent on
" ^- 2020-08-26: Pr�fen, ob dies Probleme mit Cobol etc. bereite. Falls ja, ersteinmal ausschalten.

let g:snips_author="Pascal Ullrich"


set listchars=eol:�,tab:��,trail:~,extends:>,precedes:<,space:�
" This is the definition when used for cobol dev. in xterm - without unicode.
"set listchars=eol:¬,tab:▸\ ,trail:~,extends:>,precedes:<,space:·
" This would be the unicode definition.

" Search and replace word under cursor using F4
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Toggle whitespace display using <F5> key.
nnoremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>
nnoremap <F6> :set filetype=cobol<CR>
inoremap <F6> <C-o>:set filetype=cobol<CR>
cnoremap <F6> <C-c>:set filetype=cobol<CR>
" todo: open file under cursor but append .cob
"vmap ,c <ESC>a--><ESC>'<i<!--<ESC>'>$
" todo: surround beginning|end of visual selection with <!--|-->
nnoremap <F9> T i"${<ESC>ea}"<ESC>
" Make word double quoted shell variable

" Adjust first non-whitespace to column 44.
let @a='/\S44i 44|dw36|j'

" g<Ctrl+o> to create a new line below the cursor (Ctrl to prevent collision with 'go' command)
"nmap g<C-O> o<ESC>k
nmap g<C-O> ojkk
" gO to create a new line above the cursor in normal mode
"nmap gO O<ESC>j
nmap gO Ojkj

inoremap <leader>" ""<ESC>i
inoremap <leader>( ()<ESC>i

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds


" Displays buffer list, prompts for buffer numbers and ranges and deletes
" associated buffers. Example input: 2 5,9 12
" Hit Enter alone to exit. 
function! InteractiveBufDelete()
    let l:prompt = "Specify buffers to delete: "

    ls | let bufnums = input(l:prompt)
    while strlen(bufnums)
        echo "\n"
        let buflist = split(bufnums)
        for bufitem in buflist
            if match(bufitem, '^\d\+,\d\+$') >= 0
                exec ':' . bufitem . 'bd'
            elseif match(bufitem, '^\d\+$') >= 0
                exec ':bd ' . bufitem
            else
                echohl ErrorMsg | echo 'Not a number or range: ' . bufitem | echohl None
            endif 
        endfor
        ls | let bufnums = input(l:prompt)
    endwhile 

endfunction

function! Saveeods()
    let eodfile = "~/vimsess/eod-session.vim"
    "exec ':mksession! ~/vimsess/eod-session.vim'
    exec ':mksession!' eodfile
    echom 'eod (end of day) session saved to ~/vimsess/eod-session.vim (HARD CODED)'
endfunction

nnoremap <silent> <leader>bd :call InteractiveBufDelete()<CR>
" Use jk as escape key in insert-mode.
inoremap jk <esc>
"inoremap kj <ESC>
inoremap <esc> <nop>

" On a german keyboard it seems more intuitive to go forward without using a
" modifier key - like with f and t.
" ';' can only be activated using shift. So switch those around.
nnoremap , ;
nnoremap ; ,
vnoremap , ;
vnoremap ; ,

command! Cvim execute ':e ~\vimfiles\vimrc'
" Open vimrc (on Windows) when running the comamnd :Cvim.
"autocmd GUIEnter * simalt ~x
" Start vim in full screen mode on Windows.

autocmd FileType cobol setlocal textwidth=72

set autoread

" Trigger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" https://stackoverflow.com/questions/36900578/correct-syntax-highlighting-on-subroutine-signatures-in-vim
let perl_sub_signatures=1
