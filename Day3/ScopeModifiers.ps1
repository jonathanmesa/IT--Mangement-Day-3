
#create a regular variable
$PriVar = "This is a local Variable"

#Define a new function to query the variable from a different scope
function TestFunc {"`$PriVar is $PriVar"}

#Variable's value is returned OK
Testfunc

#Create a private variable that cannot be viewed or modified from another scope
#Using the New-Variable cmdlet's -option parameter
New-Variable -Name PriVar -Value "This is a Private Variable" -Option private -Force

#We can access the variable from within the scope it was defined
$PriVar

#but accessing the variable from a different scope, such as a function, fails
Testfunc
