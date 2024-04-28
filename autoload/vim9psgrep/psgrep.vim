
vim9script


def OsSaparator(): string
    var sep = '/'
    if has('win32') || has('win64')
        sep = '\\'
    endif
    return sep
enddef 

export def PsScript_Path(pathstr: string): string
    return  pathstr .. OsSaparator() .. 'ps1' .. OsSaparator()
enddef
