function myFunction {
     $Script:Function1 = "Created in the Script Scope"
     $Function2 = "Created in the scope of the function"
}
myFunction
$Function1
$Function2