# Allow local script execution
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force

# Check if the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Lance ce script en tant qu'administrateur."
    exit
}

Write-Host "[*] Optimisation complète de Windows 11 en cours..."

# Disable Widgets (Windows 11 replacement for News and Interests)
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0
    Write-Host "Widgets désactivés."
} catch {}

# Disable Cortana
try {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0
    Write-Host "Cortana désactivé."
} catch {}

# Disable tips, tricks, and suggestions
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0
    Write-Host "Conseils et suggestions désactivés."
} catch {}

# Disable Start Menu app suggestions
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_NotifyNewApps" -Value 0
    Write-Host "Suggestions du menu Démarrer désactivées."
} catch {}

# Disable ads in Explorer
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value 0
    Write-Host "Publicités Explorateur désactivées."
} catch {}

# Disable Timeline
try {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0
    Write-Host "Timeline désactivée."
} catch {}

# Uninstall OneDrive
try {
    Start-Process "taskkill.exe" -ArgumentList "/f /im OneDrive.exe" -Wait -ErrorAction SilentlyContinue
    Start-Process "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait -ErrorAction SilentlyContinue
    Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait -ErrorAction SilentlyContinue
    Write-Host "OneDrive désinstallé."
} catch {}

# Uninstall unnecessary apps
Write-Host "[*] Désinstallation des applications inutiles..."
$apps = @(
    "Microsoft.3DBuilder", "Microsoft.XboxApp", "Microsoft.Xbox.TCUI",
    "Microsoft.XboxGameOverlay", "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxSpeechToTextOverlay", "Microsoft.XboxIdentityProvider",
    "Microsoft.OneConnect", "Microsoft.People", "Microsoft.BingNews",
    "Microsoft.MicrosoftSolitaireCollection", "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo", "Microsoft.Microsoft3DViewer", "Microsoft.GetHelp",
    "Microsoft.Getstarted", "Microsoft.WindowsAlarms", "Microsoft.WindowsCamera",
    "Microsoft.WindowsMaps", "Microsoft.Messaging", "Microsoft.SkypeApp",
    "Microsoft.OneDrive"
)
foreach ($app in $apps) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}
Write-Host "Applications inutiles désinstallées."

# Disable SmartScreen
try {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Value 0
    Write-Host "SmartScreen désactivé."
} catch {}

# Disable Windows Defender AntiSpyware (only if necessary)
try {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1
    Write-Host "Windows Defender désactivé (anti spyware)."
} catch {}

# Disable telemetry
try {
    Stop-Service -Name DiagTrack -Force
    Set-Service -Name DiagTrack -StartupType Disabled
    Write-Host "Télémétrie désactivée."
} catch {}

# Disable animations and transparency
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00))
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0
    Write-Host "Animations et effets visuels désactivés."
} catch {}

# Disable UAC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0
Write-Host "UAC désactivé."

# Disable non-critical services
Write-Host "Désactivation de services non critiques..."
$services = @(
    "DiagTrack", "dmwappushservice", "WSearch", "SysMain",
    "WerSvc", "Fax", "PrintNotify", "RetailDemo",
    "XblGameSave", "XboxNetApiSvc", "Spooler"
)
foreach ($s in $services) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled
}

# Disable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Delete telemetry scheduled tasks
Write-Host "Suppression des tâches planifiées de télémétrie..."
$tasks = @(
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater",
    "\Microsoft\Windows\Autochk\Proxy",
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask",
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
)
foreach ($t in $tasks) {
    try {
        Unregister-ScheduledTask -TaskName ($t.Split('\')[-1]) -TaskPath ($t.Replace("\" + ($t.Split('\')[-1]), "")) -Confirm:$false -ErrorAction SilentlyContinue
    } catch {}
}

# Disable background apps
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1
Write-Host "Applications en arrière-plan désactivées."

# Disable Edge and Cortana preloading
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d 0 /f
Write-Host "Préchargement Edge et Cortana désactivé."

# Reduce virtual memory usage
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Value 0

# Final message
Write-Host "`n[OK] Optimisation complète de Windows 11 terminée. Redémarre la machine pour appliquer tous les changements."

