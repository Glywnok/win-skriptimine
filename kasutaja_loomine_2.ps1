#maarame, kus on asumas fail mille sees on kasutajate andmed
$File = "C:\Users\Delkiv\Documents\win-skriptimine\kasutajad\kasutajad.csv"
#loeme failist sisu,info jaotakse ;  jargi
$kasutajad = Import-Csv $File -Encoding Default -Delimiter ";"
#failis iga kasutaja andmestik on eraldi reas
#vaatame faili sisu ridade kaupa
#selleks salvestame iga rida $kasutaja muutuja sisse
foreach ($kasutaja in $kasutajad)
{
    #kuna reas on mitu vaartust, siis iga element on katte saadav veery nimetuse jargi, mis me peame
    #$muutuja.VeeruNimetus kujul kirja
    $Kasutajanimi = $kasutaja.Kasutajanimi
    $Taisnimi = $kasutaja.Taisnimi
    $KontoKirjeldus = $kasutaja.KontoKirjeldus
    $Parool = $kasutaja.Parool | ConvertTo-SecureString -AsPlainText -Force
    #kasutades saadud info lisame kasutaja
    New-LocalUser -Name $Kasutajanimi -Password $Parool -Fullname "$Taisnimi" -Description "$KontoKirjeldus"
}
