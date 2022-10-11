" Add Lua configuration
source $HOME/.config/nvim/init.lua.vim

" All settings in LUA except these initial setup ginit settings...for now

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

" Auto update packager if we change the config file
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <init.lua> | PackerCompile
augroup end
