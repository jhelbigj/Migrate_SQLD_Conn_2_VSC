# file name: convert_SQLDC_2_VSCC.ps1
#
#Windows Local Username
$localuser = "windowsusername"
# Path to JSON-Datei
$jsonFilePath = "C:\Users\$($localuser)\sqldeveloper_export.json"
# Base dir for VSC connections
$baseDir = "C:\Users\$($localuser)\AppData\Roaming\DBTools\connections\"

# Debug script
$onlyOutput = "0" #0,1

# read the content of JSON-file
$jsonContent = Get-Content -Path $jsonFilePath -Raw

# convert JSON-content to a PowerShell-Object
$jsonObject = $jsonContent | ConvertFrom-Json

# check - exists base dir
if (-not (Test-Path -Path $baseDir)) {
    New-Item -Path $baseDir -ItemType Directory
    Write-Host "Verzeichnis $($directoryPath) erstellt."  
}
else {
    Write-Host "Verzeichnis $($directoryPath) existiert."  
}

# loop over connections
foreach ($connection in $jsonObject.connections) {
    
    if ($null -ne $connection.info.serviceName -and $null -ne $connection.info.hostname -and $null -ne $connection.info.port -and $null -ne $connection.info.user) {
        # dir name based on connection name
        $newDir = $connection.name -replace " ", ""
        $directoryPath = Join-Path -Path $baseDir -ChildPath $newDir

        # create dir 
        if (-not (Test-Path -Path $directoryPath)) {
            # dir name without blanks
            New-Item -Path $directoryPath -ItemType Directory
            Write-Host "Direcory $($directoryPath) created."   
        }

        # create path to dbtools.properties file
        $filePath = Join-Path -Path $directoryPath -ChildPath "dbtools.properties"
    
        Write-Host "name=$($connection.name)"
        Write-Host "userName=$($connection.info.user)"
        Write-Host "host=$($connection.info.hostname)"
        Write-Host "port=$($connection.info.port)"
        Write-Host "serviceName=$($connection.info.serviceName)"
        Write-Host "-------------------------------"

        # collect content
        if ($onlyOutput -eq "0") {            
            $fileContent = @"
name=$($connection.name)
type=ORACLE_BASIC
userName=$($connection.info.user)
host=$($connection.info.hostname)
port=$($connection.info.port)
serviceName=$($connection.info.serviceName)
"@    
            # create file
            Set-Content -Path $filePath -Value $fileContent

            Write-Host "File for $($connection.name) created."
        }
    }
}
