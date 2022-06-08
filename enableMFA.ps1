Connect-MsolService
Write-Host "`nEnsure that .csv file used has 'UserPrincipalName' in the first column and row, followed by name@domain.com after each row."
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

### above for input, below for hard code 


$users = Import-Csv \\Mac\Home\Desktop\PSScriptCSVs\BulkUpdateMFASampleFile.csv
  
foreach ($user in $users)
  
{
    $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $st.RelyingParty = "*"
    $st.State = "Enabled"
    $sta = @($st)
    Set-MsolUser -UserPrincipalName $user.UserPrincipalName -StrongAuthenticationRequirements $sta
}
  
Write-Host "DONE RUNNING SCRIPT"
  
Read-Host -Prompt "Press Enter to exit"