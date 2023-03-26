#note: app_role_name must exist for this to work!
#run $sp.AppRoles after $sp to find the roles
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$app_name = Read-Host "Enter enterprise app name"
$app_role_name = "Enter app role name (usually just 'user')"
$sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
$appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }
foreach($user in $users) {
    $username = $user.UserPrincipalName 
    $usr = Get-AzureADUser -ObjectId "$username"
    New-AzureADUserAppRoleAssignment -ObjectId $usr.ObjectId -PrincipalId $usr.ObjectId -ResourceId $sp.ObjectId -Id $appRole.Id
}



$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$app_name = Read-Host "Enter app name"
$app_role_name = "User"
$sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
$appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }
foreach($user in $users) {
    $username = $user.UserPrincipalName 
    $usr = Get-AzureADUser -ObjectId "$username"
    New-AzureADUserAppRoleAssignment -ObjectId $usr.ObjectId -PrincipalId $usr.ObjectId -ResourceId $sp.ObjectId -Id $appRole.Id
}


# Assign the values to the variables
$username = "<Your user's UPN>"
$app_name = "<Your App's display name>"
$app_role_name = "<App role display name>"

# Get the user to assign, and the service principal for the app to assign to
$usr = Get-AzureADUser -ObjectId "$username"
$sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
$appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }

# Assign the user to the app role
New-AzureADUserAppRoleAssignment -ObjectId $usr.ObjectId -PrincipalId $usr.ObjectId -ResourceId $sp.ObjectId -Id $appRole.Id