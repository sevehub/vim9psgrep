# rgps.ps1
#
# usage: .\rgps.ps1 -pattern "your_regex_pattern_here"
param(
    [string]$pattern
)

# Ensure ripgrep is installed and accessible
if (-not(Get-Command "rg" -ErrorAction SilentlyContinue)) {
    Write-Error "ripgrep (rg) is not installed or not in PATH."
    exit 1
}

# TODO Exclusion files and folders
# Search for the pattern using ripgrep
$Exclude = "-g '*'"
           # -g '!\.bzr/'  
           #-g '!\.git/' 
           #-g '!\.hg/' 
           #-g '!\.mypy_cache/' 
           #-g '!\.pytest_cache/' 
           #-g '!\.ruff_cache/' 
           #-g '!\.svn/' 
           #-g '!\.testrepository/' 
           #-g '!\.tox/' 
           #-g '!*\.egg-info/' 
           #-g '!__pycache__/' 
           #-g '!node_modules/' -g '!build/' 
           #-g '!dist/' 
           #-g '!env/' 
           #-g '!.venv/' .`
$rgOutput = rg --column --line-number --no-heading --color never $pattern -g '*' .

# Process the output to match the desired format
$rgOutput | ForEach-Object {
    $splitLine = $_ -split ':'
    $filePath = $splitLine[0]
    $line = $splitLine[1]
    $column = $splitLine[2]
    $textLine = $splitLine[3]
    # Correctly format the output
    "${filePath}:$($line):$($column):${textLine}"
}
