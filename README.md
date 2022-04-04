# ubiquitous-octo-giggle
Exchange Online Commands

## Initial Setup 

### Installing Exchange Online PowerShell Module V2 (EXO V2)

Run this code in PowerShell.

`
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/junyuanoh/ubiquitous-octo-giggle/main/initialsetup.ps1
Invoke-Expression $($ScriptFromGitHub.Content)
`

Now that EXO V2 is installed, you can open a session with the following command: 

`
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName $userUPN
`




