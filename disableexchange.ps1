$NPS = Get-Content "\\Mac\Home\Desktop\PSScriptCSVs\NoPowerShell.txt"
$NPS | foreach {Set-User -Identity $_ -RemotePowerShellEnabled $false}