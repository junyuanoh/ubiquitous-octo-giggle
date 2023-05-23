# Define the paths to the CSV files
$emailCsvPath = "\\Mac\Home\Desktop\InputCSV\generaluse.csv"
$ipCsvPath = "\\Mac\Home\Desktop\InputCSV\generaluse_ipAddress.csv"
$startDate = (Get-Date).AddDays(-10) 
$endDate = Get-Date 

# Import the email addresses and IP addresses from the CSV files
$UserPrincipalName = Import-Csv $emailCsvPath | Select-Object -ExpandProperty UserPrincipalName
$ipAddresses = Import-Csv $ipCsvPath | Select-Object -ExpandProperty IPAddress

# Initialize an empty array to store the evaluation results
$results = @()

# Iterate through each email address
foreach ($email in $UserPrincipalName) {
    # Initialize a flag to track if all IP addresses were found in the email trace results
    $allIPsFound = $true

    # Iterate through each IP address
    foreach ($ip in $ipAddresses) {
        # Get the message trace results for the email address and IP address combination
        $traceResults = Get-MessageTrace -RecipientAddress $email -FromIP $ip -StartDate $startDate -EndDate $endDate

        # Check if any message trace results were found
        if ($traceResults.Count -eq 0) {
            # Set the flag to false if no message trace results were found for the IP address
            $allIPsFound = $false
            break
        }
    }

    # Create a custom object with the email address and the evaluation result
    $result = [PSCustomObject]@{
        EmailAddress = $email
        AllIPsFound = $allIPsFound
    }

    # Add the result to the results array
    $results += $result
}

# Output the results to the console
$results | Format-Table -AutoSize

# Export the results to a CSV file
$results | Export-Csv -Path "\\Mac\Home\Desktop\OutputCSV\ip_result.csv" -NoTypeInformation

###
#Historical Search

# Define the paths to the CSV files
$emailCsvPath = "\\Mac\Home\Desktop\InputCSV\generaluse.csv"
$ipCsvPath = "\\Mac\Home\Desktop\InputCSV\generaluse_ipAddress.csv"

# Import the email addresses and IP addresses from the CSV files
$emailAddresses = Import-Csv $emailCsvPath | Select-Object -ExpandProperty UserPrincipalName
$ipAddresses = Import-Csv $ipCsvPath | Select-Object -ExpandProperty IPAddress

# Initialize an empty array to store the evaluation results
$results = @()

# Iterate through each email address
foreach ($email in $emailAddresses) {
    # Initialize a flag to track if all IP addresses were found in the email search results
    $allIPsFound = $true

    # Initialize an array to store the search results for each IP address
    $searchResults = @()

    # Iterate through each IP address
    foreach ($ip in $ipAddresses) {
        # Start a historical search for the email address and IP address combination
        $search = Start-HistoricalSearch -ReportTitle "Search for $ip under $email" -ReportType MessageTrace -StartDate (Get-Date).AddDays(-30) -EndDate (Get-Date) -RecipientAddress $email -OriginalClientIP $ip -NotifyAddress satsvn_junyuan.oh@sats.com.sg

        # Add the search result to the array
        $searchResults += $search
    }

    # Check if all IP addresses have completed search results
    if ($searchResults.Count -ne $ipAddresses.Count) {
        # Set the flag to false if not all IP addresses have completed search results
        $allIPsFound = $false
    }

    # Create a custom object with the email address and the evaluation result
    $result = [PSCustomObject]@{
        EmailAddress = $email
        AllIPsFound = $allIPsFound
    }

    # Add the result to the results array
    $results += $result
}

# Output the results to the console
$results | Format-Table -AutoSize

# Export the results to a CSV file
$results | Export-Csv -Path "\\Mac\Home\Desktop\OutputCSV\ip_result_junyuan02.csv" -NoTypeInformation
