#view current values of $profiles
$profile | get-member -type noteproperty 
#Display current user profile path
$profile
#Display current user all hosts profile path 
$Profile.CurrnetUserAllHosts 
#Display all users current hosts profile path 
$Profile.AllUsersCurrentHost 
#Display all users all hosts profile path 
$Profile.AllUsersAllHosts 

#Create a new profile file
#Where would profile be?
$profile

#Before we decide to create a profile, let’s check to see whether we already have one
Test-Path $profile

#Create if doesn't exist or overwrite existing one
New-Item -path $profile -type file -force

#View profile in ISE
ise $profile

#++++ add following code to profile

# dot source previously created script to make functions available
# upon startup
. c:\scripts\MyFunctions.ps1

# create and alias available on startup
New-Alias -Name MyAlias -Value Get-Service

# create a greeting
Write-Host "Powershell ROCKS!" -ForegroundColor Blue -BackgroundColor White

#++++++ End of code for file

#save and close profile

#reopen new ISE 

#validate MyAlias exists
Get-Alias m*

#validate functions exist with Intellisense
AddTen 3
GetServerData localhost 
 

##########
