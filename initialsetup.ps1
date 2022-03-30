Write-Host "Starting..."
Install-Module AzureAD -Scope CurrentUser;
Install-Module -Name MSOnline -Scope CurrentUser;
Get-InstalledModule