Connect-SPOService -Url https://sats1-admin.sharepoint.com

$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$sitename = Read-Host "Enter SPO URL"
$sitegroup = Read-Host "Enter site group (owner/member/visitor)"

foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Add-SPOUser -Site $sitename -LoginName $upn -Group $sitegroup
}

Get-SPOSiteGroup -Site $sitename | Format-List 