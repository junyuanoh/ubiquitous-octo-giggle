Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = "C:\Users\satsaa_adsupport01\Desktop\manager_08-11-2023.csv"
$userList = Import-Csv $csvPath

$output = @()
foreach ($user in $userList) {
    $var = Get-ADUser -identity $user.SamAccountName -Properties Manager -ErrorAction SilentlyContinue
    if ($var -ne $null){
        $manager = Get-ADUser -identity $var.manager -Properties *
    }
    if ($manager -ne $null) {
        $output += [PSCustomObject] @{
            AccountName       = $user.SamAccountName
            Manager_SAN       = $manager.SamAccountName
            Manager_UPN       = $manager.UserPrincipalName
            Manager_Email     = $manager.EmailAddress
        }
    }
}
$output | Export-Csv $outputPath -NoTypeInformation
