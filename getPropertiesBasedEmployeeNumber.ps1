# Import the Active Directory module
Import-Module ActiveDirectory

# Prompt for input and output paths
$csvPath = Read-Host "Enter path to input .csv"
$outputPath = Read-Host "Enter path to output .csv"

# Read the CSV file
$userList = Import-Csv $csvPath

# Create an array to store custom objects with user information
$userInfoArray = @()

# Loop through each entry in the CSV
foreach ($user in $userList) {
    $employeeNumber = $user.employeeNumber

    # Find the user in Active Directory based on the employee number
    $adUser = Get-ADUser -Filter { employeeNumber -eq $employeeNumber }  -Properties * | Select *

    if ($adUser) {
        # Gather user attributes
        $userInfo = [PSCustomObject]@{
            Enabled = $adUser.Enabled
            SamAccountName = $adUser.SamAccountName
            UserPrincipalName = $adUser.UserPrincipalName
            EmailAddress = $adUser.EmailAddress
            GivenName = $adUser.GivenName
            Surname = $adUser.Surname
            DisplayName = $adUser.DisplayName
            Title = $adUser.Title
            Department = $adUser.Department
            Company = $adUser.Company
            EmployeeNumber = $adUser.EmployeeNumber
            Description = $adUser.Description
            whenCreated = $adUser.whenCreated
            whenChanged = $adUser.whenChanged
            Office = $adUser.Office
            HomePhone = $adUser.HomePhone
            facsimileTelephoneNumber = $adUser.facsimileTelephoneNumber
            Fax = $adUser.Fax
            ipPhone = $adUser.ipPhone
            pager = $adUser.pager
            mobile = $adUser.mobile
            mobilephone = $adUser.mobilephone
            Country = $adUser.Country
        }

        # Add user info to the array
        $userInfoArray += $userInfo
        Write-Host "User $($adUser.SamAccountName) found and attributes gathered."
    } else {
        Write-Host "User with employee number $employeeNumber not found in Active Directory"
    }
}

# Export the user information to a CSV file
$userInfoArray | Export-Csv -Path $outputPath -NoTypeInformation

Write-Host "Script execution completed."
