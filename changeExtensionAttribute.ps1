Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = Read-Host "Enter path to output .csv" 
$userData = Import-Csv $csvPath
$extattriA = Read-Host "Modify extension attribute number (1 through 15)"
$extattriB = -join("extensionAttribute",$extattriA) 

# Loop through each user in the CSV file
foreach ($user in $userData) {
    $samAccountName = $user.SAMAccountName
    $extensionAttributeValue = $user.extensionAttributeVar

    # Set the $extattriB on the user profile
    Set-ADUser -Identity $samAccountName -Replace @{$extattriB = $extensionAttributeValue}

    # Retrieve the updated user profile
    $updatedUser = Get-ADUser -Identity $samAccountName -Properties * | Select-Object $extattriB
    
    # Display the updated user details
    Write-Host "`n"
    Write-Host "Updated user profile for: $samAccountName"
    Write-Host "Attribute '$extattriB' modified: $($updatedUser.$extattriB)"
    Write-Host "-----------------------------"
}

# Export the updated user details to a CSV file
$updatedUserData = foreach ($user in $userData) {
    $samAccountName = $user.SAMAccountName
    $updatedUser = Get-ADUser -Identity $samAccountName -Properties * | Select-Object $extattriB

    [PSCustomObject]@{
        SAMAccountName = $samAccountName
        Modified_extensionAttribute15 = $updatedUser.$extattriB
    }
}

$updatedUserData | Export-Csv -Path $outputPath -NoTypeInformation