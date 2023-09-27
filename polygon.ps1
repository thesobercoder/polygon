$cwd = (Get-Location).Path;

Remove-Item -Path "$cwd\build\*" -Recurse -Force;

Ahk2Exe.exe /in polygon.ahk /out "$cwd\build\polygon-x64.exe" /icon logo.ico /base "$HOME\.scoop\apps\autohotkey\current\v2\AutoHotkey64.exe";
Ahk2Exe.exe /in polygon.ahk /out "$cwd\build\polygon-x86.exe" /icon logo.ico /base "$HOME\.scoop\apps\autohotkey\current\v2\AutoHotkey32.exe";

candle.exe .\polygon.wxs -out "$cwd\build\polygon-x86.wixobj" -dVersion="0.0.0" -arch x86;
candle.exe .\polygon.wxs -out "$cwd\build\polygon-x64.wixobj" -dVersion="0.0.0" -arch x64;

light.exe "$cwd\build\polygon-x86.wixobj" -ext WixUIExtension -out "$cwd\build\polygon-x86.msi";
light.exe "$cwd\build\polygon-x64.wixobj" -ext WixUIExtension -out "$cwd\build\polygon-x64.msi";
