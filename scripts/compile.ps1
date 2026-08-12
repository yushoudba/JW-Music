<#
.SYNOPSIS
  Compile a LilyPond score to PNG only (delete any sibling PDF produced).
#>
param(
  [Parameter(Mandatory = $true)][string]$SongDir,
  [Parameter(Mandatory = $true)][string]$Score,
  [int]$Resolution = 140,
  [switch]$Publish
)

$ErrorActionPreference = "Stop"

function Find-LilyPond {
  $cmd = Get-Command lilypond -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }

  $candidates = @(
    "C:\Tools\LilyPond\lilypond-2.26.0\bin\lilypond.exe",
    "C:\Tools\LilyPond\lilypond-2.24.3\bin\lilypond.exe"
  )
  foreach ($c in $candidates) {
    if (Test-Path $c) { return $c }
  }

  $local = Join-Path $env:LOCALAPPDATA "LilyPond"
  if (Test-Path $local) {
    $found = Get-ChildItem $local -Recurse -Filter "lilypond.exe" -ErrorAction SilentlyContinue |
      Select-Object -First 1 -ExpandProperty FullName
    if ($found) { return $found }
  }

  $pf = Get-ChildItem "C:\Program Files\LilyPond" -Recurse -Filter "lilypond.exe" -ErrorAction SilentlyContinue |
    Select-Object -First 1 -ExpandProperty FullName
  if ($pf) { return $pf }

  return $null
}

$songDirFull = (Resolve-Path $SongDir).Path
$lyPath = Join-Path $songDirFull ($Score + ".ly")
if (-not (Test-Path $lyPath)) {
  Write-Error "Score not found: $lyPath"
}

$lily = Find-LilyPond
if (-not $lily) {
  Write-Error @"
lilypond.exe not found.
Install from https://lilypond.org/download.zh.html
Expected: C:\Tools\LilyPond\lilypond-2.26.0\bin\lilypond.exe
"@
}

Write-Output "Using: $lily"
Write-Output "Compiling: $lyPath"

$logPath = Join-Path $songDirFull "compile-last.log"
Push-Location $songDirFull
try {
  $args = @(
    "--png",
    "-dresolution=$Resolution",
    $lyPath
  )
  # Capture output without NativeCommandError noise from stderr progress lines.
  $logFile = New-TemporaryFile
  try {
    $p = Start-Process -FilePath $lily -ArgumentList $args -WorkingDirectory $songDirFull `
      -RedirectStandardOutput $logFile.FullName -RedirectStandardError "$($logFile.FullName).err" `
      -Wait -PassThru -NoNewWindow
    $exitCode = $p.ExitCode
    $outText = @()
    if (Test-Path $logFile.FullName) { $outText += Get-Content $logFile.FullName -ErrorAction SilentlyContinue }
    if (Test-Path "$($logFile.FullName).err") { $outText += Get-Content "$($logFile.FullName).err" -ErrorAction SilentlyContinue }
    $outText | Out-File -FilePath $logPath -Encoding UTF8
    $outText | ForEach-Object { Write-Output $_ }
  }
  finally {
    Remove-Item $logFile.FullName -Force -ErrorAction SilentlyContinue
    Remove-Item "$($logFile.FullName).err" -Force -ErrorAction SilentlyContinue
  }
  if ($exitCode -ne 0) {
    Write-Error "lilypond failed (exit $exitCode). See $logPath"
  }
}
finally {
  Pop-Location
}
# Remove PDF produced alongside PNG (PNG-only policy)
$pdf = Join-Path $songDirFull ($Score + ".pdf")
if (Test-Path $pdf) {
  Remove-Item $pdf -Force
  Write-Output "Removed PDF (PNG-only): $pdf"
}

# Also remove page-less single pdf variants if any
Get-ChildItem $songDirFull -Filter ($Score + "*.pdf") -ErrorAction SilentlyContinue | ForEach-Object {
  Remove-Item $_.FullName -Force
  Write-Output "Removed PDF: $($_.FullName)"
}

$pngs = Get-ChildItem $songDirFull -Filter ($Score + "*.png") -ErrorAction SilentlyContinue
if (-not $pngs) {
  Write-Error "No PNG produced for $Score. See $logPath"
}

Write-Output "OK PNG:"
$pngs | ForEach-Object { Write-Output "  $($_.Name)" }

if ($Publish) {
  $publishScript = Join-Path $PSScriptRoot "publish-music.ps1"
  $songName = Split-Path $songDirFull -Leaf
  Write-Output ""
  Write-Output "Publishing to JW-Music main..."
  & $publishScript -Song $songName
}
