" Vim compiler file
" Compiler:             rgps to use with dispatch
" Maintainer:           @seve_py
" Latest Revision:      2023-03-16
if exists('current_compiler')
  finish
endif
let current_compiler = 'rgps'

if exists(':CompilerSet') != 2              " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

"                    path to rgps.ps1       
CompilerSet makeprg=C:\\Users\\Seve\\bin\\rgps.ps1 -pattern 

CompilerSet errorformat=%f:%l:%c:%m
