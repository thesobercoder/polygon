Remove-Item -Path .\build\* -Recurse -Force
Ahk2Exe.exe /in polygon.ahk /out .\build\polygon-x64.exe /icon logo.ico /base "$HOME\.scoop\apps\autohotkey\current\v2\AutoHotkey64.exe"
Ahk2Exe.exe /in polygon.ahk /out .\build\polygon-x86.exe /icon logo.ico /base "$HOME\.scoop\apps\autohotkey\current\v2\AutoHotkey32.exe"
candle.exe .\polygon.wxs -out .\build\polygon-x86.wixobj -dVersion="0.0.0" -arch x86
candle.exe .\polygon.wxs -out .\build\polygon-x64.wixobj -dVersion="0.0.0" -arch x64
light.exe .\build\polygon-x86.wixobj -ext WixUIExtension -out .\build\polygon-x86.msi
light.exe .\build\polygon-x64.wixobj -ext WixUIExtension -out .\build\polygon-x64.msi
