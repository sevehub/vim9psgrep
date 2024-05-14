" finish
if !has('vim9script') || v:version < 802
    finish
endif

vim9script

import autoload "../autoload/vim9psgrep/psgrep.vim"

var powershell_version = 5

if exists('g:powershell_version')
    powershell_version = g:powershell_version
endif

var sandr = psgrep.Create_PS_Command(powershell_version, false) ..  psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'sandr.ps1'
var rg_command = psgrep.Create_PS_Command(powershell_version, true) ..  psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'rgps.ps1'
var rg_prompt =  psgrep.Create_PS_Command(powershell_version, true) .. psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'prompt_popup.ps1'
var notification =  psgrep.Create_PS_Command(powershell_version, true) .. psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'ShowNotification.ps1'
var ignore =  psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'global.ignore'

# as in grep word
nnoremap <leader>gw <Cmd>Rgr<CR>
nnoremap <leader>gp <Cmd>Sprompt<CR>
nnoremap <leader>gr <Cmd>Rprompt<CR>
command! -narg=0 Rgr Run_rg() 
command! -narg=0 Sprompt Prompt_popup() 
command! -narg=0 Rprompt Rprompt()
command! -narg=0 DotIgnore DotIgnore()
# TODO visual selection
var  quickfixlist = []  
var  cword = ""


def DotIgnore(): void
    execute 'new ' .. ignore
enddef

# open a prompt for query 
def Prompt_popup(): void
    quickfixlist =  systemlist(rg_prompt)
    if quickfixlist->len() > 0
        call setqflist([], ' ', {'title': '', 'lines': quickfixlist })
        copen
    else
        system(notification .. " -CustomMessage 'Oops! The specified pattern was not found.'")
    endif
enddef

def Rprompt(): void
   cword = expand('<cword>') 
   # TODO set pattern from cword
   if cword->len() > 0
    # echo cword
   else
   endif

    const opts = {
        "term_finish": "close",
        "term_rows": 7
    }

   term_start(sandr, opts)
enddef

def Run_rg(): void

    cword = expand('<cword>') 

    echo 'Searching files for pattern: ' .. rg_command .. ' -pattern "' .. cword .. '"'
    
    quickfixlist =  systemlist(rg_command .. ' -pattern "' .. cword .. '"')
    if quickfixlist->len() > 0
        call setqflist([], ' ', {'title': expand('<cword>') ..  ' found in:', 'lines': quickfixlist })
        copen
    else
        system(notification .. " -CustomMessage 'Oops! " .. cword .. " was not found.'")
    endif
enddef
