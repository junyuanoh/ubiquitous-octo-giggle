Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg 
$csvloc = Read-Host "Enter path to .csv" 
$mailbox = Read-Host "Enter common mailbox"
$users = Import-Csv $csvloc

 
foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Add-MailboxPermission -Identity $mailbox -User $upn -AccessRights FullAccess -InheritanceType All
    Set-Mailbox $mailbox -GrantSendOnBehalfTo @{add="$upn"}
    Add-RecipientPermission -Identity $mailbox -Trustee $upn -AccessRights 'SendAs' -Confirm:$false
}

Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg 
$csvloc = Read-Host "Enter path to .csv" 
$mailbox = Read-Host "Enter shared mailbox"
$users = Import-Csv $csvloc

 
foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Add-MailboxPermission -Identity $mailbox -User $upn -AccessRights FullAccess -InheritanceType All
    Add-RecipientPermission -Identity $mailbox -Trustee $upn -AccessRights 'SendAs' -Confirm:$false
}
