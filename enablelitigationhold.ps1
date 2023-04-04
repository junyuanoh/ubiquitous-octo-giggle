#enable online archive for user + enable litigation hold + set 3 year retention policy (online archive)
Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg
$upn = Read-Host "Enter UPN" 
Enable-Mailbox -Identity $upn -Archive
Enable-Mailbox $upn -AutoExpandingArchive
Set-Mailbox $upn -LitigationHoldEnabled $true
Set-Mailbox $upn -RetentionPolicy "Retention Policy_OnlineArchive"
Get-Mailbox -Identity $upn | FL UserPrincipalName, LitigationHoldEnabled, AutoExpandingArchiveEnabled, ArchiveStatus, RetentionPolicy

#get list of litigation hold
Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg
$csvloc1 = Read-Host "Enter path to .csv (remove quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2 
foreach($user in $users) {
    $upn = $user.UserPrincipalName
    Get-Mailbox -Identity $upn | FL UserPrincipalName, LitigationHoldEnabled
}

Adeline_TanSN@countryfoods.com