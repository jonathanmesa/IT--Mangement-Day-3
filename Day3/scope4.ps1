$myVariable = "Defined in the Script scope"
Set-Variable -Name myVariable -Option AllScope
function myFunction {
     $myVariable = "Changed at the function level"
}
myFunction
$myVariable