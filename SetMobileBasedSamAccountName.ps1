### Set based on samaccountname

## =IF(LEFT(A1, 2)="65", MID(A1, 3, LEN(A1)), A1)


Import-Module ActiveDirectory
$csvPath = Read-Host "Enter path to input .csv"
$outputPath = Read-Host "Enter path to output .csv"
$userList = Import-Csv $csvPath

# Loop through each entry in the CSV
foreach ($user in $userList) {
    $samAccountName = $user.samAccountName
    $newMobile = $user.newMobile

    # Find the user in Active Directory based on the samaccountname
    $adUser = Get-ADUser -Filter { samAccountName -eq $samAccountName }

    if ($adUser) {
        $adUser | Set-ADUser -Mobile $newMobile
        # Output the modified user information to the output CSV
        $user | Export-Csv -Append -NoTypeInformation $outputPath
        Write-Host "Mobile for user $($adUser.UserPrincipalName) updated to '$newMobile'"
    } else {
        Write-Host "User $samAccountName not found in Active Directory"
    }
}

Write-Host "Script execution completed."
