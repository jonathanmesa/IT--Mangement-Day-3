#Create function in script to be dot sourced
function AddTen  {
    param($Param)
    $Param = $Param + 10
    $Param
}

Function GetServerData {
    param($computername)
    Get-CimInstance win32_OperatingSystem -ComputerName $computername
}
 

#Save script as c:\scripts\MyFunctions.ps1

#open new Powershell tab or ISE instance
#run script

####  c:\scripts\MyFunctions.ps1

#call either function
#### AddTen -Param 4


#will get error
#GetServerData -computername localhost
#will get error

#dot source and load into current scope
### . c:\scripts\MyFunctions.ps1

#call functions
### AddTen -param 4
