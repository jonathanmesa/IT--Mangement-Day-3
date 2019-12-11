#Consider demoing the following:
####### ***NOTE: This can only be done on a Domain joined machine and forest functional level server 2016  

#Prepare a group to use with PAM

#Enable PAM on the forest level
Enable-ADOptionalFeature "Privileged Access Management Feature" -Scope ForestOrConfigurationSet -Target “Contoso.com“

#Create new AD group
New-ADGroup -Name "JIT" -SamAccountName “Jit” -GroupCategory Security -GroupScope Global -DisplayName "JIT" -Path "CN=Users,DC=Contoso,DC=Com" 

#Add JIT group to remote desktop users on the memberserver
Invoke-command -ComputerName ms -ScriptBlock {Add-LocalGroupMember -Name "Remote Desktop Users" -Member "contoso\JIT"}

#Create new testuser
New-ADUser -Name "JIT-user1" -SamAccountName "JIT-user1" -DisplayName 'JIT-user1' -AccountPassword (Read-Host -Prompt 'pw' -AsSecureString)  -Enabled $true
 
#Show its not working 

#Login via RDP on the MS
mstsc /v:ms.contoso.com              -> use the Jit-user1 you just created

#Show it works when member of JIT group

#Add user to the group with 5 minutes TTL
Add-ADGroupMember -Identity ‘JIT’ -Members ‘JIT-user1’ -MemberTimeToLive [timespan]"00:05" 

#Login via RDP on the MS
mstsc /v:ms.contoso.com     #         -> use the Jit-user1 you just created

#Show access is revoked after 5 min

#Show the countdown of the JIT setting
Get-ADGroup –Identity ‘JIT’ -Property member -ShowMemberTimeToLive | select-object -ExpandProperty member


#Wait for atleast 5 minutes and try again
mstsc /v:ms.contoso.com     #         -> use the Jit-user1 , you should no longer be allowed to connect

#Show you are no longer member of the group
Get-ADGroupMember -Identity ‘JIT’ 

##########
