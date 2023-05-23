# Define the input file path and group name
$csvFilePath = "C:\Users\satsaa_ad12\Desktop\generaluse_samAccountName.csv"
$groupName = "MFA_Enable_Group"

# Import the samAccountNames from the input file
$users = Import-Csv $csvFilePath | Select-Object -ExpandProperty samAccountName

# Get the group outside the loop
$group = Get-ADGroup $groupName

# Create an array to store the results
$results = @()

# Iterate through each user and add them to the group if not already a member
foreach ($user in $users) {
    # Check if the user is already a member of the group
    if (Get-ADGroupMember -Identity $group -Recursive | Where-Object { $_.samAccountName -eq $user }) {
        $result = [PSCustomObject]@{
            samAccountName = $user
            Added = $false
        }
    }
    else {
        # Add the user to the group
        Add-ADGroupMember -Identity $group -Members $user -Confirm:$false
        $result = [PSCustomObject]@{
            samAccountName = $user
            Added = $true
        }
    }

    # Add the result to the results array
    $results += $result

    # Write the result to the console
    Write-Host "$user - $($result.Added)"
}

# Export the results to a .csv file
$results | Export-Csv -Path "C:\Users\satsaa_ad12\Desktop\mfa_enable_users_01.csv" -NoTypeInformation

###

# Define the input file path, group name, and result export path
$csvFilePath = "C:\Users\satsaa_ad12\Desktop\generaluse_samAccountName.csv"
$groupName = "MFA_Enable_Group"
$resultFilePath = "C:\Users\satsaa_ad12\Desktop\mfa_enable_users_02.csv"

# Import the samAccountNames from the input file
$users = Import-Csv $csvFilePath

# Get the group
$group = Get-ADGroup $groupName

# Create an array to store the results
$results = @()

# Iterate through each user and add them to the group if not already a member
foreach ($user in $users) {
    $result = [PSCustomObject]@{
        samAccountName = $user.samAccountName
        Action = ""
    }

    # Check if the user is already a member of the group
    if (Get-ADGroupMember -Identity $group -Recursive | Where-Object { $_.samAccountName -eq $user }) {
        $result.Action = "Skipped (Already a member of the group)"
    }
    else {
        try {
            # Add the user to the group
            Add-ADGroupMember -Identity $group -Members $user -ErrorAction Stop
            $result.Action = "Added to the group"
        }
        catch {
            $result.Action = "Failed to add to the group"
        }
    }

    # Add the result to the results array
    $results += $result

    # Write the result to the console
    Write-Host "$($result.samAccountName) - $($result.Action)"
}

# Export the results to a CSV file
$results | Export-Csv -Path $resultFilePath -NoTypeInformation

###

# Define the input CSV file path and group name
$csvFilePath = "C:\Users\satsaa_ad12\Desktop\generaluse_samAccountName.csv"
$groupName = "MFA_Enable_Group"

# Import the samAccountNames from the input CSV file
$users = Import-Csv $csvFilePath | Select-Object -ExpandProperty samAccountName

# Get the group object
$group = Get-ADGroup $groupName

# Iterate through each user and add them to the group if not already a member
foreach ($user in $users) {
    # Check if the user is already a member of the group
    if (Get-ADGroupMember -Identity $group -Recursive | Where-Object { $_.samAccountName -eq $user }) {
        Write-Host "User $user is already a member of the group. Skipping..."
    }
    else {
        # Add the user to the group
        Add-ADGroupMember -Identity $group -Members $user
        Write-Host "User $user added to the group."
    }
}


###

Import-Module ActiveDirectory

$csvFilePath = 
$groupName = ""

$groupName = "MFA_Enable_Group"
$csvloc = "C:\Users\satsaa_ad12\Desktop\generaluse_samAccountName.csv"

Import-Csv $csvloc | ForEach-Object {
    $UserPrincipalName = $_."UserPrincipalName"
    if (Get-ADUser -F {SamAccountName -eq $UserPrincipalName}){
        Add-ADGroupMember -Identity $groupName -Members $UserPrincipalName -Confirm:$false
        Write-Host "User $UserPrincipalName added to the group."
    }
    else{
        Write-Host $UserPrincipalName "does not exist. Please check user details." "`n `n `n"
    }
}

###

# Define the input file path and group name
$csvFilePath = "C:\Users\satsaa_ad12\Desktop\generaluse_samAccountName16000.csv"
$groupName = "MFA_Enable_Group"
$resultFilePath = "C:\Users\satsaa_ad12\Desktop\mfa_report16000.csv"

# Import the samAccountNames from the input file
$users = Import-Csv $csvFilePath | Select-Object -ExpandProperty samAccountName

# Get the group
$group = Get-ADGroup $groupName

# Create an array to store the results
$results = @()

# Iterate through each user and add them to the group if they exist
foreach ($user in $users) {
    # Check if the user exists in Active Directory
    $adUser = Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue

    if ($adUser) {
        # Add the user to the group
        Add-ADGroupMember -Identity $group -Members $adUser

        $result = [PSCustomObject]@{
            samAccountName = $user
            Action = "Added to the group"
        }
    }
    else {
        $result = [PSCustomObject]@{
            samAccountName = $user
            Action = "Skipped (User does not exist)"
        }
    }

    # Add the result to the results array
    $results += $result

    # Write the result to the console
    Write-Host "$($result.samAccountName) - $($result.Action)"
}

# Export the results to a .csv file
$results | Export-Csv -Path $resultFilePath -NoTypeInformation
