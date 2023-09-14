#works. 
Import-Module ActiveDirectory

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    Enable-ADAccount -Identity $user.samAccountName
    Set-ADUser $user.samAccountName -EmployeeNumber $user.EmployeeNumber -Description "Modified by: [Jun Yuan, 31-08-2023, RITM000000093685"
    Get-ADUser $user.samAccountName -Properties * | Select-Object SamAccountName, EmployeeNumber, Description, ObjectGUID
    $guid = Get-ADUser $user.samAccountName -Properties *
    if ($guid.Company -eq "SATS Airport Services Pte Ltd") {
        Move-ADObject -Identity $guid.ObjectGUID -TargetPath "OU=SAS,DC=satsnet,DC=com,DC=sg"
    }

    elseif ($guid.Company -eq "SATS Catering Pte Ltd") {
        Move-ADObject -Identity $guid.ObjectGUID -TargetPath "OU=SCC,DC=satsnet,DC=com,DC=sg"
    }

    elseif ($guid.Company -eq "SATS Security Services Private Limited") {
        Move-ADObject -Identity $guid.ObjectGUID -TargetPath "OU=SSS,DC=satsnet,DC=com,DC=sg"
    }

    elseif ($guid.Company -eq "SATS Ltd") {
        Move-ADObject -Identity $guid.ObjectGUID -TargetPath "OU=SHC,DC=satsnet,DC=com,DC=sg"
    }

    else {
        Write-Host "Company Not Found. Please manually move OU."
    }
}

