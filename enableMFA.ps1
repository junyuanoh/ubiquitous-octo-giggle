Connect-MsolService
  
$users = Import-Csv \\Mac\Home\Desktop\DisableEOPowershell\BulkUpdateMFASampleFile.csv
  
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