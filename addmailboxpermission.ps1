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

##

Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg 
$csvloc = Read-Host "Enter path to .csv" 
$Groups = Import-Csv $csvloc

# for each row in CSV...
foreach ($User in $Groups) {
    # assign the column GroupName as the commonmailbox $mailbox
    $mailbox = $User.GroupName
    # assign an array to this variable $listofusers
    $listofusers = @(
        $User.Member1,
        $User.Member2,
        $User.Member3,
        $User.Member4,
        $User.Member5
    )
    # for each row in list $listofuser...
    foreach ($member in $listofusers) {
        if ($member -ne $null -and $member -ne "") {
            Add-MailboxPermission -Identity $mailbox -User $member -AccessRights FullAccess -InheritanceType All
            Set-Mailbox $mailbox -GrantSendOnBehalfTo @{add="$member"}
            Add-RecipientPermission -Identity $mailbox -Trustee $member -AccessRights 'SendAs' -Confirm:$false
        }
        else {
            Write-Host "Skipping empty member in array"
        }
    }
}


