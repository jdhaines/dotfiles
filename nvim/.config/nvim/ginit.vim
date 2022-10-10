let s:fontsize = 12
"execute "GuiFont! Input:h"    . s:fontsize
"execute "GuiFont! Hack:h"     . s:fontsize
"execute "GuiFont! Consolas:h" . s:fontsize
execute "GuiFont! Jetbrains Mono:h" . s:fontsize
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  " :execute "GuiFont! Consolas:h" . s:fontsize
  " :execute "GuiFont! Input:h"    . s:fontsize
  " :execute "GuiFont! Hack:h"     . s:fontsize
  :execute "GuiFont! Jetbrains Mono:h"     . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
GuiPopupmenu 0