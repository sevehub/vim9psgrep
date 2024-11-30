# Load the Microsoft.VisualBasic assembly

# $OutputEncoding = [System.Text.Encoding]::UTF8
# $PSDefaultParameterValues['Out-File:Encoding'] = 'ascii'


[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
# PowerShell script to show a popup asking for an argument Add-Type -AssemblyName Microsoft.VisualBasic 
$input = [Microsoft.VisualBasic.Interaction]::InputBox("Please enter an argument:", "Input Required", "")
return $input
