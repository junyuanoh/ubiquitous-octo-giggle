Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
Write-Host "`nDisables remotePS for a list of user in a .txt file. The text file must contain one account on each line as follows:`nakol@contoso.com`ntjohnston@contoso.com`nkakers@contoso.com`n`n"
$location = Read-Host "Enter .txt file location"
$lines = Get-Content -Path "$location"
$NPS = Get-Content "$location"
$NPS | ForEach-Object {Set-User -Identity $_ -RemotePowerShellEnabled $false}
$NPS | ForEach-Object {Get-User -Identity $_ | Format-List RemotePowerShellEnabled}
Write-Host "Completed`nRemote PS disabled for $($lines.Count) users."
