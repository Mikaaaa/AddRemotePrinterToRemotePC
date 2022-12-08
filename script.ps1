$computerName = Read-Host "Nom entier du PC distant"

$printerName = "Nom_de_l'imprimante"
$printer = Get-Printer -Name $printerName

$connectionName ="\\"+ $printer.ComputerName+"\"+$printerName

try {
    Test-Connection $computerName -Count 1
}
catch {
    Write-Host "Vérifiez saisie du Pc distant"
} 

if(($printer.Shared)){


    try {
        
        Write-Host "Adding $connectionName."
    
        Add-PrinterPort -Name $printer.Name -PrinterHostAddress $printer.PortName -ComputerName $computerName        
        
    }
    catch {
        Write-Host "Le port existe déjà"
    }

    try {
        Add-PrinterDriver $printer.DriverName -ComputerName $computerName
    }
    catch {
        Write-Host "Le driver existe déjà"
    }

    try {
        Add-Printer -Name $printer.Name -DriverName $printer.DriverName -PortName $printer.Name -ComputerName $computerName
    }
    catch {
        Write-Host "L'imprimante existe déjà"
    }

}
