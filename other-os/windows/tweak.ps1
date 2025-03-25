# Exécute ce script en tant qu’administrateur

 
# ----------------------------------------
# Désactive Windows Defender (AV + interface)
# ----------------------------------------
Set-MpPreference -DisableRealtimeMonitoring $true
Stop-Service -Name WinDefend -Force
Set-Service -Name WinDefend -StartupType Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f

# ----------------------------------------
# Désactive le pare-feu
# ----------------------------------------
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# ----------------------------------------
# Désactive Windows Update
# ----------------------------------------
Stop-Service -Name wuauserv -Force
Set-Service -Name wuauserv -StartupType Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

# ----------------------------------------
# Désactive Cortana
# ----------------------------------------
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

# ----------------------------------------
# Supprime OneDrive (même à l’install)
# ----------------------------------------
taskkill /f /im OneDrive.exe
Start-Process "C:\Windows\SysWOW64\OneDriveSetup.exe" "/uninstall" -Wait

# ----------------------------------------
# Désinstalle toutes les apps UWP restantes sauf Store et Edge si nécessaire
# ----------------------------------------
# Get-AppxPackage | where-object {$_.Name -notmatch "Store|Edge"} | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage | Remove-AppxPackage -ErrorAction SilentlyContinue

# ----------------------------------------
# Désactive des services non essentiels
# ----------------------------------------
$servicesToDisable = @(
    "DiagTrack",
    "WSearch",
    "SysMain",
    "Themes",
    "Fax",
    "XblGameSave",
    "XboxNetApiSvc",
    "XblAuthManager",
    "BthAvctpSvc",
    "WMPNetworkSvc",
    "MapsBroker",
    "PrintSpooler",
    "OneSyncSvc",
    "CDPSvc",
    "RetailDemo",
    "WerSvc",
    "SecurityHealthService",
    "WbioSrvc",
    "TabletInputService",
    "LanmanWorkstation",
    "LanmanServer",
    "NetTcpPortSharing"
)

foreach ($svc in $servicesToDisable) {
    Stop-Service -Name $svc -ErrorAction SilentlyContinue -Force
    Set-Service -Name $svc -StartupType Disabled
}

# ----------------------------------------
# Désactive les tâches planifiées
# ----------------------------------------
$tasksToDisable = @(
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater",
    "\Microsoft\Windows\Autochk\Proxy",
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask",
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector",
    "\Microsoft\Windows\Maintenance\WinSAT",
    "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem",
    "\Microsoft\Windows\Shell\FamilySafetyMonitor",
    "\Microsoft\Windows\Shell\FamilySafetyRefresh",
    "\Microsoft\Windows\Feedback\Siuf\DmClient",
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
)

foreach ($task in $tasksToDisable) {
    schtasks /Change /TN $task /Disable | Out-Null
}

# ----------------------------------------
# Supprime les applications inutiles
# ----------------------------------------
$appsToRemove = @(
    "Microsoft.XboxApp",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.WindowsMaps",
    "Microsoft.BingWeather",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "Microsoft.SkypeApp",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.People",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.XboxGameCallableUI",
    "Microsoft.OneConnect",
    "Microsoft.Todos",
    "Microsoft.YourPhone",
    "Microsoft.Messaging",
    "Microsoft.MicrosoftOfficeHub"
)

foreach ($app in $appsToRemove) {
    Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# ----------------------------------------
# Désactive les effets visuels
# ----------------------------------------
$performanceKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
New-Item -Path $performanceKey -Force | Out-Null
New-ItemProperty -Path $performanceKey -Name "VisualFXSetting" -PropertyType DWord -Value 2 -Force

# ----------------------------------------
# Active le plan de performance maximale
# ----------------------------------------
powercfg /setactive SCHEME_MIN

# ----------------------------------------
# Vide les fichiers temporaires
# ----------------------------------------
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
# ----------------------------------------
# Désactive les apps en arrière-plan
# ----------------------------------------
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

# ----------------------------------------
# Désactive les notifications
# ----------------------------------------
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -PropertyType DWord -Value 0 -Force

# ----------------------------------------
# Purge les journaux d’événements
# ----------------------------------------
wevtutil el | ForEach-Object { wevtutil cl $_ }

# ----------------------------------------
# Cache le centre de sécurité, notifications, etc.
# ----------------------------------------
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\DisableNotificationCenter" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /t REG_DWORD /d 1 /f


# ----------------------------------------
# Empêche les applications de se lancer en arrière-plan
# ----------------------------------------
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f


# Liste tous les composants installés
DISM /Online /Get-Features /Format:Table

# Supprime un composant (ex. Windows Media Player)
DISM /Online /Disable-Feature /FeatureName:WindowsMediaPlayer /Remove
DISM /Online /Disable-Feature /FeatureName:Printing-PrintToPDFServices-Features /Remove
DISM /Online /Disable-Feature /FeatureName:Printing-XPSServices-Features /Remove
DISM /Online /Disable-Feature /FeatureName:WorkFolders-Client /Remove
DISM /Online /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /Remove
DISM /Online /Disable-Feature /FeatureName:SimpleTCP /Remove
DISM /Online /Disable-Feature /FeatureName:SMB1Protocol /Remove
DISM /Online /Disable-Feature /FeatureName:FaxServicesClientPackage /Remove
DISM /Online /Disable-Feature /FeatureName:MediaPlayback /Remove
DISM /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /Remove
 
Write-Output "Optimisation extrême terminée. Redémarre la machine."











