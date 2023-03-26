$csvloc1 = Read-Host "Enter path to .csv (remove quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2


$SKU = Read-Host "Enter license type (Kiosk / E1 / E3)"
If($SKU -eq "Kiosk"){
    write-host "u wrote: $SKU"
}
elseif($SKU -eq "E1"){
    write-host "u wrote: $SKU"
}
else{
    write-host "pundeh"

}
