vim9script

export def Create_PS_Command(ps_version: number, noninteractive: bool): string
    var powershellcommand = ""
    var cmd = ""
    var minuscoption = ""
    var cmdoptions = " -ExecutionPolicy Bypass -NoLogo " 
    if ps_version < 6
        cmd = "powershell.exe"
        minuscoption = " -C "
    else
        cmd = "pwsh.exe"
        minuscoption = " -Command "
    endif
    if noninteractive
        powershellcommand = cmd .. cmdoptions .. " -NonInteractive " .. minuscoption
    else 
        powershellcommand = cmd .. cmdoptions .. minuscoption
    endif
    return powershellcommand
enddef

def OsSeparator(): string
    var sep = '/'
    if has('win32') || has('win64')
        sep = '\\'
    endif
    return sep
enddef 

export def PsScript_Path(pathstr: string): string
    return  pathstr .. OsSeparator() .. 'ps1' .. OsSeparator()
enddef
