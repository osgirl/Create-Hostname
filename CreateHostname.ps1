## Created by Steve Gulloni
## Modify the following lines accordingly to your needs before running:

#Lines: 9, 12, 15, 18, 21, 42 and 43

import-module activedirectory

## Device Naming Convention
$naming = "AACLLTOL"

## Hostname Description
$description = "SRTASKXXX"

## First Hostname Number to create
[int]$i = 51 

## OU where to create
$ou = "OU=CLLTO,OU=Laptops,OU=Clients,OU=BASE,OU=AA,DC=anglo,DC=local"

## Range to Create, in this example it will be from 51 till 101
while ($i -lt 102) {
    
    ## Check if Hostname number is under 100
    if ($i -lt 100) {
    
    #If under 100, add "00"
    $pcName = $naming + "00" + $i
    } 
    
    #If above 100, add "0"
    else {
    $pcName = $naming + "0" + $i
    }
    
    ### Create Hostname ##
    New-AdComputer -name $pcName -SamAccountName $pcName -Path $ou -enable $True -description $description
    
    ## To Hostnames, samAccountName should include "$" at the end.
    $pcName += "$"
    
    #Add Groups to Hostname
    ADD-ADGroupMember “AA MBAM Win 8.1 Computers” –members $pcName
    ADD-ADGroupMember “HPsam-BASE-CLLTO-Desktops” –members $pcName
    
    #Status Indicator
    write-host "Hostname " $pcName " Created"
    
    ## Sum 1 to Hostname number.
    $i++
}

write-host "Task Completed"
