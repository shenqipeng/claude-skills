# Install MCU Ironclad skills for OpenCode (Windows PowerShell)
# Usage: .\install-opencode.ps1
#
# After cloning: git clone https://github.com/shenqipeng/mcu-ironclad.git
#                cd mcu-ironclad; .\install-opencode.ps1

param()

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigDir = if ($env:OPENCODE_CONFIG_DIR) { $env:OPENCODE_CONFIG_DIR } else { Join-Path $env:USERPROFILE ".config\opencode" }

Write-Host "=== MCU Ironclad — OpenCode Installer ==="
Write-Host "Repo:      $ScriptDir"
Write-Host "Config:    $ConfigDir"
Write-Host ""

# 1. Ensure config directory exists
New-Item -ItemType Directory -Path $ConfigDir -Force | Out-Null

# 2. Add plugin path to opencode.json
$ConfigFile = Join-Path $ConfigDir "opencode.json"
# Normalize path for JSON: backslashes to forward slashes
$RepoPathJson = $ScriptDir.Replace('\', '/')

Write-Host "[1/2] Configuring opencode.json..."

if (Test-Path $ConfigFile) {
    $config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
    
    # Check if plugin array exists
    if (-not ($config.PSObject.Properties.Name -contains "plugin")) {
        $config | Add-Member -MemberType NoteProperty -Name "plugin" -Value @()
    }
    
    # Check if already configured
    $alreadyConfigured = $false
    foreach ($p in $config.plugin) {
        if ($p -eq $RepoPathJson -or $p -eq $ScriptDir) {
            $alreadyConfigured = $true
            break
        }
    }
    
    if ($alreadyConfigured) {
        Write-Host "  -> Plugin already configured in opencode.json"
    } else {
        # Add plugin path
        $config.plugin += $RepoPathJson
        $config | ConvertTo-Json -Depth 10 | Set-Content $ConfigFile -Encoding UTF8
        Write-Host "  -> Added plugin path to opencode.json"
    }
} else {
    # Create new config
    $newConfig = @{
        '$schema' = "https://opencode.ai/config.json"
        plugin = @($RepoPathJson)
    } | ConvertTo-Json -Depth 10
    Set-Content $ConfigFile -Value $newConfig -Encoding UTF8
    Write-Host "  -> Created opencode.json with plugin path"
}

# 3. Verify
Write-Host ""
Write-Host "[2/2] Verifying installation..."

$skillCount = (Get-ChildItem (Join-Path $ScriptDir "skills") -Directory).Count
$pluginFile = Join-Path $ScriptDir ".opencode\plugins\superpowers.js"

if (Test-Path $pluginFile) {
    Write-Host "  -> Plugin: OK ($pluginFile)"
} else {
    Write-Host "  -> Plugin: MISSING ($pluginFile)"
}

Write-Host "  -> Skills: $skillCount found in $ScriptDir\skills\"

Write-Host ""
Write-Host "=== Installation Complete ==="
Write-Host ""
Write-Host "Skills are auto-discovered via the plugin's config hook."
Write-Host "The superpowers.js plugin will:"
Write-Host "  1. Register ALL 25 skills from skills/ (14 core + 11 independent)"
Write-Host "  2. Inject 'using-superpowers' bootstrap on session start"
Write-Host "  3. Run health check for skill graph integrity"
Write-Host ""
Write-Host "Restart OpenCode to load the skills."
Write-Host ""
Write-Host "To update later: cd $ScriptDir; git pull"
