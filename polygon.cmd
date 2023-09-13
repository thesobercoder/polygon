@echo off

:: Start AutoHotkey
call powershell.exe "Start-Process -WindowStyle hidden autohotkey.exe ""$HOME\.config\polygon.ahk"""
