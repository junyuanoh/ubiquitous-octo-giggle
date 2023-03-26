#enable online archive for user + enable litigation hold + set 3 year retention policy (online archive)
Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg
$upn = Read-Host "Enter UPN" 
Enable-Mailbox -Identity $upn -Archive
Enable-Mailbox $upn -AutoExpandingArchive
Set-Mailbox $upn -LitigationHoldEnabled $true
Set-Mailbox $upn -RetentionPolicy "Retention Policy_OnlineArchive"
Get-Mailbox -Identity $upn | FL UserPrincipalName, LitigationHoldEnabled, AutoExpandingArchiveEnabled, ArchiveStatus, RetentionPolicy