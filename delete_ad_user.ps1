$FirstName = Read-Host -Prompt 'Sisestage kasutaja eesnimet: '
$LastName = Read-Host -Prompt 'Sisestage kasutaja pereniment: '

$username = $FirstName + "." + $LastName
$username = Translit($username)

$UserToRemove = Get-ADUser -Filter {SamAccountName -eq $Username} -ErrorAction SilentlyContinue

if ($UserToRemove) {
    Remove-ADUser -Identity $UserToRemove -Confirm:$false
    Write-Output "User $Username has been removed."
} else {
    Write-Output "User $Username not found in Active Directory."
}


function Translit {
    # function use as parameter string to translit
    param(
        [string] $inputString
    )
    # define the characters which have to be translited
        $Translit =@{
        [char]'ä' = "a"
        [char]'õ' = "o"
        [char]'ü' = "u"
        [char]'ö' = "o"
        }
    # create translited output
    $outputString=""
    # #transfer string to array of characters and by character
    foreach ($character in $inputCharacter = $inputString.ToCharArray()) {
        # if character is exists in list of characters for translating
        if ($Translit[$character] -cne $Null ){
            # add to output translited characher
            $outputString += $Translit[$character]
        } else {
            # otherwise add the initial character
            $outputString += $character
        }
    }
    Write-Output $outputString
    $UserExists = Get-ADUser -Filter {SamAccountName -eq $outputString} -ErrorAction SilentlyContinue

    if ($UserExists) {
        Write-Output "User $outputString already exists - can not add this users."
    } else {
        Write-Output "New user $outputString added successfully."
    }