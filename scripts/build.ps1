# Build without Python or external dependencies. Windows PowerShell 5.1+.
$ErrorActionPreference = 'Stop'
try {
    $root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
    $dist = Join-Path $root 'dist'
    $targets = @('chromium', 'firefox')
    $shared = @('background.js', 'popup.html', 'popup.js')
    $versions = @()

    foreach ($target in $targets) {
        $manifestPath = Join-Path $root "$target\manifest.json"
        if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
            throw "Fichier manquant : $manifestPath"
        }
        $manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($manifest.manifest_version -ne 3) { throw "Manifest V3 attendu pour $target" }
        if ([string]::IsNullOrWhiteSpace($manifest.version)) { throw "Version absente pour $target" }
        $versions += [string]$manifest.version
    }
    if ($versions[0] -ne $versions[1]) {
        throw "Versions differentes : Chromium=$($versions[0]), Firefox=$($versions[1])"
    }
    $version = $versions[0]

    foreach ($filename in $shared) {
        $source = Join-Path $root "common\$filename"
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Fichier manquant : $source" }
    }

    if (Test-Path -LiteralPath $dist) { Remove-Item -LiteralPath $dist -Recurse -Force }
    New-Item -ItemType Directory -Path $dist | Out-Null
    foreach ($target in $targets) {
        $destination = Join-Path $dist $target
        New-Item -ItemType Directory -Path $destination | Out-Null
        Copy-Item -LiteralPath (Join-Path $root "$target\manifest.json") -Destination (Join-Path $destination 'manifest.json')
        foreach ($filename in $shared) {
            Copy-Item -LiteralPath (Join-Path $root "common\$filename") -Destination (Join-Path $destination $filename)
        }
        Write-Host "Prepare : $destination"
    }

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $firefoxDir = Join-Path $dist 'firefox'
    $archive = Join-Path $dist "mypeugeot-oauth-code-extractor-firefox-v$version-unsigned.zip"
    [System.IO.Compression.ZipFile]::CreateFromDirectory($firefoxDir, $archive, [System.IO.Compression.CompressionLevel]::Optimal, $false)
    Write-Host "ZIP Firefox non signe : $archive"
    Write-Host 'Chromium : empaqueter dist\chromium dans Edge (conserver la cle PEM existante).'
    Write-Host 'Firefox : soumettre le ZIP non signe a Mozilla pour signature.'
    exit 0
} catch {
    Write-Host "ERREUR : $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
