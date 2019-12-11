$Script = "Script scope"
function myFunction {
     $Function = "Scope of the function"
     $Script
     $Script = "Trying to change a variable in the Script scope"
}
myFunction
$Script
$Function