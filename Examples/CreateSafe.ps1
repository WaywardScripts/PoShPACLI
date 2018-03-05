#import Module
import-module PoShPACLI

#Initialise
Initialize-PoShPACLI -pacliFolder D:\Your_Pacli_Dir -pacliExe Pacli.exe

#Authenticate
$token = Start-PVPACLI | New-PVVaultDefinition -address YourVaultHere.com -vault "YourEPV" |
	Connect-PVVault -user YourUser -password (Read-Host -AsSecureString)

#Create Safe, Open, Set Options, Share
$token | New-PVSafe -safe SomeSafe | 
    Open-PVSafe -safe SomeSafe | 
    Set-PVSafe -safeOptions 704 | 
    Add-PVSafeGWAccount -safe SomeSafe -gwAccount PVWAGWAccounts | Out-Null

#add owner PasswordManager
$token | Add-PVSafeOwner -safe SomeSafe -owner PasswordManager -retrieve -store -delete ` 
    -list -usePassword -updateObjectProperties -initiateCPMChange -initiateCPMChangeWithManualPassword `
    -createFolder -deleteFolder -moveFrom -moveInto -viewAudit -eventsList -addEvents -createObject `
    -unlockObject -renameObject | Out-Null

#add owner Vault Admins
$token | Add-PVSafeOwner -safe SomeSafe -owner "Vault Admins" -retrieve -store -delete -administer `
    -backup -manageOwners -validateSafeContent -list -usePassword -updateObjectProperties -initiateCPMChange `
    -initiateCPMChangeWithManualPassword -createFolder -deleteFolder -moveFrom -moveInto -viewAudit `
    -viewPermissions -eventsList -addEvents -createObject -unlockObject -renameObject | Out-Null

#pacli addowner
$token | Add-PVSafeOwner -safe SomeSafe -owner someGroup -retrieve -list -usePassword -viewAudit -viewPermissions | 
    Out-Null

#Close Safe, Logoff, Close Pacli
$token | Close-PVSafe -safe SomeSafe | Disconnect-PVVault | Stop-PVPacli
