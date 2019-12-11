$myVariable = "Defined in the Script scope"
function myFunction {
     $myVariable = "Defined in the function's scope" 
     Write-Host "The local version of myVariable: $Local:myVariable"
     Write-Host "The script level version of myVariable: $Script:myVariable"
}
myFunction