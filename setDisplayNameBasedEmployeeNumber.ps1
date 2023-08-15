
####
Import-Module ActiveDirectory
$csvPath = Read-Host "Enter path to input .csv"
$outputPath = Read-Host "Enter path to output .csv"
$userList = Import-Csv $csvPath

# Loop through each entry in the CSV
foreach ($user in $userList) {
    $employeeNumber = $user.employeeNumber
    $newDisplayName = $user.NewDisplayName

    # Find the user in Active Directory based on the employee number
    $adUser = Get-ADUser -Filter { employeeNumber -eq $employeeNumber }

    if ($adUser) {
        # Modify the user's displayName attribute
        $adUser | Set-ADUser -DisplayName $newDisplayName
        # Output the modified user information to the output CSV
        $user | Export-Csv -Append -NoTypeInformation $outputPath
        Write-Host "displayName for user $($adUser.SamAccountName) updated to '$newDisplayName'"
    } else {
        Write-Host "User with employee number $employeeNumber not found in Active Directory"
    }
}

Write-Host "Script execution completed."
