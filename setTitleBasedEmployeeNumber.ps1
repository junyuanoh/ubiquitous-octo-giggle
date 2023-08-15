Import-Module ActiveDirectory
$csvPath = Read-Host "Enter path to input .csv"
$outputPath = Read-Host "Enter path to output .csv"
$userList = Import-Csv $csvPath

# Loop through each entry in the CSV
foreach ($user in $userList) {
    $employeeNumber = $user.employeeNumber
    $newTitle = $user.NewTitle

    # Find the user in Active Directory based on the employee number
    $adUser = Get-ADUser -Filter { employeeNumber -eq $employeeNumber }

    if ($adUser) {
        # Modify the user's Title attribute
        $adUser | Set-ADUser -Title $newTitle
        # Output the modified user information to the output CSV
        $user | Export-Csv -Append -NoTypeInformation $outputPath
        Write-Host "Title for user $($adUser.UserPrincipalName) updated to '$newTitle'"
    } else {
        Write-Host "User with employee number $employeeNumber not found in Active Directory"
    }
}

Write-Host "Script execution completed."
