# Migrate_SQLD_Conn_2_VSC
Mirgration the connections from Oracle SQL Developer to Visual Studio Code - SQL Developer Extention connection

## Conditions
* You have to export your Oracle SQL Developer Connections, with or without password
  * remember the name
* Install VSC - SQL Developer extention
* create 1 connection, to check the extention works and the VSC directories are created

## Open the script and change following parameter
```
...
#Windows Local Username
$localuser = "windows_username"
# Path to SQL Developer Export JSON file 
$jsonFilePath = "C:\Users\$($localuser)\sqldeveloper_export.json"
...
```

## Start migration
* open powershell terminal
* change to your saved file directory
* start with ./convert_SQLDC_2_VSCC.ps1
