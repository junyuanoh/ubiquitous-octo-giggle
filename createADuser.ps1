#Import active directory module for running AD cmdlets
Import-Module activedirectory

#Store the data from ADUsers.csv in the $ADUsers variable
$csvloc = Read-Host "Enter path to .csv" 
$Users = Import-Csv $csvloc

#Loop through each row containing user details in the CSV file 
foreach ($User in $Users) {
    $Username = $User.SamAccountName
    # Check to see if the user already exists in AD
    if (Get-ADUser -F {SamAccountName -eq $Username}) {
         Write-Warning "A user account with username $Username already exist in Active Directory."
    }
    else {
        # create a hashtable for splitting the parameters
        $userProps = @{
            SamAccountName             = $User.SamAccountName                   
            Path                       = $User.path
            Name                       = $User.FullName
	        EmployeeNumber	           = $User.EmployeeNumber
            DisplayName                = $User.DisplayName
            GivenName                  = $User.FirstName
            UserPrincipalName          = $user.UserPrincipalName
            Description                = $User.Description
            AccountPassword            = (ConvertTo-SecureString $User.password -AsPlainText -Force) 
            Enabled                    = $true
            ChangePasswordAtLogon      = $true
            department                 = $User.Department
            title                      = $User.Title
            Surname                    = $User.LastName
            company                    = $User.Company
            email                      = $User.EmailAddress
            Office                     = $User.Office
           #end userprops   
           }
        New-ADUser @userProps
        Write-Host "The user account $User is created." -ForegroundColor Cyan
    }
}
foreach ($1User in $Users) {
    $Username = $1User.SamAccountName
    $Groups = @(
        $1User.Group1,
        $1User.Group2,
        $1User.Group3
    )
    ForEach ($Group in $Groups) {
        Add-ADGroupMember -Identity $Group -Members $Username
    }   
}