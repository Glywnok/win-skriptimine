#Ulesanne 2

#Teeme andmed ja kusime need kasutajast
#$Kasutajanimi = Read-Host -Prompt 'Sisestage Kasutaja nimet: '




$Name = Read-Host -Prompt 'Sisestage oma nimet: '
$LastName = Read-Host -Prompt 'Sisestage oma prenimet: '
$KontoKirjeldus = Read-Host -Prompt 'Keda/Mida see konto on/teeb: '

#Nuud teeme need Lower Case-ina
$nimi = "$Name + $LastName"
$kirjeldus = $KontoKirjeldus.ToLower()
$Kasutajanimi = $Name.ToLower() + "." + $LastName.ToLower()

#Nuud vaatame, kas on uldse kasutaja selle nimega
$UserExists = Get-LocalUser -Name $Kasutajanimi -ErrorAction SilentlyContinue

if ($UserExists) {
    Write-Output "On juba kasutaja nimega $Kasutajanimi"
    Remove-LocalUser $Kasutajanimi
} else {
    Write-Output "Kasutajat sellisega nimega ei ole"
}
