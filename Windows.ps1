# . .\Windows.ps1
# Move-CursorRandomly
function Move-CursorRandomly {
    # Add the necessary assembly
    Add-Type -assemblyName System.Windows.Forms

    # Define a range for the cursor position
    $a = @(1..100)

    # Continuously move the cursor to a random position every 5 seconds
    while ($true) {
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(($a | Get-Random), ($a | Get-Random))
        Start-Sleep -Seconds 5
    }
}
