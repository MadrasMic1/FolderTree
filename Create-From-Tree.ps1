<#
.SYNOPSIS
    Creates folder and file structure from an indented tree diagram file.

.DESCRIPTION
    Reads a tree structure from a text file and creates directories and files
    at a specified target location.

.PARAMETER TreeFile
    Path to the tree structure file (relative to script location).

.PARAMETER TargetPath
    Full absolute path where structure should be created (e.g., "F:\Openwebui").

.PARAMETER RootPath
    Root path for the created structure (default: TargetPath).
#>

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$TreeFile,

    [string]$TargetPath = "",

    [string]$RootPath = "."
)

# Use TargetPath if provided, otherwise use RootPath
$targetLocation = if ($TargetPath) { $TargetPath } else { $RootPath }

# Normalize path (remove double backslashes, ensure it's absolute)
$targetLocation = $targetLocation -replace '\\{2,}', '\'

# Check if target location is absolute
if ($targetLocation -notmatch '^([A-Za-z]:)?\\') {
    # Make it absolute relative to script location
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $targetLocation = Join-Path $scriptDir $targetLocation
}

# Check if tree file exists
if (-not (Test-Path $TreeFile)) {
    Write-Error "Tree file not found: $TreeFile"
    return
}

Write-Host "Reading tree file: $TreeFile" -ForegroundColor Cyan

# Read file with UTF8 encoding
$treeContent = Get-Content -Path $TreeFile -Encoding UTF8 -Raw -ErrorAction Stop

Write-Host "`nParsing tree structure..." -ForegroundColor Cyan

$structure = @{}
$indentStack = @()

foreach ($line in $treeContent -split "`n") {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    
    # Remove visual tree characters (├, └, ┤, │, ─, etc.)
    $cleaned = $line -replace '[├└┤│─┬┴]', ''
    
    # Calculate indentation (count leading spaces)
    $indent = [regex]::Match($cleaned, '^\s*').Groups[0].Value
    $indentLevel = $indent.Length / 2  # 2 spaces per level
    
    # Get the item name
    $name = $cleaned.Trim()
    $isDirectory = $name.EndsWith('/')
    if ($isDirectory) {
        $name = $name.TrimEnd('/')
    }
    
    # Pop stack for items at same or lower indentation
    while ($indentStack.Count -gt 0 -and $indentLevel -le $indentStack[-1].Indent) {
        $indentStack = $indentStack[0..($indentStack.Count - 2)]
    }
    
    # Add to structure
    $structure[$name] = @{
        Type = if ($isDirectory) { 'Directory' } else { 'File' }
        Indent = $indentLevel
    }
    
    # Push to stack
    $indentStack += @{ Name = $name; Indent = $indentLevel }
}

Write-Host "`nFound $($structure.Count) items in tree" -ForegroundColor Cyan

# Create structure at target location
Write-Host "`nCreating structure at: $targetLocation" -ForegroundColor Cyan
$created = @()
$errors = $null

foreach ($key in $structure.Keys) {
    $path = Join-Path $targetLocation $key
    $item = $structure[$key]
    
    try {
        if ($item.Type -eq 'Directory') {
            if (-not (Test-Path $path)) {
                New-Item -ItemType Directory -Path $path -Force | Out-Null
                $created += "Directory: $path"
                Write-Host "  ✓ Directory: $path" -ForegroundColor Green
            }
        }
        elseif ($item.Type -eq 'File') {
            if (-not (Test-Path $path)) {
                New-Item -ItemType File -Path $path -Force | Out-Null
                $created += "File: $path"
                Write-Host "  ✓ File: $path" -ForegroundColor Green
            }
        }
    }
    catch {
        Write-Host "  ✗ Error creating $($key): $_" -ForegroundColor Red
    }
}

# Summary
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "Target location: $targetLocation" -ForegroundColor Yellow
Write-Host "Total items created: $($created.Count)" -ForegroundColor Yellow

if ($errors) {
    Write-Host "`nErrors encountered:" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host "  ✗ $error" -ForegroundColor Red
    }
}

Write-Host "`n✓ Structure created successfully at: $targetLocation" -ForegroundColor Green