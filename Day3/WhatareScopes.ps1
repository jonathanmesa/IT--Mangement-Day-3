
#create variable in global scope
$test = "In the global scope"

#The variable $test was defined in the Global Scope
Write-Host $("[Global Scope] `$test value: " + $test)

#This creates a new variable $test in the Script Scope
$test = "In the script"
Write-Host $("[Script Scope] `$test value: " + $test)

#function definition
function DemoFunctionScope {
    param ([string]$OriginalText)

    #This creates a new variable $test in the Function Scope
    $test = $OriginalText + " function"
    Write-Host $("[Function Scope] `$test value: " + $test)
}

#Invoke the function
DemoFunctionScope -OriginalText $test

#Verify the value of $test after invoking the function
Write-Host $("[Script Scope] `$test value: " + $test)

##########
