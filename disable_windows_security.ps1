Write-Host "============================="
Write-Host "   Starting Windows Security Deactivation"
Write-Host "============================="

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "   Please re-run PowerShell as Administrator."
    exit
}

Write-Host "`n[1/3]    Turning off Tamper Protection..."
Write-Host "   This feature cannot be disabled directly via PowerShell."
Write-Host "   Please disable it manually:"
Write-Host "   [Settings -> Privacy & Security -> Windows Security -> Virus & threat protection -> Manage settings]"
Write-Host "   -> Turn off 'Tamper Protection'."
Write-Host "After Tamper Protection is disabled, press any key to continue."
Pause

Write-Host "`n[2/3]   Disabling Windows Defender and real-time protection..."
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableBlockAtFirstSeen $true
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisablePrivacyMode $true
Set-MpPreference -DisableIntrusionPreventionSystem $true
Set-MpPreference -DisableArchiveScanning $true
Set-MpPreference -DisableRemovableDriveScanning $true
Set-MpPreference -DisableScanningNetworkFiles $true
Set-MpPreference -MAPSReporting 0
Set-MpPreference -SubmitSamplesConsent 2

Write-Host "`n[3/3]    Checking current security settings..."
Get-MpPreference | Select-Object DisableRealtimeMonitoring, DisableBehaviorMonitoring, DisableIOAVProtection, MAPSReporting, SubmitSamplesConsent | Format-List

Write-Host "`n   Real-time protection and related features have been disabled."
Write-Host "   Some changes will only apply after Tamper Protection is turned off."
Write-Host "============================="
Write-Host "   A system reboot is recommended after completion."
Write-Host "============================="
