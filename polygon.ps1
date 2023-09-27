$cwd = (Get-Location).Path;

# Get the latest version from tag
git pull;
$latestTag = git describe --tags --abbrev=0;
$versionNumber = (Select-String -Pattern "\d+\.\d+\.\d+" -InputObject $latestTag).Matches[0].Value

Write-Host "Building Polygon version $versionNumber" -ForegroundColor Green;

# Clean build folder
Remove-Item -Path "$cwd\build" -Recurse -Force -ErrorAction SilentlyContinue;
New-Item -Path "$cwd\build" -ItemType Directory;

# Download AutoHotkey
$ahkFileNamePattern = "AutoHotkey_.*\.zip"
$ahkLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/AutoHotkey/AutoHotkey/releases/latest";
$ahkDownloadURL = ($ahkLatestRelease.assets | Where-Object { $_.name -match "$ahkFileNamePattern" }) | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $ahkDownloadURL -OutFile "$cwd\build\autohotkey.zip";
Expand-Archive -Path "$cwd\build\autohotkey.zip" -DestinationPath "$cwd\build\ahk";

Write-Host "Downloaded the latest release from AutoHotkey into `"$cwd\build\ahk\`"" -ForegroundColor Green;

# Download Ahk2Exe
$ahk2ExeFileNamePattern = "Ahk2Exe.*\.zip"
$ahk2ExeLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/AutoHotkey/Ahk2Exe/releases/latest";
$ahk2ExeDownloadURL = ($ahk2ExeLatestRelease.assets | Where-Object { $_.name -match "$ahk2ExeFileNamePattern" }) | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $ahk2ExeDownloadURL -OutFile "$cwd\build\Ahk2exe.zip";
Expand-Archive -Path "$cwd\build\Ahk2exe.zip" -DestinationPath "$cwd\build\ahk";

Write-Host "Downloaded the latest release from Ahk2Exe into `"$cwd\build\ahk\`"" -ForegroundColor Green;

# Download Wix3
$wixFileNamePattern = "wix311-binaries.zip"
$wixLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/wixtoolset/wix3/releases/latest";
$wixDownloadURL = ($wixLatestRelease.assets | Where-Object { $_.name -match "$wixFileNamePattern" }) | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $wixDownloadURL -OutFile "$cwd\build\$wixFileNamePattern";
Expand-Archive -Path "$cwd\build\$wixFileNamePattern" -DestinationPath "$cwd\build\wix\";

Write-Host "Downloaded the latest release from Wix3 into `"$cwd\build\wix\`"" -ForegroundColor Green;

& "$cwd\build\ahk\Ahk2Exe.exe" /in polygon.ahk /out "$cwd\build\polygon-x64.exe" /icon logo.ico /base "$cwd\build\ahk\AutoHotkey64.exe";
& "$cwd\build\ahk\Ahk2Exe.exe" /in polygon.ahk /out "$cwd\build\polygon-x86.exe" /icon logo.ico /base "$cwd\build\ahk\AutoHotkey32.exe";

Write-Host "Polygon binaries built successfully into `"$cwd\build\`"" -ForegroundColor Green;

& "$cwd\build\wix\candle.exe" .\polygon.wxs -out "$cwd\build\polygon-x86.wixobj" -dVersion="$versionNumber" -arch x86;
& "$cwd\build\wix\candle.exe" .\polygon.wxs -out "$cwd\build\polygon-x64.wixobj" -dVersion="$versionNumber" -arch x64;

& "$cwd\build\wix\light.exe" "$cwd\build\polygon-x86.wixobj" -ext WixUIExtension -out "$cwd\build\polygon-x86.msi";
& "$cwd\build\wix\light.exe" "$cwd\build\polygon-x64.wixobj" -ext WixUIExtension -out "$cwd\build\polygon-x64.msi";

Write-Host "Polygon installers built successfully into `"$cwd\build\`"" -ForegroundColor Green;
