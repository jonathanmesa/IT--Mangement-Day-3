

#Make sure the WINRM service is running
Get-service –name winrm              #       -> If it has not started start it       start-service –name Winrm

Show the current Ps session configurations. Make sure you run PowerShell as administrator
Get-PSSessionConfiguration | ft name, PSSessionConfigurationTypeName


#Create a new JEA endpoint on a machine: 

#Create a new PS session configuration file
New-PSSessionConfigurationFile -SessionType RestrictedRemoteServer -Path .\MyJEAEndpoint.pssc 

#Register a new PS session using the just created file 
Register-PSSessionConfiguration -Path .\MyJEAEndpoint.pssc  -Name 'JEAMaintenance' -Force 

#Look at the WSMAN configuration / show some of the sub properties
Cd wsman:\localhost\plugin                      ->  look at some sub folders 

#Remove the endpoint again
Unregister-PSSessionConfiguration -Name 'JEAMaintenance' -Force
