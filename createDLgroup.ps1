Function Start-Countdown{   
    Param(
        [Int32]$Seconds = 10,
        [string]$Message = "Pausing for 10 seconds..."
    )
    ForEach ($Count in (1..$Seconds))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
}

#Import active directory module for running AD cmdlets

Import-Module activedirectory

$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$Groups = Import-Csv $csvloc2

foreach ($Group in $Groups) {
    $CheckName = $Group.Name
    # Check to see if the group already exists in AD
    if (Get-ADGroup -Filter {Name -eq $CheckName}) {
        Write-Host "The group $groupName exists."
    }
    else {
    $name = $Group.Name
    $groupcat = $Group.Category
    $scope = $Group.Scope
    $path = $Group.Path
    $description = $Group.Description
    $mail = $Group.Email
    New-ADGroup -Name $name -SamAccountName $name -GroupCategory $groupcat -GroupScope $scope -DisplayName $name -Path $path -Description $description
    Write-Host "$name group has been created."
    Start-Countdown -Seconds 3 -Message "Wait 3 seconds before adding mail attribute..."
    Set-ADGroup -identity $name -Replace @{mail=$mail} 
    }
}

# for each row in CSV...
foreach ($User in $Groups) {
    # assign the column Name as the DL group $groupname
    $Groupname = $User.Name
    # assign an array to this variable $listofusers
    $listofusers = @(
        $User.Member1,
        $User.Member2,
        $User.Member3,
        $User.Member4,
        $User.Member5,
        $User.Member6,
        $User.Member7,
        $User.Member8,
        $User.Member9,
        $User.Member10,
        $User.Member11,
        $User.Member12,
        $User.Member13,
        $User.Member14,
        $User.Member15,
        $User.Member16,
        $User.Member17,
        $User.Member18,
        $User.Member19,
        $User.Member20,
        $User.Member21
    )
    # for each row in list $listofuser...
    foreach ($member in $listofusers) {
        if ($member -ne $null -and $member -ne "") {
            Add-ADGroupMember -Identity $Groupname -Members $member
            Write-Host "Added $member to $Groupname"
        }
        else {
            Write-Host "Skipping empty member in array"
        }
    }
}

