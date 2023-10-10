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
