<#
.SYNOPSIS
  Create a new song folder under 音樂/ from templates.
#>
param(
  [Parameter(Mandatory = $true)][int]$Number,
  [Parameter(Mandatory = $true)][string]$Title,
  [string]$Key = "C",
  [string]$Time = "4/4",
  [string]$Scripture = "",
  [string]$TempoMark = "",
  [int]$TempoBpm = 80,
  [string]$Version = "01",
  [string]$Accompaniment = ""
)

$ErrorActionPreference = "Stop"
$musicRoot = Split-Path -Parent $PSScriptRoot
$folderName = "{0}-{1}" -f $Number, $Title
$songDir = Join-Path $musicRoot $folderName
$ver = if ($Version -match '^v') { $Version } else { "v$Version" }
$verNum = $ver.TrimStart('v')

if (Test-Path $songDir) {
  Write-Error "Already exists: $songDir"
}

$acc = $Accompaniment
if (-not $acc) {
  if ($Time -eq "3/4") { $acc = "waltz-3/4" } else { $acc = "block" }
}

New-Item -ItemType Directory -Path (Join-Path $songDir "來源") -Force | Out-Null

$meta = @"
number: $Number
title: "$Title"
key: $Key
time: "$Time"
tempo_mark: "$TempoMark"
tempo_bpm: $TempoBpm
scripture: "$Scripture"
accompaniment: $acc
recommended_version: "$ver"
notes: "旋律依官方主旋律譜；左手為個人練習編配"
"@
Set-Content -Path (Join-Path $songDir "song-meta.yaml") -Value $meta -Encoding UTF8

$readmeTpl = Get-Content (Join-Path $musicRoot "_templates\README.md") -Raw -Encoding UTF8
$readme = $readmeTpl.
  Replace("{{NUMBER}}", "$Number").
  Replace("{{TITLE}}", $Title).
  Replace("{{KEY}}", $Key).
  Replace("{{TIME}}", $Time).
  Replace("{{VERSION}}", $ver).
  Replace("{{FOLDER}}", $folderName)
Set-Content -Path (Join-Path $songDir "README.md") -Value $readme -Encoding UTF8

$lyTpl = Get-Content (Join-Path $musicRoot "_templates\主旋律加左手伴奏-v01.ly.tpl") -Raw -Encoding UTF8
$ly = $lyTpl.
  Replace("{{NUMBER}}", "$Number").
  Replace("{{TITLE}}", $Title).
  Replace("{{SCRIPTURE}}", $Scripture).
  Replace("{{KEY}}", $Key).
  Replace("{{TIME}}", $Time).
  Replace("{{TEMPO_MARK}}", $(if ($TempoMark) { $TempoMark } else { " " })).
  Replace("{{TEMPO_BPM}}", "$TempoBpm")
$lyName = "主旋律加左手伴奏-$ver.ly"
Set-Content -Path (Join-Path $songDir $lyName) -Value $ly -Encoding UTF8

Write-Output "Created: $songDir"
Write-Output "Next: put melody image in 來源\主旋律-$ver.* then edit $lyName"
Write-Output "Compile: $($PSScriptRoot)\compile.ps1 -SongDir `"$songDir`" -Score `"主旋律加左手伴奏-$ver`""
