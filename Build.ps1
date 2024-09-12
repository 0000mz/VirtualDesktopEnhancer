$BuildType="Release"
$BuildDir="build"
$VDA="VirtualDesktopAccessor"

cmake `
    -S . `
    -B $BuildDir `
    -A x64

cmake `
    --build $BuildDir `
    --target $VDA `
    --config $BuildType

try {
    $VirtualDesktopAccessorDll = Get-Item ".\$BuildDir\deps\$VDA\$BuildType\$VDA.dll"
    Write-Host "Successfully compiled $VDA.dll"
} catch {
    Write-Host "Failed to compile $VDA.dll; file not found."
    exit 1
}

