$BuildType="Release"
$BuildDir="build"
$VDA="VirtualDesktopAccessor"

if (Test-Path -LiteralPath "$VDA.dll") {
  Remove-Item -Force -Path "$VDA.dll"
}

cmake `
    -S . `
    -B $BuildDir `
    -A x64

cmake `
    --build $BuildDir `
    --target $VDA `
    --config $BuildType

try {
    Get-Item ".\$BuildDir\deps\$VDA\$BuildType\$VDA.dll"
    Copy-Item -Path ".\$BuildDir\deps\$VDA\$BuildType\$VDA.dll" -Destination .
    Write-Host "Successfully compiled $VDA.dll"
} catch {
    Write-Host "Failed to compile $VDA.dll; file not found."
    exit 1
}

