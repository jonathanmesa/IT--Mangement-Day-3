
####NOTE: This can only be done on a Domain joined machine 

#Create a JEA session configuration file

#Create a JEA session configuration file with standard options
New-PSSessionConfigurationFile -Path “c:\MyJEAEndpoint.pssc”

#Create a JEA session configuration file with all options
New-PSSessionConfigurationFile -Path “c:\MyJEAEndpointfull.pssc” –full

#Open both files and show the difference in option logged in the files

#Copy the standard options file to use as a restricted file
Copy-Item -Path "C:\MyJEAEndpoint.pssc" -Destination "C:\MyJEAEndpointrestricted.pssc"

#Open the C:\MyJEAEndpointrestricted.pssc and change the session type to Restrictedremoteserver
SessionType = 'RestrictedRemoteServer’

#Create 2 new JEA endpoint on a machine: 

# a new PS session using the just created file 
Register-PSSessionConfiguration -Path “c:\MyJEAEndpoint.pssc”  -Name “JEADefault”

Register-PSSessionConfiguration -Path “C:\MyJEAEndpointrestricted.pssc”  -Name “JEARestricted”

#Restart WinRM to make the configuration active
Restart-Service –name winrm

#Show the configuration on both endpoints in different

#Connect to the default session
Enter-PSSession -ComputerName localhost -ConfigurationName ”JEADefault”

#Run get command to show all available commands
Get-Command

#Disconnect from the session
Exit

#Connect to the Restricted session
Enter-PSSession -ComputerName localhost -ConfigurationName ”JEARestricted”

Run get command to show all available commands
Get-Command    #          -> Only 8 cmdlets should show up

#Run a cmdlet that not available
Get-host

#Disconnect from the session
Exit


#Re-Run a cmdlet that was not available but is in normal shell
Get-host

##########
