
param (
    [string]$pattern,
    [string]$replace
)

# Function to recursively search and replace in files
function SearchAndReplaceInFiles {
    param (
        [string]$directory,
        [string]$pattern,
        [string]$replace
    )

    Get-ChildItem -Path $directory -File -Recurse | ForEach-Object {
        $filePath = $_.FullName
        $content = Get-Content -Path $filePath -Raw
        $modifiedContent = $content -replace $pattern, $replace
        Set-Content -Path $filePath -Value $modifiedContent
    }
}

# If both pattern and replace are empty, prompt for input
if ([string]::IsNullOrEmpty($pattern) -and [string]::IsNullOrEmpty($replace)) {
    Write-Host "Enter the pattern to search for:"
    $pattern = Read-Host

    Write-Host "Enter the replacement string:"
    $replace = Read-Host
}

# Search and replace in files
$rootDirectory = Get-Location
SearchAndReplaceInFiles -directory $rootDirectory -pattern $pattern -replace $replace

Write-Host "Search and replace completed in all files within the directory root (including subdirectories)."


