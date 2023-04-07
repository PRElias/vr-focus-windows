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


$windowName = "Assetto Corsa"  # Replace with the actual window title

Start-Sleep -Seconds 10

$process = Get-Process | Where-Object {$_.MainWindowTitle -eq $windowName}

if ($process -eq $null) {
    Write-Host "No window found with the name '$windowName'."
} else {
    $hwnd = $process.MainWindowHandle
    [void][WinAPI]::SetForegroundWindow($hwnd)
}
