Set-ExecutionPolicy Bypass -Scope Process -Force;

Add-Type @"
    using System;
    using System.Runtime.InteropServices;

    public class WinAPI
    {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SetForegroundWindow(IntPtr hWnd);
    }
"@

# Open the Start menu
[void] [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
[Microsoft.VisualBasic.Interaction]::AppActivate("Start")

# Wait for the Start menu to open
Start-Sleep -Seconds 2

# Close the Start menu
[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
[System.Windows.Forms.SendKeys]::SendWait("{ESC}")


$windowName = "Assetto Corsa"  # Replace with the actual window title

Start-Sleep -Seconds 2

$process = Get-Process | Where-Object {$_.MainWindowTitle -eq $windowName}

if ($process -eq $null) {
    Write-Host "No window found with the name '$windowName'."
} else {
    $hwnd = $process.MainWindowHandle
    [void][WinAPI]::SetForegroundWindow($hwnd)
}
