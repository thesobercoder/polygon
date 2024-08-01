#Requires AutoHotkey v2.0
#SingleInstance
#DllLoad Dwmapi.dll
#DllLoad User32.dll

;-- Ahk2Exe properties
;@Ahk2Exe-SetName Polygon
;@Ahk2Exe-SetVersion 0.7.0
;@Ahk2Exe-SetCompanyName Soham Dasgupta
;@Ahk2Exe-SetDescription A window manager for Windows 10/11 powered by AutoHotkey

;-- Globals
global APP_VERSION := "0.7.0"
global APP_VERSION_NAME := "v" . APP_VERSION
global APP_NAME := "Polygon"
global APP_REPO_OWNER := "thesobercoder"
global APP_REPO_NAME := "polygon"
global APP_URL := "https://github.com/" . APP_REPO_OWNER . "/" . APP_REPO_NAME
global APP_FEEDBACK_URL := APP_URL . "/issues/new"
global APP_UPDATE_URL := APP_URL . "/releases/latest"
global APP_INI_FILE := "polygon.ini"
global APP_INI_SECTION_SHORTCUT := "Shortcut"
global APP_INI_SECTION_TOAST := "Toast"
global APP_SETTING_ISTOASTENABLED := IniRead(APP_INI_FILE, APP_INI_SECTION_TOAST, "Show", "0") == "1" ? true : false
global APP_SHORTCUT_CENTER := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "Center", "")
global APP_SHORTCUT_CENTERHD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterHD", "")
global APP_SHORTCUT_CENTERHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterHalf", "")
global APP_SHORTCUT_CENTERTWOTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterTwoThird", "")
global APP_SHORTCUT_FIRSTTWOTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "FirstTwoThird", "")
global APP_SHORTCUT_LASTTWOTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "LastTwoThird", "")
global APP_SHORTCUT_FIRSTTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "FirstThird", "")
global APP_SHORTCUT_CENTERTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterThird", "")
global APP_SHORTCUT_LASTTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "LastThird", "")
global APP_SHORTCUT_TOPLEFTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopLeftSixth", "")
global APP_SHORTCUT_BOTTOMLEFTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomLeftSixth", "")
global APP_SHORTCUT_TOPRIGHTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopRightSixth", "")
global APP_SHORTCUT_BOTTOMRIGHTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomRightSixth", "")
global APP_SHORTCUT_TOPCENTERSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopCenterSixth", "")
global APP_SHORTCUT_BOTTOMCENTERSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomCenterSixth", "")
global APP_SHORTCUT_LEFTHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "LeftHalf", "")
global APP_SHORTCUT_RIGHTHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "RightHalf", "")
global APP_SHORTCUT_TOPLEFT := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopLeft", "")
global APP_SHORTCUT_TOPRIGHT := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopRight", "")
global APP_SHORTCUT_BOTTOMLEFT := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomLeft", "")
global APP_SHORTCUT_BOTTOMRIGHT := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomRight", "")
global APP_SHORTCUT_TOPHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopHalf", "")
global APP_SHORTCUT_BOTTOMHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomHalf", "")
global APP_SHORTCUT_FIRSTFOURTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "FirstFourth", "")
global APP_SHORTCUT_SECONDFOURTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "SecondFourth", "")
global APP_SHORTCUT_THIRDFOURTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "ThirdFourth", "")
global APP_SHORTCUT_LASTFOURTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "LastFourth", "")
;--Tooltip
A_IconTip := APP_NAME
;-- Register global error logging
OnError(LogError)
;-- On startup check for version update
CheckForUpdate()
;-- Context Menu
tray := A_TrayMenu
tray.Delete()
tray.Add("Help", ShowHelp)
tray.Add("Version", ShowVersion)
tray.Add("Check for Updates", CheckForUpdate)
tray.Add("Feedback", SubmitFeedback)
tray.Add("Restart", Restart)
tray.Add("Exit", Terminate)
tray.Default := "Version"
LogError(exception, mode) {
  ; Get the user's application data folder
  PolygonDataFolder := A_AppData . "\Polygon"
  PolygonLogPath := PolygonDataFolder . "\errorlog.txt"
  ; Create the folder if it doesn't exist
  if (!DirExist(PolygonDataFolder))
  {
    DirCreate(PolygonDataFolder)
  }
  ; Append the error message to the log file
  FileAppend("Error on line " . exception.Line . ": " . exception.Message . "`n", PolygonLogPath)
  ; Display a message to the user
  result := MsgBox('Polygon encountered an error. The error has been logged in the "errorlog.txt" file. Open folder location?', APP_NAME, "YesNo Iconx")
  if (result == "Yes")
  {
    Run(PolygonDataFolder)
  }
  return true
}
Toast(Message, r, l, t, b) {
  ;-- Return if toast is not enabled
  if (!APP_SETTING_ISTOASTENABLED)
    return
  ;-- Calculate the center of the current monitor
  centerX := Ceil((l + r) / 2)
  centerY := Ceil((b + t) / 2)
  title := APP_NAME . " 08ab0337-daeb-4b9c-b01d-11fbc97e1dcb"
  hWnd := WinExist(title)
  if (hWnd > 0)
    WinClose(hWnd)
  toastGui := Gui()
  toastGui.Opt("+ToolWindow -Caption +AlwaysOnTop +Disabled +E0x20")
  toastGui.BackColor := "000000"
  toastGui.SetFont("cFFFFFF S18", "Verdana")
  toastGui.add("Text", "Center X0 Y90 W278 H210", Message)
  toastGui.Title := title
  toastGui.Show("X" (centerX - 139) " Y" (centerY - 55) " H210 W278 NA")
  WinSetRegion("0-0 H210 W278 R30-30", title)
  WinSetExStyle(32, title)
  Loop 60
  {
    hWnd := WinExist(title)
    if (hWnd < 1)
      break

    if (A_Index = 1)
    {
      WinSetTransparent(120, hWnd)
      Sleep(100)
    }
    else if (A_Index = 60)
    {
      toastGui.Destroy()
      break
    }
    else
    {
      TransFade := 120 - A_Index * 2
      WinSetTransparent(TransFade, hWnd)
      Sleep(1)
    }
  }
}
ParseVersionString(version) {
  regex := "v(\d+)\.(\d+)\.(\d+)"
  if (RegExMatch(version, regex, &parsedVersion))
  {
    if (parsedVersion.Count > 0)
    {
      ;-- Extract the version here
      major := parsedVersion[1]
      minor := parsedVersion[2]
      patch := parsedVersion[3]
      return Number(major) * 10000 + Number(minor) * 100 + Number(patch)
    }
  }
  return 0
}
CheckForUpdate(args*) {
  version := GetLatestGitHubRelease(APP_REPO_OWNER, APP_REPO_NAME)
  ; Check if the request was successful
  if (version)
  {
    newVersion := ParseVersionString(version)
    currentVersion := ParseVersionString(APP_VERSION_NAME)
    ;-- Check if the latest version is greater
    if (newVersion > currentVersion)
    {
      result := MsgBox("A new version " . newVersion . " is available. Do you want to update?", APP_NAME, "YesNo Iconi")
      if (result == "Yes")
      {
        Run(APP_UPDATE_URL)
        return
      }
    }
  }
  if (args && args.Length > 0 && args[1] == "Check for Updates")
  {
    MsgBox("You already have the latest version.", APP_NAME, "Iconi")
  }
}
GetLatestGitHubRelease(owner, repo) {
  req := ComObject("Msxml2.XMLHTTP")
  req.open("GET", "https://api.github.com/repos/" . owner . "/" . repo . "/releases/latest", false)
  req.send()
  if req.status != 200
  {
    MsgBox("Error checking for update. Please try after some time.", APP_NAME, "Iconx")
    return
  }
  res := JSONParse(req.responseText)
  return res.tag_name
  JSONParse(str)
  {
    htmlfile := ComObject("HTMLFile")
    htmlfile.write('<meta http-equiv="X-UA-Compatible" content="IE=edge">')
    return htmlfile.parentWindow.JSON.parse(str)
  }
}
SubmitFeedback(*) {
  Run(APP_FEEDBACK_URL)
}
Restart(*) {
  Reload()
}
ShowHelp(*) {
  Run(APP_URL)
}
Terminate(*) {
  ExitApp(0)
}
ShowVersion(*) {
  MsgBox("Version " . APP_VERSION, APP_NAME, "Iconi")
}
SetConditionalHotkey(shortcut, func) {
  if (shortcut && shortcut != "") {
    Hotkey(shortcut, func)
  }
}
;-- Map Hotkeys using SetConditionalHotkey function
SetConditionalHotkey(APP_SHORTCUT_CENTER, Center)
SetConditionalHotkey(APP_SHORTCUT_CENTERHD, CenterHD)
SetConditionalHotkey(APP_SHORTCUT_CENTERHALF, CenterHalf)
SetConditionalHotkey(APP_SHORTCUT_CENTERTWOTHIRD, CenterTwoThird)
SetConditionalHotkey(APP_SHORTCUT_FIRSTTHIRD, FirstThird)
SetConditionalHotkey(APP_SHORTCUT_CENTERTHIRD, CenterThird)
SetConditionalHotkey(APP_SHORTCUT_FIRSTTWOTHIRD, FirstTwoThird)
SetConditionalHotkey(APP_SHORTCUT_LASTTWOTHIRD, LastTwoThird)
SetConditionalHotkey(APP_SHORTCUT_LASTTHIRD, LastThird)
SetConditionalHotkey(APP_SHORTCUT_TOPLEFTSIXTH, TopLeftSixth)
SetConditionalHotkey(APP_SHORTCUT_BOTTOMLEFTSIXTH, BottomLeftSixth)
SetConditionalHotkey(APP_SHORTCUT_TOPRIGHTSIXTH, TopRightSixth)
SetConditionalHotkey(APP_SHORTCUT_BOTTOMRIGHTSIXTH, BottomRightSixth)
SetConditionalHotkey(APP_SHORTCUT_TOPCENTERSIXTH, TopCenterSixth)
SetConditionalHotkey(APP_SHORTCUT_BOTTOMCENTERSIXTH, BottomCenterSixth)
SetConditionalHotkey(APP_SHORTCUT_LEFTHALF, LeftHalf)
SetConditionalHotkey(APP_SHORTCUT_RIGHTHALF, RightHalf)
SetConditionalHotkey(APP_SHORTCUT_TOPLEFT, TopLeft)
SetConditionalHotkey(APP_SHORTCUT_TOPRIGHT, TopRight)
SetConditionalHotkey(APP_SHORTCUT_BOTTOMLEFT, BottomLeft)
SetConditionalHotkey(APP_SHORTCUT_BOTTOMRIGHT, BottomRight)
SetConditionalHotkey(APP_SHORTCUT_TOPHALF, TopHalf)
SetConditionalHotkey(APP_SHORTCUT_BOTTOMHALF, BottomHalf)
SetConditionalHotkey(APP_SHORTCUT_FIRSTFOURTH, FirstFourth)
SetConditionalHotkey(APP_SHORTCUT_SECONDFOURTH, SecondFourth)
SetConditionalHotkey(APP_SHORTCUT_THIRDFOURTH, ThirdFourth)
SetConditionalHotkey(APP_SHORTCUT_LASTFOURTH, LastFourth)
;-- Layout Functions
Center(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the center of the current monitor
    centerX := Ceil(((l + r) - (ofl + ofr)) / 2)
    centerY := Ceil(((t + b) - (ofb + oft)) / 2)
    ;-- Move the active window to the center of the current monitor
    WinMoveEx(centerX - w / 2, centerY - h / 2, w + ofl + ofr, h + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Center", r, l, t, b)
  }
}
CenterHD(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Set desired window dimension
    rw := Min(1920, ((r + ofr) - (l + ofl)))
    rh := Min(1080, ((b + ofb) - (t + oft)))
    ;-- Calculate the center of the current monitor with desired size
    centerX := Ceil(((l + r) - (ofl + ofr)) / 2)
    centerY := Ceil(((t + b) - (ofb + oft)) / 2)
    ;-- Move the active window to the center of the current monitor with desired size
    WinMoveEx(Ceil(centerX - rw / 2), Ceil(centerY - rh / 2), rw + ofl + ofr, rh + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Center HD", r, l, t, b)
  }
}
CenterHalf(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of half of the monitor
    HalfWidth := Ceil((r - l) / 2)
    ;-- Calculate the horizontal position for centering
    CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(HalfWidth / 2)
    ;-- Set the window position to the center half of the monitor
    WinMoveEx(CenterX, t - oft, HalfWidth + ofl + ofr, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Center Half", r, l, t, b)
  }
}
CenterTwoThird(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate two third width of screen
    TwoThirdWidth := Ceil((r - l) * 2 / 3)
    ;-- Calculate horizontal position for centering
    CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(TwoThirdWidth / 2)
    ;-- Set window position to center two third width
    WinMoveEx(CenterX, t - oft, TwoThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Center Two Third", r, l, t, b)
  }
}
FirstTwoThird(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate two third width of screen
    TwoThirdWidth := Ceil((r - l) * 2 / 3)
    ;-- Set the window position to the left first two third of the monitor
    WinMoveEx(l - ofl, t - oft, TwoThirdWidth + ofr + ofl, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("First Two Third", r, l, t, b)
  }
}
LastTwoThird(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate two third width of screen
    TwoThirdWidth := Ceil((r - l) * 2 / 3)
    ;-- Calculate horizontal position for right aligning
    RightX := (r - ofr) - TwoThirdWidth
    ;-- Set window position to right one third of monitor
    WinMoveEx(RightX, t - oft, TwoThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Last Two Third", r, l, t, b)
  }
}
FirstThird(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one third of the monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Set the window position to the left one third of the monitor
    WinMoveEx(l - ofl, t - oft, OneThirdWidth + ofr + ofl, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("First Third", r, l, t, b)
  }
}
CenterThird(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one third of the monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Calculate the horizontal position for centering
    CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)
    ;-- Set the window position to the center one third of the monitor
    WinMoveEx(CenterX, t - oft, OneThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Center Third", r, l, t, b)
  }
}
LastThird(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate width of one third of monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Calculate horizontal position for right aligning
    RightX := (r - ofr) - OneThirdWidth
    ;-- Set window position to right one third of monitor
    WinMoveEx(RightX, t - oft, OneThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Last Third", r, l, t, b)
  }
}
TopLeftSixth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one third of the monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Set the window position to the left one third of the monitor and top half of it
    WinMoveEx(l - ofl, t - oft, OneThirdWidth + ofl + ofb, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Top Left Sixth", r, l, t, b)
  }
}
BottomLeftSixth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one third of the monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Set the window position to left one third of monitor and bottom half of it
    WinMoveEx(l - ofl, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Bottom Left Sixth", r, l, t, b)
  }
}
TopRightSixth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate width of one third of monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Calculate horizontal position for right aligning
    RightX := (r - ofr) - OneThirdWidth
    ;-- Set window position to right one third of monitor and top half of it.
    WinMoveEx(RightX, t - oft, OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Top Right Sixth", r, l, t, b)
  }
}
BottomRightSixth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate width of one third of monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Calculate horizontal position for right aligning
    RightX := (r - ofr) - OneThirdWidth
    ;-- Set window position to right one third of monitor and bottom half of it
    WinMoveEx(RightX, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Bottom Right Sixth", r, l, t, b)
  }
}
TopCenterSixth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one third of the monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Calculate the horizontal position for centering
    CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)
    ;-- Set the window position to top center one sixth of the monitor
    WinMoveEx(CenterX, t - oft, OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Top Center Sixth", r, l, t, b)
  }
}
BottomCenterSixth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one third of the monitor
    OneThirdWidth := Ceil((r - l) / 3)
    ;-- Calculate the horizontal position for centering
    CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)
    ;-- Set the window position to bottom center one sixth of the monitor
    WinMoveEx(CenterX, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Bottom Center Sixth", r, l, t, b)
  }
}
LeftHalf(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of half of the monitor
    HalfWidth := Ceil((r - l) / 2)
    ;-- Set the window position to the left half of the monitor
    WinMoveEx(l - ofl, t - oft, HalfWidth + ofl + ofr, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Left Half", r, l, t, b)
  }
}
RightHalf(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of half of the monitor
    HalfWidth := Ceil((r - l) / 2)
    ;-- Calculate horizontal position for right aligning
    RightX := (r - ofr) - HalfWidth
    ;-- Set the window position to the right half of the monitor
    WinMoveEx(RightX, t - oft, HalfWidth + ofl + ofr, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Right Half", r, l, t, b)
  }
}
TopLeft(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width as half of the monitor
    HalfWidth := Ceil((r - l) / 2)
    ;-- Set the window position to the left half of the monitor and top half of it
    WinMoveEx(l - ofl, t - oft, HalfWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Top Left", r, l, t, b)
  }
}
TopRight(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width as half of the monitor
    HalfWidth := Ceil((r - l) / 2)
    ;-- Calculate horizontal position for right aligning
    RightX := (r - ofr) - HalfWidth
    ;-- Set the window position to start from the middle of the monitor and extend to the very right edge
    WinMoveEx(RightX, t - oft, r - l - HalfWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Top Right", r, l, t, b)
  }
}
BottomLeft(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of half of the monitor
    HalfWidth := Ceil((r - l) / 2)
    ;-- Calculate the height of half of the monitor
    HalfHeight := Ceil((b - t) / 2)
    ;-- Set the window position to left one third of monitor and bottom half of it
    WinMoveEx(l - ofl, Ceil(b - (b - t) / 2), HalfWidth + ofl + ofr, HalfHeight + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Bottom Left", r, l, t, b)
  }
}
BottomRight(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width as half of the monitor
    HalfWidth := Ceil((r - l) / 2)
    ;-- Calculate horizontal position for right aligning
    RightX := (r - ofr) - HalfWidth
    ;-- Set the window position to the right half of the monitor and bottom half of it
    WinMoveEx(RightX, Ceil(b - (b - t) / 2), HalfWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Bottom Right", r, l, t, b)
  }
}
TopHalf(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the height of half of the monitor
    HalfHeight := Ceil((b - t) / 2)
    ;-- Set the window position to the left half of the monitor and top half of it
    WinMoveEx(l - ofl, t - oft, Ceil((r - l)) + ofl + ofr, HalfHeight + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Top Half", r, l, t, b)
  }
}
BottomHalf(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the height of half of the monitor
    HalfHeight := Ceil((b - t) / 2)
    ;-- Set the window position to the left half of the monitor and top half of it
    WinMoveEx(l - ofl, Ceil(b - (b - t) / 2), Ceil((r - l)) + ofl + ofr, HalfHeight + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Bottom Half", r, l, t, b)
  }
}
FirstFourth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one fourth of the monitor
    OneFourthWidth := Ceil((r - l) / 4)
    ;-- Set the window position to the left one fourth of the monitor
    WinMoveEx(l - ofl, t - oft, OneFourthWidth + ofr + ofl, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("First Fourth", r, l, t, b)
  }
}
SecondFourth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ; Calculate the width of one-fourth of the monitor
    OneFourthWidth := Ceil((r - l) / 4)
    ; Set the window position to the left one-fourth of the monitor
    WinMoveEx(l - ofl + OneFourthWidth, t - oft, OneFourthWidth + ofr + ofl, (b - t) + oft + ofb, hWnd)
    ; Show layout toast
    Toast("Second Fourth", r, l, t, b)
  }
}
ThirdFourth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ; Calculate the width of one-fourth of the monitor
    OneFourthWidth := Ceil((r - l) / 4)
    ; Set the window position to the right one-fourth of the monitor
    WinMoveEx(l - ofl + 2 * OneFourthWidth, t - oft, OneFourthWidth + ofr + ofl, (b - t) + oft + ofb, hWnd)
    ; Show layout toast
    Toast("Third Fourth", r, l, t, b)
  }
}
LastFourth(*) {
  if (GetWindowRectEx(&hWnd, &x, &y, &w, &h, &ofl, &ofr, &oft, &ofb, &r, &l, &t, &b))
  {
    ;-- Calculate the width of one fourth of the monitor
    OneFourthWidth := Ceil((r - l) / 4)
    ;-- Set the window position to the right one fourth of the monitor
    WinMoveEx(r - OneFourthWidth - ofr, t - oft, OneFourthWidth + ofr + ofl, (b - t) + oft + ofb, hWnd)
    ;-- Show layout toast
    Toast("Last Fourth", r, l, t, b)
  }
}
WinMoveEx(X := 0, Y := 0, Width := 0, Height := 0, hWnd := 0) {
  ;-- Restore the window before moving
  WinRestore(hWnd)
  ;-- Move the window to the desired position and dimension
  WinMove(X, Y, Width, Height, hWnd)
}
GetWindowRectEx(&hWindow := 0, &winX := 0, &winY := 0, &winW := 0, &winH := 0, &winOffsetLeft := 0, &winOffsetRight := 0, &winOffsetTop := 0, &winOffsetBottom := 0, &monRight := 0, &monLeft := 0, &monTop := 0, &monBottom := 0) {
  ;-- Get the handle of the active window
  hWindow := WinExist("A")
  if (hWindow > 0)
  {
    ;-- Get the number of monitors
    MonitorCount := MonitorGetCount()
    ;-- Get the dimensions of the current window
    WinGetPosEx(hWindow, &winX, &winY, &winW, &winH, &winOffsetLeft, &winOffsetRight, &winOffsetTop, &winOffsetBottom)
    ;-- Loop through each monitor to find which one contains the active window
    Loop MonitorCount
    {
      ;-- Get the dimensions of the current monitor
      MonitorGetWorkArea(A_Index, &monLeft, &monTop, &monRight, &monBottom)
      ;-- Check if the active window is within the current monitor
      if (CheckWindowWithinMonitor(winX, winY, winW, winH, winOffsetLeft, winOffsetRight, winOffsetTop, winOffsetBottom, monRight, monLeft, monTop, monBottom))
      {
        return true
      }
    }
  }
  return false
}
CheckWindowWithinMonitor(winX, winY, winW, winH, winOffsetLeft, winOffsetRight, winOffsetTop, winOffsetBottom, monRight, monLeft, monTop, monBottom) {
  ; Calculate the coordinates of the corners of the window
  winLeft := winX + winOffsetLeft
  winRight := winX + winW - winOffsetRight
  winTop := winY + winOffsetTop
  winBottom := winY + winH - winOffsetBottom
  ; Calculate the area of intersection between the window and the monitor
  intersectionArea := (min(winRight, monRight) - max(winLeft, monLeft)) * (min(winBottom, monBottom) - max(winTop, monTop))
  ; Calculate the total area of the window
  windowArea := winW * winH
  ; Check if more than 50% of the window is within the monitor
  if (Round(intersectionArea / windowArea, 1) > 0.5)
  {
    return true
  }
  return false
}
WinGetPosEx(hWindow, &winX := 0, &winY := 0, &winW := 0, &winH := 0, &winOffsetLeft := 0, &winOffsetRight := 0, &winOffsetTop := 0, &winOffsetBottom := 0) {
  Static RECTPlus, DWMWA_EXTENDED_FRAME_BOUNDS := 9
  ;-- Workaround for AutoHotkey Basic
  PtrType := (A_PtrSize = 8) ? "Ptr" : "UInt"
  ;-- Get the window's dimensions
  ;-- Note: Only the first 16 bytes of the RECTPlus structure are used by the
  ;-- DwmGetWindowAttribute and GetWindowRect functions.
  RECTPlus := Buffer(32, 0)
  DllCall("Dwmapi.dll\DwmGetWindowAttribute", PtrType, hWindow, "UInt", DWMWA_EXTENDED_FRAME_BOUNDS, PtrType, RECTPlus, "UInt", 16)
  ;-- Populate the output variables
  winX := Left := NumGet(RECTPlus, 0, "Int")
  winY := Top := NumGet(RECTPlus, 4, "Int")
  Right := NumGet(RECTPlus, 8, "Int")
  Bottom := NumGet(RECTPlus, 12, "Int")
  winW := Right - Left
  winH := Bottom - Top
  winOffsetLeft := 0
  winOffsetRight := 0
  winOffsetTop := 0
  winOffsetBottom := 0
  ;-- Collect dimensions via GetWindowRect
  RECT := Buffer(16, 0)
  DllCall("User32.dll\GetWindowRect", PtrType, hWindow, PtrType, RECT)
  GWR_Left := NumGet(RECT, 0, "Int")
  GWR_Top := NumGet(RECT, 4, "Int")
  GWR_Right := NumGet(RECT, 8, "Int")
  GWR_Bottom := NumGet(RECT, 12, "Int")
  ;-- Calculate offsets and update output variables
  NumPut("Int", winOffsetLeft := Left - GWR_Left, RECTPlus, 16)
  NumPut("Int", winOffsetTop := Top - GWR_Top, RECTPlus, 20)
  NumPut("Int", winOffsetRight := GWR_Right - Right, RECTPlus, 24)
  NumPut("Int", winOffsetBottom := GWR_Bottom - Bottom, RECTPlus, 28)
  Return &RECTPlus
}