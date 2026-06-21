# bctx Windows installer
# Usage: irm https://betterctx.com/install.ps1 | iex
#
# Installs the bctx binary to $env:LOCALAPPDATA\bctx\
# and adds it to the user PATH (no admin required).

$ErrorActionPreference = 'Stop'

$REPO    = "better-ctx-org/bctx-releases"
$TARGET  = "x86_64-pc-windows-msvc"
$INSTALL = "$env:LOCALAPPDATA\bctx"

Write-Host ""
Write-Host "  bctx installer for Windows" -ForegroundColor Cyan
Write-Host ""

# ── Fetch latest version ──────────────────────────────────────────────────────

Write-Host "  Checking latest release..." -NoNewline
$release = Invoke-RestMethod "https://api.github.com/repos/$REPO/releases/latest"
$VERSION = $release.tag_name -replace '^v', ''
Write-Host " v$VERSION" -ForegroundColor Green

# ── Download archive ──────────────────────────────────────────────────────────

$ARCHIVE  = "bctx-$VERSION-$TARGET.tar.gz"
$URL      = "https://github.com/$REPO/releases/download/v$VERSION/$ARCHIVE"
$TMP_DIR  = Join-Path $env:TEMP "bctx-install-$VERSION"
$TMP_FILE = Join-Path $TMP_DIR $ARCHIVE

New-Item -ItemType Directory -Path $TMP_DIR -Force | Out-Null

Write-Host "  Downloading $ARCHIVE..." -NoNewline
Invoke-WebRequest -Uri $URL -OutFile $TMP_FILE -UseBasicParsing
Write-Host " done" -ForegroundColor Green

# ── Extract ───────────────────────────────────────────────────────────────────

Write-Host "  Extracting..." -NoNewline
# tar.exe is built into Windows 10 1803+ and Server 2019+
& tar.exe -xzf $TMP_FILE -C $TMP_DIR
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "  Error: tar extraction failed." -ForegroundColor Red
    Write-Host "  Download manually from: https://github.com/$REPO/releases" -ForegroundColor Yellow
    exit 1
}
Write-Host " done" -ForegroundColor Green

# ── Install ───────────────────────────────────────────────────────────────────

New-Item -ItemType Directory -Path $INSTALL -Force | Out-Null
Copy-Item "$TMP_DIR\bctx.exe" "$INSTALL\bctx.exe" -Force
Remove-Item $TMP_DIR -Recurse -Force
Write-Host "  Installed to $INSTALL\bctx.exe" -ForegroundColor Green

# ── Add to PATH (user-level, no admin) ───────────────────────────────────────

$CURRENT_PATH = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($CURRENT_PATH -notlike "*$INSTALL*") {
    [Environment]::SetEnvironmentVariable(
        "PATH",
        "$CURRENT_PATH;$INSTALL",
        "User"
    )
    Write-Host "  Added $INSTALL to user PATH" -ForegroundColor Green
} else {
    Write-Host "  $INSTALL already in PATH" -ForegroundColor Gray
}

# ── Done ──────────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "  bctx v$VERSION installed." -ForegroundColor Cyan
Write-Host "  Restart your terminal, then run: bctx --version"
Write-Host ""
Write-Host "  Note: PATH changes take effect in new terminal windows only."
Write-Host ""
