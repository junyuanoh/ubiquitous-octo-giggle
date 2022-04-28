$NPS = Get-Content "\\Mac\Home\Desktop\DisableEOPowershell\NoPowerShell.txt"
$NPS | foreach {Set-User -Identity $_ -RemotePowerShellEnabled $false}