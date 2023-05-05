#source: https://office365itpros.com/2023/03/02/mail-contacts-vs-guest-accounts/amp/

Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg 
$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
 
foreach($user in $users) {
    $name = $user.Name
    $email = $user.Email
    New-MailContact -Name $name -DisplayName $name -ExternalEmailAddress $email
}