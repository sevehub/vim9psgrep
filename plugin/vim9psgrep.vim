" finish
if !has('vim9script') || v:version < 802
    finish
endif

vim9script

import autoload "../autoload/vim9psgrep/psgrep.vim"


# set of excludes for grep  https://github.com/tartley/dotfiles/blob/main/bin/grp
# check if ps core installed
if executable('pwsh.exe') 
        set shell=pwsh.exe
        set shellcmdflag=-C
        set shellxquote="
        set shellpipe=>%s\ 2>&1
        set shellredir=>%s\ 2>&1
# vim support for powershell desktop isn't perfect 
elseif executable('powershell.exe')
        set shell=powershell.exe
        set shellcmdflag=-Command
        # must be empty !
        set shellxquote=   
        set shellpipe=>%s\ 2>&1
        set shellredir=>%s\ 2>&1
else
    finish
endif 

var rg_command = psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'rgps.ps1'
var rg_prompt = psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'prompt_popup.ps1'

# as in grep word
nnoremap <leader>gw <Cmd>Rgr<CR>
nnoremap <leader>gp <Cmd>Sprompt<CR>
command! -narg=0 Rgr Run_rg() | copen
command! -narg=0 Sprompt Prompt_popup() | copen

# TODO visual selection

# open a prompt for query 
def Prompt_popup(): void
       
    call setqflist([], ' ', {'title': '', 'lines': systemlist(rg_prompt)})
   
enddef

def Run_rg(): void
    echom 'searching files for pattern: ' .. rg_command .. ' -pattern "' .. expand('<cword>') .. '"'

    call setqflist([], ' ', {'title': expand('<cword>') ..  ' found in:', 'lines': systemlist(rg_command .. ' -pattern "' .. expand('<cword>') .. '"')})

enddef
