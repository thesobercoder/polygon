$cwd = (Get-Location).Path;

# Declare variable to check if running on GitHub action
$isGitHubActions = if ($env:GITHUB_ACTIONS -eq "true") {
  $true;
} else {
  $false;
}

# Assign tag based on environment
$latestTag = if ($isGitHubActions) {
  $env:GITHUB_REF;
} else {
  (git describe --tags --abbrev=0);
}

# Get the latest version from tag
$versionNumber = (Select-String -Pattern "\d+\.\d+\.\d+" -InputObject $latestTag).Matches[0].Value;

Write-Host "Building Polygon version $versionNumber" -ForegroundColor Green;

# Clean build folder
Remove-Item -Path "$cwd\build" -Recurse -Force -ErrorAction SilentlyContinue;
New-Item -Path "$cwd\build" -ItemType Directory -Force | Out-Null;

# Download AutoHotkey
$ahkFileNamePattern = "AutoHotkey_.*\.zip";
$ahkLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/AutoHotkey/AutoHotkey/releases/latest";
$ahkDownloadURL = ($ahkLatestRelease.assets | Where-Object { $_.name -match "$ahkFileNamePattern" }) | Select-Object -ExpandProperty browser_download_url;
Invoke-WebRequest -Uri $ahkDownloadURL -OutFile "$cwd\build\autohotkey.zip";
Expand-Archive -Path "$cwd\build\autohotkey.zip" -DestinationPath "$cwd\build\ahk";

Write-Host "Downloaded the latest release from AutoHotkey into `"$cwd\build\ahk\`"" -ForegroundColor Green;

# Download Ahk2Exe
$ahk2ExeFileNamePattern = "Ahk2Exe.*\.zip";
$ahk2ExeLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/AutoHotkey/Ahk2Exe/releases/latest";
$ahk2ExeDownloadURL = ($ahk2ExeLatestRelease.assets | Where-Object { $_.name -match "$ahk2ExeFileNamePattern" }) | Select-Object -ExpandProperty browser_download_url;
Invoke-WebRequest -Uri $ahk2ExeDownloadURL -OutFile "$cwd\build\Ahk2exe.zip";
Expand-Archive -Path "$cwd\build\Ahk2exe.zip" -DestinationPath "$cwd\build\ahk";

Write-Host "Downloaded the latest release from Ahk2Exe into `"$cwd\build\ahk\`"" -ForegroundColor Green;

# Download upx
$upxFileNamePattern = "upx-.*\-win64.zip";
$upxLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/upx/upx/releases/latest";
$upxDownloadURL = ($upxLatestRelease.assets | Where-Object { $_.name -match "$upxFileNamePattern" }) | Select-Object -ExpandProperty browser_download_url;
Invoke-WebRequest -Uri $upxDownloadURL -OutFile "$cwd\build\upx.zip";
Expand-Archive -Path "$cwd\build\upx.zip" -DestinationPath "$cwd\build\upx" -Force;
$sourceFolders = Get-ChildItem -Path "$cwd\build\upx\" -Directory -Filter "upx-*";
foreach ($folder in $sourceFolders) {
    $exeFiles = Get-ChildItem -Path $folder.FullName -Filter "*.exe";
    foreach ($file in $exeFiles) {
        Move-Item -Path $file.FullName -Destination "$cwd\build\ahk\" -Force;
    }
}

Write-Host "Downloaded the latest release from upx into `"$cwd\build\upx\`"" -ForegroundColor Green;

# Download Wix3
$wixFileNamePattern = "wix314-binaries.zip";
$wixLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/wixtoolset/wix3/releases/latest";
$wixDownloadURL = ($wixLatestRelease.assets | Where-Object { $_.name -match "$wixFileNamePattern" }) | Select-Object -ExpandProperty browser_download_url;
Invoke-WebRequest -Uri $wixDownloadURL -OutFile "$cwd\build\$wixFileNamePattern";
Expand-Archive -Path "$cwd\build\$wixFileNamePattern" -DestinationPath "$cwd\build\wix\";

Write-Host "Downloaded the latest release from Wix3 into `"$cwd\build\wix\`"" -ForegroundColor Green;

# Build polygon executables
Start-Process -FilePath "$cwd\build\ahk\Ahk2Exe.exe" -NoNewWindow -Wait -ArgumentList "/in polygon.ahk /out ""$cwd\build\polygon-x86.exe"" /compress 2 /icon logo.ico /base ""$cwd\build\ahk\AutoHotkey32.exe""";
Start-Process -FilePath "$cwd\build\ahk\Ahk2Exe.exe" -NoNewWindow -Wait -ArgumentList "/in polygon.ahk /out ""$cwd\build\polygon-x64.exe"" /compress 2 /icon logo.ico /base ""$cwd\build\ahk\AutoHotkey64.exe""";

Write-Host "Polygon binaries built successfully into `"$cwd\build\`"" -ForegroundColor Green;

# Generate checksums
$checksumFile = "$cwd\build\polygon-checksum.txt";
$hash_x86 = Get-FileHash -Path "$cwd\build\polygon-x86.exe" -Algorithm SHA256;
$hash_x64 = Get-FileHash -Path "$cwd\build\polygon-x64.exe" -Algorithm SHA256;
"polygon-x86.exe: $($hash_x86.Hash)".ToLower() | Out-File -Append -FilePath $checksumFile;
"polygon-x64.exe: $($hash_x64.Hash)".ToLower() | Out-File -Append -FilePath $checksumFile;

Write-Host "Polygon binary checksums calculated successfully into `"$cwd\build\`"" -ForegroundColor Green;

# Create Polygon archives
Compress-Archive -Path "$cwd\polygon.ini","$cwd\build\polygon-x86.exe" -DestinationPath "$cwd\build\polygon-x86.zip";
Compress-Archive -Path "$cwd\polygon.ini","$cwd\build\polygon-x64.exe" -DestinationPath "$cwd\build\polygon-x64.zip";

Write-Host "Polygon archives successfully generated into `"$cwd\build\`"" -ForegroundColor Green;

# Build polygon installer object file
Start-Process -FilePath "$cwd\build\wix\candle.exe" -NoNewWindow -Wait -ArgumentList ".\polygon.wxs -out ""$cwd\build\polygon-x86.wixobj"" -dVersion=""$versionNumber"" -arch x86";
Start-Process -FilePath "$cwd\build\wix\candle.exe" -NoNewWindow -Wait -ArgumentList ".\polygon.wxs -out ""$cwd\build\polygon-x64.wixobj"" -dVersion=""$versionNumber"" -arch x64";

# Build polygon installer MSI
Start-Process -FilePath "$cwd\build\wix\light.exe" -NoNewWindow -Wait -ArgumentList """$cwd\build\polygon-x86.wixobj"" -ext WixUIExtension -out ""$cwd\build\polygon-x86.msi""";
Start-Process -FilePath "$cwd\build\wix\light.exe" -NoNewWindow -Wait -ArgumentList """$cwd\build\polygon-x64.wixobj"" -ext WixUIExtension -out ""$cwd\build\polygon-x64.msi""";

Write-Host "Polygon installers built successfully into `"$cwd\build\`"" -ForegroundColor Green;
