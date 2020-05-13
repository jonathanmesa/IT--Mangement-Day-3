

###NOTE: This can only be done on a Domain joined machine cmdlet are aligned to be run from the lab environment win 10 client


#Start PowerShell as an Administrator.

#Create a new AD groups used to map the role capability to group
New-Adgroup –name “Role1” –groupscope “Global” –server “dc”

#Start winRM service if this is a client machine
Start-service –name Winrm                          #           -> or start manual via services.msc


#Create a JEA session configuration file

#Create a JEA session configuration file with standard options
New-PSSessionConfigurationFile -Path “c:\Pshell\MyJEARoleEndpoint.pssc”

#Open the file and change the following role capabilities:

&“c:\Pshell\MyJEARoleEndpoint.pssc”

#Add /change the following role capability
SessionType = 'RestrictedRemoteServer'	#	->> Needed to get basic command instead of a empty shell
RoleDefinitions = @{ 'CONTOSO\role1' = @{ RoleCapabilities = ‘role1’}}

#Register a new PS JEA session using the just created file 
Register-PSSessionConfiguration -Path “c:\Pshell\MyJEARoleEndpoint.pssc”  -Name “JEARoles” -Force 

#Restart WinRM to make the configuration active
Restart-Service –name winrm

#Create a new JEA role capability files: 

File 1 – role 1
New-PSRoleCapabilityFile -Path c:\Pshell\role1.psrc

#Open the file and change the following keywords:

&“c:\Pshell\role1.psrc”

#Change the keyword Modulestoimport
Modulestoimport = ‘Activedirectory’                    #  -> Don`t forget to uncomment, Might need to update quotes if you copy paste
Visiblecmdlets =  ‘get-ad*’                              #          -> Don`t forget to uncomment, Might need to update quotes if you copy paste

#Copy the file to the rolecapabilityfolder in the AD module directory
New-item –path “c:\windows\system32\Windowspowershell\v1.0\modules\activedirectory\Rolecapabilities” –type “Directory”
Copy-item –path ”c:\Pshell\role1.psrc” –destination “c:\windows\system32\Windowspowershell\v1.0\modules\activedirectory\Rolecapabilities\role1.psrc”

#Show the configuration is different depending on group membership

#Connect to the JEA session
Enter-PSSession -ComputerName WIN10 -ConfigurationName ”JEARoles”      	-> will fail as your not member of the AD group

#Add yourself to the group “Role1”
Add-adgroupmember –identity role1 –members power

#Re-Connect to the JEA session
Enter-PSSession -ComputerName WIN10 -ConfigurationName ”JEARoles”

#Run get command to show all available commands
Get-Command	-> AD get commands should now be there

#Disconnect from the session
Exit

#Remove your self from the group
Remove-Adgroupmember –identity role1 –members power 		

#From the same shell Re-Connect to the JEA session
Enter-PSSession -ComputerName WIN10 -ConfigurationName ”JEARoles”		#-> This should work as the enter-pssession reuses its session to connect on

#From a new shell Re-Connect to the JEA session
Enter-PSSession -ComputerName WIN10 -ConfigurationName ”JEARoles”		#-> This should fail as it creates a new session with new authorisation

#Disconnect from the session
Exit

#Note: there is group membership cache so removing yourself from the group and rejoining might not directly remove the permissions again.

##########
