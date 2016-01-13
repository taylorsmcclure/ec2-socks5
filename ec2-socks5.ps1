# Variables
# Put in your SOCKS5 EC2 Linux instance ID here
$ins=""
$regKey="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
# Input your path to PUTTY.EXE here
$putty=""
# Input your AWS PS profile here
$profile=""
# Input your AWS region here
$region=""
$wininet = Add-Type -memberDefinition $source -passthru -name InternetSettings
$source=@"

[DllImport("wininet.dll")]

public static extern bool InternetSetOption(int hInternet, int dwOption, int lpBuffer, int dwBufferLength);  

"@

# Import AWS for PS and loads profile and region
Import-Module "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\AWSPowerShell.psd1"
Initialize-AWSDefaults -ProfileName $profile -Region $region

Write-Host "1. Start SOCKS5 EC2 Instance `n
2. Stop SOCKS5 EC2 Instance `n"

$response = Read-Host -Prompt "1 or 2: "

If ($response -eq "1")
{
	Start-EC2Instance -InstanceIds $ins
	Write-Host "`nTurning on Proxy settings in Internet Settings..."
	Set-ItemProperty -path $regKey ProxyEnable -value 1
    #INTERNET_OPTION_PROXY_SETTINGS_CHANGED
    $wininet::InternetSetOption([IntPtr]::Zero, 95, [IntPtr]::Zero, 0)|out-null
    #INTERNET_OPTION_REFRESH
    $wininet::InternetSetOption([IntPtr]::Zero, 37, [IntPtr]::Zero, 0)|out-null
	Write-Host "Launching Putty..."
	Invoke-Item $putty
	Write-Host "Your instance '$ins' is starting, please wait till it is running."
	Start-Sleep -s 5
}
ElseIf ($response -eq "2")
{
	Stop-EC2Instance -Instance $ins
	Set-ItemProperty -path $regKey ProxyEnable -value 0
    #INTERNET_OPTION_PROXY_SETTINGS_CHANGED
    $wininet::InternetSetOption([IntPtr]::Zero, 95, [IntPtr]::Zero, 0)|out-null
    #INTERNET_OPTION_REFRESH
    $wininet::InternetSetOption([IntPtr]::Zero, 37, [IntPtr]::Zero, 0)|out-null
	Write-Host "`nYour instance '$ins' is stopping..."
	Start-Sleep -s 5
}
Else
{
	Write-Host "Please enter 1 or 2, and try again."
}
