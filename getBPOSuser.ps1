Function todaydate {
    Get-Date -Format "ddMMyyyy"
}

$today = todaydate

# Specify the path to the input file containing SamAccountNames (one per line)
$inputFilePath = Read-host "Enter input csv"

# Specify the path to the CSV file where the results will be exported
$outputFilePath = "C:\Users\satsaa_adsupport01\Desktop\checkuser_$today.csv"

# Initialize an array to store the results
$results = @()

# Read the input file and process each SamAccountName
Get-Content -Path $inputFilePath | ForEach-Object {
    $samAccountName = $_
    
    # Check if the user exists in Active Directory
    $userExists = Get-ADUser -Filter {SamAccountName -eq $samAccountName} -ErrorAction SilentlyContinue
    
    # Create an object with the user's SamAccountName and existence status
    $resultObject = [PSCustomObject]@{
        SamAccountName = $samAccountName
        UserExists = [bool]$userExists
    }
    
    # Add the result object to the results array
    $results += $resultObject
}

# Export the results to the CSV file
$results | Export-Csv -Path $outputFilePath -NoTypeInformation
Write-Host "Results exported to $outputFilePath"
