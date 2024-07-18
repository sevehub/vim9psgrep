# Load the Microsoft.VisualBasic assembly

# $OutputEncoding = [System.Text.Encoding]::UTF8
# $PSDefaultParameterValues['Out-File:Encoding'] = 'ascii'


[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

# Prompt the user for input
$title = 'Search'
$msg = 'Enter Pattern:'
$pattern = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)

# Ensure ast-grep is installed and accessible
# TODO should be sg on linux
if (-not(Get-Command "ast-grep" -ErrorAction SilentlyContinue)) {
    Write-Error "Ast-grep (sg) is not installed or not in PATH."
    exit 1
}

# If the user clicks Cancel, a zero-length string is returned.
if ($pattern.Length -ne 0){
    $rgOutput = ast-grep -p ${pattern}  .
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
} else 
{}
