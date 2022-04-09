Import-Module MSOnline
Connect-MsolService -Credential $Credential
Set-MsolUserLicense -UserPrincipalName "davidchew@contoso.com" -AddLicenses "Contoso:ENTERPRISEPACK"