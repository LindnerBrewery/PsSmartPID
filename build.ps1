[cmdletbinding(DefaultParameterSetName = 'Task')]
param(
    # Build task(s) to execute
    [parameter(ParameterSetName = 'task', position = 0)]
    [string[]]$Task = 'default',

    # Bootstrap dependencies
    [switch]$Bootstrap,

    # List available build tasks
    [parameter(ParameterSetName = 'Help')]
    [switch]$Help,

    # Optional properties to pass to psake
    [hashtable]$Properties
)

$ErrorActionPreference = 'Stop'

# Bootstrap dependencies
if ($Bootstrap.IsPresent) {
    if (-not (Get-PackageProvider -Name "NuGet" -Force -ErrorAction SilentlyContinue)) {
        Write-Output "Install PackageProvider NuGet"
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
    } else {
        Write-Output "PackageProvider NuGet already installed."
    }
    if (!(Get-PackageSource -name nuget.org -ErrorAction SilentlyContinue)) {
        #$name = (Get-PackageSource -Location "https://www.nuget.org/api/v2" -ErrorAction SilentlyContinue).providername
        Write-Host "Registering nuget under the name nuget.org"
        Register-PackageSource -Trusted -name nuget.org -ProviderName nuget -location "https://www.nuget.org/api/v2"
    }
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    if ((Test-Path -Path ./requirements.psd1)) {
        if (-not (Get-Module -Name PSDepend -ListAvailable)) {
            Install-Module -Name PSDepend -Repository PSGallery -Scope CurrentUser -Force
        }
        Import-Module -Name PSDepend -Verbose:$false
        Invoke-PSDepend -Path './requirements.psd1' -Install -Import -Force -WarningAction SilentlyContinue
    } else {
        Write-Warning "No [requirements.psd1] found. Skipping build dependency installation."
    }
}

# Execute psake task(s)
$psakeFile = './psakeFile.ps1'
if ($PSCmdlet.ParameterSetName -eq 'Help') {
    Get-PSakeScriptTasks -buildFile $psakeFile |
        Format-Table -Property Name, Description, Alias, DependsOn
} else {
    Set-BuildEnvironment -Force
    Invoke-psake -buildFile $psakeFile -taskList $Task -nologo -properties $Properties
    exit ([int](-not $psake.build_success))
}
