# defineerime vajaliku kasurea parameetrid
param(
    $Kasutajanimi,
    $TaisNimi,
    $KontoKirjeldus
    )
 # loome kasuatajale parooli
 $KasutajaParool = ConvertTo-SecureString "qwerty" -AsPlainText -Force
 # lisame kasutaja vastavate andmetega
 New-LocalUser "$Kasutajanimi" -Password $KasutajaParool -FullName "$Taisnimi" -Description "$KontoKirjeldus"
