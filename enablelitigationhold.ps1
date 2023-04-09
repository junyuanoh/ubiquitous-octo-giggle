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

#get litigation hold and export
Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg
$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-Mailbox -Identity $upn | Select-Object UserPrincipalName, LitigationHoldEnabled | Export-Csv -Path "\\Mac\Home\Desktop\TestCSV\litigationhold_09-04.csv" -NoTypeInformation -Append
}

#set litigation hold only
Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg
$csvloc1 = Read-Host "Enter path to .csv (remove quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2 
foreach($user in $users) {
    $upn = $user.UserPrincipalName
    Set-Mailbox $upn -LitigationHoldEnabled $true
    Get-Mailbox -Identity $upn | FL UserPrincipalName, LitigationHoldEnabled
}

