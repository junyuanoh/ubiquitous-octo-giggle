Function todaydate {
    Get-Date -Format "ddMMyyyy"
}

$today = todaydate

$txtloc_temp = Read-Host "Enter path to .txt"
$txtloc = $txtloc_temp.Replace("`"","")

$d =  Get-Content -Path $txtloc 
Function Extract-String {
    Param(
        [Parameter(Mandatory=$true)][string]$string
        , [Parameter(Mandatory=$true)][char]$character
        , [Parameter(Mandatory=$false)][ValidateSet("Right","Left")][string]$range
        , [Parameter(Mandatory=$false)][int]$afternumber
        , [Parameter(Mandatory=$false)][int]$tonumber
    )
    Process
    {
        [string]$return = ""

        if ($range -eq "Right")
        {
            $return = $string.Split("$character")[($string.Length - $string.Replace("$character","").Length)]
        }
        elseif ($range -eq "Left")
        {
            $return = $string.Split("$character")[0]
        }
        elseif ($tonumber -ne 0)
        {
            for ($i = $afternumber; $i -le ($afternumber + $tonumber); $i++)
            {
                $return += $string.Split("$character")[$i]
            }
        }
        else
        {
            $return = $string.Split("$character")[$afternumber]
        }

        return $return
    }
}

$count = 0

$objectmail = @{}#Intiates Hash table

Function Extract-Mail{

    $mailsarray = @()
    $mails = Get-Content -Path $txtloc | Where-Object { $_ -match 'E-Mail'} #Gets all mail addresses in file
    foreach ($mail in $mails){
        $mailvalue = Extract-String -string $mail -character ":" -range Right  #Gets the right part from ':'
        $mailsarray += $mailvalue
        

        }
        
        return $mailsarray

    }

Function Fill-Array{
    $valuefinalarray= @()
    $test = Extract-Mail

        foreach ($line in $d) {
        $value = Extract-String -string $line -character ":" -range Right

        $valuefinal = $value| Where-Object {$_ -notmatch '#########'}
        $count = $valuefinal.Length
        $last = $test.length -1
                    
            if ($count -eq 0){
                 
                               
                if ($countzeroes -eq -2){
                                               
                        
                        foreach($loop in $test){
                            
                            
                            if ($objectmail.ContainsKey($loop)){
                            
                            continue
                            
                            }

                            else{
                            $objectmail.Add($loop,$valuefinalarray)
                                                                                 
                                                       
                            
                            $valuefinalarray = @()
                            break
                            }
                                    
                            }
                        }

                if ($countzeroes -eq -1){
                                        
                    $countzeroes = $countzeroes - 1
                    
                    continue    
                }

            $countzeroes = $valuefinal.Length - 1
            
            
            continue  
                
            }
            else{
            $valuefinalarray += $valuefinal
           
                             
                }
          

        }

        if ($objectmail.ContainsKey($test[$last])){
                            
             
                            
                            }
        else {
            
            $objectmail.Add($test[$last],$valuefinalarray)
        
                            }

        

     }

Fill-Array

$WB = $objectmail.GetEnumerator().Where({$_.Value -match "\bWB\b"}).Name


$keys = $objectmail.GetEnumerator().Where({$_.Value -match "\bFC\b"}).Name
$E1 = @()
$E3pro = @()
$E3standard = @()



foreach ($key in $keys){
    
    
        if (($objectmail.$key[7] -eq 1010) -or ($objectmail.$key[7] -eq 1011) -or ($objectmail.$key[7] -eq 1020) -or ($objectmail.$key[7] -eq 1030) -or ($objectmail.$key[7] -eq 1040) -or ($objectmail.$key[7] -eq 1041) -or ($objectmail.$key[7] -eq 1050) -or ($objectmail.$key[7] -eq 1110) -or ($objectmail.$key[7] -eq 1120) -or ($objectmail.$key[7] -eq 1130)){
        
            $E3pro += $key
        
        }

        if (($objectmail.$key[7] -eq 2000) -or ($objectmail.$key[7] -eq 2010) -or ($objectmail.$key[7] -eq 2020) -or ($objectmail.$key[7] -eq 2030) -or ($objectmail.$key[7] -eq 2040) -or ($objectmail.$key[7] -eq 2050) -or ($objectmail.$key[7] -eq 2410) -or ($objectmail.$key[7] -eq 2420) -or ($objectmail.$key[7] -eq 2430) -or ($objectmail.$key[7] -eq 2440) -or ($objectmail.$key[7] -eq 2450) -or ($objectmail.$key[7] -eq 2452) -or ($objectmail.$key[7] -eq 2455) -or ($objectmail.$key[7] -eq 2460) -or ($objectmail.$key[7] -eq 2510) -or ($objectmail.$key[7] -eq 5010) -or ($objectmail.$key[7] -eq 5020) -or ($objectmail.$key[7] -eq 5030) -or ($objectmail.$key[7] -eq 5040) -or ($objectmail.$key[7] -eq 6210) ){
        
            $E1 += $key
            
            
        
        }

        if ($objectmail.$key[7] -eq 1210){
        
            $E3standard += $key
            
        
        }
    
    

    
    
}



$newFCarray = @()

foreach($E1loop in $E1){
    $newFCarray += $E1loop

}

foreach($E3proloop in $E3pro){
   $newFCarray += $E3proloop

}

foreach($E3loop in $E3standard){
    $newFCarray += $E3loop

}

foreach($WBloop in $WB){
    $newFCarray += $WBloop

}


$test2 = Extract-Mail
$compare = $test2.Where{$_ -notin $newFCarray}

Foreach($compareloop in $compare){

$objectmail[$compareloop] | Out-File -append C:\BPOS\newcodes.txt 
Add-Content -Path C:\BPOS\newcodes.txt -Value "`n"

Write-Host "New codes detected. Please check newcodes.txt and :" $compareloop

}

$WB | Out-File "C:\temp\BPOS\WB_$today.txt"
$E1 | Out-File "C:\temp\BPOS\E1_$today.txt"
$E3pro | Out-File "C:\temp\BPOS\E3Pro_$today.txt"
$E3standard | Out-File "C:\temp\BPOS\E3Standard_$today.txt"