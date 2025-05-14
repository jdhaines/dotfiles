" The following are required before installation:
" - git
" - python 3
"
" Consider these Plugins later:
" - Goyo
" - Limelight
" Install locations:
"   Windows:
"       %LOCALAPPDATA%\nvim\init.vim
"
"   Linux:
"       ~/.config/nvim/init.vim

" ==============================================================================
" Environment Settings

" ==============================================================================
" GUI Settings

" This section holds GUI settings. After updating these settings
" WriteGUISettings must be called to apply the settings.

let s:ginit_path = expand('~/.config/nvim/ginit.vim')

" Lines of GUI settings file.
let s:ginit = [
    \ 'let s:fontsize = 12',
    \ '"execute "GuiFont! Input:h"    . s:fontsize',
    \ '"execute "GuiFont! Hack:h"     . s:fontsize',
    \ '"execute "GuiFont! Consolas:h" . s:fontsize',
    \ 'execute "GuiFont! Jetbrains Mono:h" . s:fontsize',
    \ 'function! AdjustFontSize(amount)',
    \ '  let s:fontsize = s:fontsize+a:amount',
    \ '  " :execute "GuiFont! Consolas:h" . s:fontsize',
    \ '  " :execute "GuiFont! Input:h"    . s:fontsize',
    \ '  " :execute "GuiFont! Hack:h"     . s:fontsize',
    \ '  :execute "GuiFont! Jetbrains Mono:h"     . s:fontsize',
    \ 'endfunction',
    \ '',
    \ 'noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>',
    \ 'noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>',
    \ 'inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a',
    \ 'inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a',
    \ 'GuiPopupmenu 0'
\ ]

function WriteGUISettings()
    call writefile(s:ginit, s:ginit_path, 'b')

    echo 'Gui restart required.'
endfunction

if empty(glob(s:ginit_path))
    call WriteGUISettings()
endif
" Clear search highlighting on esc key press
nnoremap <esc> :noh<return><esc>
" ==============================================================================
" Vim Plug Installation

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ==============================================================================
" Python Provider

let g:pip = 'pip3'

" Disable python 2 since it has been end of lifed.
let g:loaded_python_provider = 1

" ==============================================================================
" Plugins

call plug#begin('~/.local/share/nvim/plugged')

Plug 'joshdick/onedark.vim'
"Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-commentary'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'mechatroner/rainbow_csv'
Plug 'nestorsalceda/vim-strip-trailing-whitespaces'
Plug 'brooth/far.vim'
Plug 'airblade/vim-rooter'
"Plug 'tpope/vim-fugitive'


" NERDTree --------------------------------------------------------------------------
"
Plug 'scrooloose/nerdtree'
" cd C:/Users/u1019077/Documents/git/
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <F3> :NERDTreeToggle<CR>
" open Nerd Tree in folder of file in active buffer
map <Leader>nt :NERDTree %:p:h<CR>
let g:NERDTreeWinSize=60
let NERDTreeShowHidden=1

" vim-indent-guides ------------------------------------------------------------
Plug 'lukas-reineke/indent-blankline.nvim'

lua <<EOF
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

EOF

" vim-indent-guides ------------------------------------------------------------
":Plug 'nathanaelkane/vim-indent-guides'

":let g:indent_guides_enable_on_vim_startup = 1
":let g:indent_guides_auto_colors = 1

":autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#32332b ctermbg=3
":autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#272822 ctermbg=4

" lightline --------------------------------------------------------------------
Plug 'itchyny/lightline.vim'
let g:lightline = {
    \ 'colorscheme': 'ayu_dark',
\ }

" vim-illuminate ----------------------------------------------------------------
Plug 'RRethy/vim-illuminate'
autocmd VimEnter * :hi illuminatedWord cterm=underline gui=underline

" deoplete ---------------------------------------------------------------------
" ==============================================================================
" Environment Settings

if has('win32')
    " Ensure that $HOME points to $USERPROFILE
    " let $HOME = $USERPROFILE

    " Set CMD as the windows shell.
    set shell=$COMSPEC
endif

" CtrlP ------------------------------------------------------------------------
Plug 'ctrlpvim/ctrlp.vim'

if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif
call plug#end()

let g:ctrlp_show_hidden=1
let g:ctrlp_match_current_file=1
" ==============================================================================
" Indent

" Visual spaces per tab
set tabstop=4

" Spaces per tab while editing
set softtabstop=4

" Autoindent spaces
set shiftwidth=4

" Use spaces instead of tabs
set expandtab

" ==============================================================================
" Gutter

" Setup width rulers
set colorcolumn=81

" Highlight everything that goes beyond 80 characters
call matchadd('ColorColumn', '\%>81v.\+', 100)

" Setup line numbers to show absolute number for current line, and relative
" for everything else.
set number relativenumber

" ==============================================================================
" Bindings

" Make ctrl + backspace delete previous word.
nnoremap <C-BS> <C-W>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Left> :vertical resize -5<CR>

" Move whole lines up and down with the arrow keys
nnoremap <Down> ddp
nnoremap <Up> ddkP

" Move whole lines or visually selected blocks up and down with alt J or alt K
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" Select the entire document just like normal Ctrl+A
nnoremap <C-a> <esc>ggVG<CR>

" Copy text to system clipboard like normal Ctrl+C
vnoremap <C-c> "+y

" Allow jj to work like the esc key
inoremap jj <Esc>

" Auto save code folds between sessions
augroup AutoSaveGroup
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  " BufHidden for compatibility with `set hidden`
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end
" ==============================================================================
" Editor

" Ensure there is always at least 10 lines around the cursor.
set scrolloff=10

" Highlight the cursor line
set cursorline

" Make delete previous word always work.
set backspace=indent,eol,start

" Make command mode tab completion and search to be case insensitive.
" Search can be made case sensitive by prefixing with \C
" set ignorecase

" ==============================================================================
" Theme

colorscheme onedark

" ==============================================================================
