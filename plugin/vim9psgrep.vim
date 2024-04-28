
if !has('vim9script') || v:version < 802
    finish
endif

vim9script

import autoload "../autoload/vim9psgrep/psgrep.vim"

var rg_command = psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'rgps.ps1'


command! -narg=0 Rgr Run_rg() | copen
#
def Run_rg(): void
    echom 'searching for pattern: ' .. rg_command .. ' -pattern "' .. expand('<cword>') .. '"'

    call setqflist([], ' ', {'lines': systemlist(rg_command .. ' -pattern "' .. expand('<cword>') .. '"')})

    augroup rgquickfix
        autocmd!
        autocmd QuickFixCmdPost [^l]* cwindow
        autocmd QuickFixCmdPost l*    lwindow
    augroup END
enddef
