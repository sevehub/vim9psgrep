param (
    [string]$CustomMessage
)

# Load the Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a NotifyIcon (toast notification)
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$balmsg.Icon = [System.Drawing.SystemIcons]::Information
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
$balmsg.BalloonTipTitle = "Nothing Found"
$balmsg.BalloonTipText = $CustomMessage
$balmsg.Visible = $true

# Show the notification for 4 seconds
$balmsg.ShowBalloonTip(4000)

# Wait for a few seconds (adjust as needed)
Start-Sleep -Seconds 5

# Hide the notification
$balmsg.Visible = $fals


