Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = Read-Host "Enter path to output .csv" 
$userList = Import-Csv $csvPath

$output = @()
# Loop through each user in the input list
foreach ($user in $userList) {

  # Retrieve user details from Active Directory
  $adUser = Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" `
    -Properties EmployeeNumber

  # If user is found, set EmployeeNumber and add their details to output array
  if ($adUser) {
    Set-ADUser $adUser -EmployeeNumber $user.EmployeeNumber
    $adUser = Get-ADUser -Identity $adUser.DistinguishedName -Properties EmployeeNumber
    $output += [PSCustomObject] @{
      SamAccountName = $adUser.SamAccountName
      EmployeeNumber = $adUser.EmployeeNumber
    }
    Write-Host "Updated EmployeeNumber for $($adUser.SamAccountName)"
  }
  else {
    Write-Host "User $($user.SamAccountName) not found"
  }
}

# Export output array to CSV file
$output | Export-Csv $outputPath -NoTypeInformation
