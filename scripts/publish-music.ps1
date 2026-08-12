<#
.SYNOPSIS
  Mirror JW-Work/音樂 to the public GitHub repo yushoudba/JW-Music (one-way).
#>
param(
  [string]$MirrorDir = "C:\Git\JW-Music",
  [string]$PublicRepo = "yushoudba/JW-Music",
  [switch]$SkipPush,
  [string]$Message = "",
  [string]$Song = ""
)

$ErrorActionPreference = "Stop"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
  [System.Environment]::GetEnvironmentVariable("Path", "User")

$musicRoot = Split-Path -Parent $PSScriptRoot
$jwRoot = Split-Path -Parent $musicRoot

function Get-SourceStamp {
  Push-Location $jwRoot
  try {
    $hash = git rev-parse --short HEAD 2>$null
    if (-not $hash) { $hash = "unknown" }
    return $hash
  }
  finally { Pop-Location }
}

function Ensure-Mirror {
  if (-not (Test-Path (Join-Path $MirrorDir ".git"))) {
    $parent = Split-Path $MirrorDir
    if ($parent) {
      New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }
    if (Test-Path $MirrorDir) {
      Remove-Item $MirrorDir -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Output "Cloning $PublicRepo -> $MirrorDir"
    gh repo clone $PublicRepo $MirrorDir
    Push-Location $MirrorDir
    try {
      $prev = $ErrorActionPreference
      $ErrorActionPreference = "Continue"
      git rev-parse --verify HEAD 2>$null | Out-Null
      if ($LASTEXITCODE -ne 0) {
        git checkout -b main 2>$null | Out-Null
      }
      $ErrorActionPreference = $prev
    }
    finally { Pop-Location }
  }
  else {
    Push-Location $MirrorDir
    try {
      git fetch origin 2>$null
      git checkout main 2>$null
      git pull --ff-only origin main 2>$null
    }
    catch {
      Write-Output "Note: pull skipped (empty or new repo)."
    }
    finally { Pop-Location }
  }
}

function Get-SongDirs {
  $skip = @("_templates", "common", "scripts", ".cursor")
  Get-ChildItem $musicRoot -Directory | Where-Object {
    ($skip -notcontains $_.Name) -and (
      $_.Name -match '^\d+-' -or (Test-Path (Join-Path $_.FullName "song-meta.yaml"))
    )
  } | Sort-Object Name
}

function Build-Gallery {
  $lines = New-Object System.Collections.Generic.List[string]
  foreach ($song in (Get-SongDirs)) {
    $name = $song.Name
    $lines.Add("### [$name]($name/)")
    $lines.Add("")
    $pngs = @(Get-ChildItem $song.FullName -Filter "主旋律加左手伴奏-v*-page*.png" -ErrorAction SilentlyContinue | Sort-Object Name)
    if ($pngs.Count -eq 0) {
      $pngs = @(Get-ChildItem $song.FullName -Filter "主旋律加左手伴奏-page*.png" -ErrorAction SilentlyContinue | Sort-Object Name)
    }
    if ($pngs.Count -eq 0) {
      $lines.Add("_No recommended PNG yet._")
      $lines.Add("")
    }
    else {
      foreach ($p in $pngs) {
        $rel = "$name/$($p.Name)"
        $lines.Add("![$($p.BaseName)]($rel)")
        $lines.Add("")
      }
    }
  }
  if ($lines.Count -eq 0) {
    return "_No songs yet._`n"
  }
  return ($lines -join "`n")
}

function Sync-Content {
  Get-ChildItem $MirrorDir -Force | Where-Object { $_.Name -ne ".git" } | ForEach-Object {
    Remove-Item $_.FullName -Recurse -Force
  }

  foreach ($d in @("common", "_templates", "scripts")) {
    $src = Join-Path $musicRoot $d
    if (Test-Path $src) {
      Copy-Item $src (Join-Path $MirrorDir $d) -Recurse -Force
    }
  }

  foreach ($song in (Get-SongDirs)) {
    Copy-Item $song.FullName (Join-Path $MirrorDir $song.Name) -Recurse -Force
  }

  Copy-Item (Join-Path $musicRoot "Music-Sheet-Flow.md") (Join-Path $MirrorDir "Music-Sheet-Flow.md") -Force
  $gi = Join-Path $musicRoot ".gitignore"
  if (Test-Path $gi) {
    Copy-Item $gi (Join-Path $MirrorDir ".gitignore") -Force
  }

  $cursor = Join-Path $MirrorDir ".cursor"
  if (Test-Path $cursor) { Remove-Item $cursor -Recurse -Force }

  Get-ChildItem $MirrorDir -Recurse -File -Filter "compile-last.log" -ErrorAction SilentlyContinue |
    Remove-Item -Force
  Get-ChildItem $MirrorDir -Recurse -File -Filter "*.pdf" -ErrorAction SilentlyContinue |
    Remove-Item -Force

  $tplPath = Join-Path $musicRoot "_templates\PUBLIC-README.md"
  $tpl = Get-Content $tplPath -Raw -Encoding UTF8
  $readme = $tpl.Replace("{{GALLERY}}", (Build-Gallery))
  $utf8NoBom = New-Object System.Text.UTF8Encoding $false
  [System.IO.File]::WriteAllText((Join-Path $MirrorDir "README.md"), $readme, $utf8NoBom)
}

Write-Output "Source: $musicRoot"
Ensure-Mirror
Sync-Content

$stamp = Get-SourceStamp
$date = Get-Date -Format "yyyy-MM-dd HH:mm"
if (-not $Message) {
  $Message = "sync from JW-Work/music ($stamp) at $date"
}

Push-Location $MirrorDir
try {
  git config user.email 2>$null | Out-Null
  if (-not (git config user.email)) {
    git config user.email "yushoudba@users.noreply.github.com"
    git config user.name "yushoudba"
  }

  git add -A
  $status = git status --porcelain
  if (-not $status) {
    Write-Output "No changes to publish."
  }
  else {
    git commit -m $Message
    if (-not $SkipPush) {
      git push -u origin HEAD:main
      Write-Output "Pushed to https://github.com/$PublicRepo"
    }
    else {
      Write-Output "SkipPush: commit created locally only."
    }
  }
}
finally { Pop-Location }

function Write-PublicPngLinks {
  param([string]$SongFilter)
  $base = "https://raw.githubusercontent.com/$PublicRepo/main"
  Write-Output ""
  Write-Output "=== Public PNG links ==="
  $dirs = Get-ChildItem $MirrorDir -Directory | Where-Object {
    $_.Name -match '^\d+-' -or (Test-Path (Join-Path $_.FullName "song-meta.yaml"))
  } | Sort-Object Name
  if ($SongFilter) {
    $dirs = $dirs | Where-Object {
      $_.Name -eq $SongFilter -or $_.Name -like "*$SongFilter*"
    }
  }
  foreach ($d in $dirs) {
    $pngs = @(Get-ChildItem $d.FullName -Filter "主旋律加左手伴奏-v*-page*.png" -ErrorAction SilentlyContinue | Sort-Object Name)
    if ($pngs.Count -eq 0) {
      $pngs = @(Get-ChildItem $d.FullName -Filter "主旋律加左手伴奏-v*.png" -ErrorAction SilentlyContinue | Sort-Object Name)
    }
    foreach ($p in $pngs) {
      $seg1 = [uri]::EscapeDataString($d.Name)
      $seg2 = [uri]::EscapeDataString($p.Name)
      Write-Output "$base/$seg1/$seg2"
    }
  }
  Write-Output "Repo: https://github.com/$PublicRepo"
  if ($SongFilter) {
    $hit = Get-ChildItem $MirrorDir -Directory | Where-Object {
      $_.Name -eq $SongFilter -or $_.Name -like "*$SongFilter*"
    } | Select-Object -First 1
    if ($hit) {
      Write-Output ("Tree: https://github.com/{0}/tree/main/{1}" -f $PublicRepo, [uri]::EscapeDataString($hit.Name))
    }
  }
}

Write-PublicPngLinks -SongFilter $Song
