# Load the Microsoft.VisualBasic assembly
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

# Prompt the user for input
$title = 'Search'
$msg = 'Enter Pattern:'
$pattern = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)

# Ensure ripgrep is installed and accessible
if (-not(Get-Command "rg" -ErrorAction SilentlyContinue)) {
    Write-Error "ripgrep (rg) is not installed or not in PATH."
    exit 1
}

# If the user clicks Cancel, a zero-length string is returned.
if ($pattern.Length -ne 0){
    $rgOutput = rg --column --line-number --no-heading --color never ${pattern} -g "!node_modules/" -g "!\.git/" .
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
