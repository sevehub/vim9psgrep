" finish
if !has('vim9script') || v:version < 802
    finish
endif

vim9script

import autoload "../autoload/vim9psgrep/psgrep.vim"

var powershell_version = 5
var rgr_exe_path = ""
var rgr_exe = "rgr.exe"
var sandr = ""
var get_arg = ""
var replace_mode = 0     # 0 powershell script sandr , 1 rgr.exe

if exists('g:powershell_version')
    powershell_version = g:powershell_version
endif

if exists('g:rgr_exe_path')
    rgr_exe_path = g:rgr_exe_path
    rgr_exe = rgr_exe_path .. psgrep.OsSeparator() .. rgr_exe
endif

if executable(rgr_exe)
    replace_mode = 1
    get_arg = psgrep.Create_PS_Command(powershell_version, true) ..  psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'getargument.ps1'
    sandr = psgrep.Create_PS_Command(powershell_version, false) .. "rgr.exe" 
else
    sandr = psgrep.Create_PS_Command(powershell_version, false) ..  psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'sandr.ps1'
endif

var rg_command = psgrep.Create_PS_Command(powershell_version, true) ..  psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'rgps.ps1'
var rg_prompt =  psgrep.Create_PS_Command(powershell_version, true) .. psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'prompt_popup.ps1'
var ast_grep =  psgrep.Create_PS_Command(powershell_version, true) .. psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'ast_grep.ps1'
var notification =  psgrep.Create_PS_Command(powershell_version, true) .. psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'ShowNotification.ps1'

var ignore =  psgrep.PsScript_Path( expand('<sfile>:p:h') ) .. 'global.ignore'

# as in grep word

nnoremap <leader>gc <Cmd>close!<CR>
nnoremap <leader>gw <Cmd>Rgr<CR>
nnoremap <leader>gp <Cmd>Sprompt<CR>
nnoremap <leader>gr <Cmd>Rprompt<CR>
nnoremap <leader>ga <Cmd>AstGrep<CR>
command! -narg=0 AstGrep AstGrep() 
command! -narg=0 Rgr Run_rg() 
command! -narg=0 Sprompt Prompt_popup() 
command! -narg=0 Rprompt Rprompt()
command! -narg=0 DotIgnore DotIgnore()
command! -narg=0 TermClose TermClose()
# autocmd TermOpen * nnoremap <buffer> <C-c> :call TermClose()<CR>
# TODO visual selection
var  quickfixlist = []  
var  cword = ""


def DotIgnore(): void
    execute 'new ' .. ignore
enddef

def TermClose(): void
var terms = term_list()
  for term in terms
    call job_stop(term_getjob(term))
  endfor
enddef


# open a prompt for query 
def Prompt_popup(): void
    quickfixlist =  systemlist(rg_prompt)
    if quickfixlist->len() > 0
        call setqflist([], ' ', {'title': '', 'lines': quickfixlist })
        copen
    else
      silent system(notification .. " -CustomMessage 'Oops! The specified pattern was not found.'")
    endif
enddef

def AstGrep(): void
    quickfixlist =  systemlist(ast_grep)
    if quickfixlist->len() > 0
        call setqflist([], ' ', {'title': '', 'lines': quickfixlist })
        copen
    else
         silent system(notification .. " -CustomMessage 'Oops! The specified pattern was not found.'")
    endif
enddef

def Rprompt(): void
   var search_arg = []
   var opts = {}
   var cmd_replace = ""
   cword = expand('<cword>') 
   if replace_mode == 1
       if cword->len() > 0
           cmd_replace = sandr .. " " .. cword
       else
           search_arg = systemlist(get_arg)
           if (search_arg->len() > 0) && (search_arg[0] != "")
               cmd_replace = sandr .. " " .. search_arg[0]
           else
               return
           endif
       endif
    else
        cmd_replace = sandr
    endif 


   if replace_mode == 1
    opts = {
        "term_finish": "close",
        "term_rows": 80,
    }
   else
    opts = {
        "term_finish": "close",
        "term_rows": 10,
    }
   endif
   silent term_start(cmd_replace, opts)
enddef

def Run_rg(): void

    cword = expand('<cword>') 

    echo 'Searching files for pattern: ' .. rg_command .. ' -pattern "' .. cword .. '"'
    
    quickfixlist =  systemlist(rg_command .. ' -pattern "' .. cword .. '"')
    if quickfixlist->len() > 0
        call setqflist([], ' ', {'title': expand('<cword>') ..  ' found in:', 'lines': quickfixlist })
        copen
    else
        silent system(notification .. " -CustomMessage 'Oops! " .. cword .. " was not found.'")
    endif
enddef
