# Import the Active Directory module
Import-Module ActiveDirectory

# Search for accounts with unconstrained delegation enabled
$accounts = Get-ADObject -Filter {msDS-AllowedToDelegateTo -like "*"} -Properties 'msDS-AllowedToDelegateTo' | Where-Object { $_.ObjectClass -eq "user" }

# Iterate through the accounts
foreach ($account in $accounts) {
    # Retrieve the account's name and delegated SPNs
    $accountName = $account.Name
    $delegatedSPNs = $account.'msDS-AllowedToDelegateTo'

    # Output the account and its delegated SPNs
    Write-Host "Account Name: $accountName"
    Write-Host "Delegated SPNs:"
    foreach ($SPN in $delegatedSPNs) {
        Write-Host "- $SPN"
    }
    Write-Host
}

# Search for accounts with unconstrained delegation enabled
$accounts = Get-ADComputer -Filter {msDS-AllowedToDelegateTo -like "*"} -Properties 'msDS-AllowedToDelegateTo' | Where-Object { $_.ObjectClass -eq "user" }

# Iterate through the accounts
foreach ($account in $accounts) {
    # Retrieve the account's name and delegated SPNs
    $accountName = $account.Name
    $delegatedSPNs = $account.'msDS-AllowedToDelegateTo'

    # Output the account and its delegated SPNs
    Write-Host "Account Name: $accountName"
    Write-Host "Delegated SPNs:"
    foreach ($SPN in $delegatedSPNs) {
        Write-Host "- $SPN"
    }
    Write-Host
}

# Search for accounts with unconstrained delegation enabled
$accounts = Get-ADServiceAccount -Filter {msDS-AllowedToDelegateTo -like "*"} -Properties 'msDS-AllowedToDelegateTo' | Where-Object { $_.ObjectClass -eq "user" }

# Iterate through the accounts
foreach ($account in $accounts) {
    # Retrieve the account's name and delegated SPNs
    $accountName = $account.Name
    $delegatedSPNs = $account.'msDS-AllowedToDelegateTo'

    # Output the account and its delegated SPNs
    Write-Host "Account Name: $accountName"
    Write-Host "Delegated SPNs:"
    foreach ($SPN in $delegatedSPNs) {
        Write-Host "- $SPN"
    }
    Write-Host
}

# Search for accounts with unconstrained delegation enabled
$accounts = Get-ADUser -Filter {msDS-AllowedToDelegateTo -like "*"} -Properties 'msDS-AllowedToDelegateTo' | Where-Object { $_.ObjectClass -eq "user" }

# Iterate through the accounts
foreach ($account in $accounts) {
    # Retrieve the account's name and delegated SPNs
    $accountName = $account.Name
    $delegatedSPNs = $account.'msDS-AllowedToDelegateTo'

    # Output the account and its delegated SPNs
    Write-Host "Account Name: $accountName"
    Write-Host "Delegated SPNs:"
    foreach ($SPN in $delegatedSPNs) {
        Write-Host "- $SPN"
    }
    Write-Host
}

#this works

# Import the Active Directory module
Import-Module ActiveDirectory

# Query accounts with SPNs
$accounts = Get-ADUser -Filter {servicePrincipalName -like "*"} -Properties *

# Export the list to a CSV file
$accounts | Select-Object PrincipalsAllowedToDelegateToAccount, samAccountName, UserPrincipalName | Export-Csv -Path "C:\Users\satsaa_ad12\Desktop\SPN_01.csv" -NoTypeInformation

#this shows list of unconstraint accounts

# Import the Active Directory module
Import-Module ActiveDirectory

# Get all AD users with SPNs
$usersWithSPNs = Get-ADUser -Filter {ServicePrincipalName -like "*"} -Properties ServicePrincipalName, TrustedForDelegation

# Iterate through each user
foreach ($user in $usersWithSPNs) {
    # Check if the user has "Trust this user for delegation to any service (Kerberos only)" enabled
    if ($user.TrustedForDelegation -eq $true) {
        Write-Output "User: $($user.SamAccountName)"
        Write-Output "SPNs:"
        foreach ($spn in $user.ServicePrincipalName) {
            Write-Output "$spn"
        }
        Write-Output ""
    }
}
