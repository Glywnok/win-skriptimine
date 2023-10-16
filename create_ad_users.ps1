# location of AD users file
$file = "C:\Users\Delkiv\Documents\adusers.csv"
# import file content
$users = Import-Csv $file -Encoding Default -Delimiter ";"
# foreach user in data row in file
foreach ($user in $users) {
    #username is firstname.lastname
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    #user principal name
    $upname = $username + "@sv-kool.local"
    #display name - eesnimi perenimi
    $displayname = $user.FirstName + " " + $user.LastName

        Write-Output $outputString
    $UserExists = Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue

    if ($UserExists) {
        Write-Output "User $username already exists - can not add this users."
    } else {
        Write-Output "New user $username added successfully."
        New-ADUser -Name $username
            -DisplayNmae $displayname
            -GivenName $user.FirstName
            -Surname $user.LastName
            -Department $user.Department
            -Title $user.Role
            -UserPrincipalName $upname
            -whencreated  Get-Date
            -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText) -Enabled $true
    }


    echo $username
}
# function translit UTF-8 characters to LATIN
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
}