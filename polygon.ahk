#Requires AutoHotkey v2.0
#SingleInstance
#DllLoad Dwmapi.dll
#DllLoad User32.dll

;-- Globals
global APP_VERSION := "0.1.0"
global APP_NAME := "Polygon"
global APP_URL := "https://github.com/thesobercoder/polygon"
global APP_FEEDBACK_URL := "https://github.com/thesobercoder/polygon/issues/new"
global APP_INI_FILE := "polygon.ini"
global APP_INI_SECTION_SHORTCUT := "Shortcut"
global APP_INI_SECTION_TOAST := "Toast"
global APP_SETTING_ISTOASTENABLED := IniRead(APP_INI_FILE, APP_INI_SECTION_TOAST, "Show", "1") == "1" ? true : false
global APP_SHORTCUT_CENTER := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "Center", "^#c")
global APP_SHORTCUT_CENTERHD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterHD", "^#q")
global APP_SHORTCUT_CENTERHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterHalf", "^#w")
global APP_SHORTCUT_CENTERTWOTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterTwoThird", "^#r")
global APP_SHORTCUT_FIRSTTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "FirstThird", "^#d")
global APP_SHORTCUT_CENTERTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "CenterThird", "^#f")
global APP_SHORTCUT_LASTTHIRD := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "LastThird", "^#g")
global APP_SHORTCUT_TOPLEFTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopLeftSixth", "^#z")
global APP_SHORTCUT_BOTTOMLEFTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomLeftSixth", "^#x")
global APP_SHORTCUT_TOPRIGHTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopRightSixth", "^#v")
global APP_SHORTCUT_BOTTOMRIGHTSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomRightSixth", "^#b")
global APP_SHORTCUT_TOPCENTERSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "TopCenterSixth", "^#n")
global APP_SHORTCUT_BOTTOMCENTERSIXTH := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "BottomCenterSixth", "^#m")
global APP_SHORTCUT_LEFTHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "LeftHalf", "^#[")
global APP_SHORTCUT_RIGHTHALF := IniRead(APP_INI_FILE, APP_INI_SECTION_SHORTCUT, "RightHalf", "^#]")

;--Tooltip
A_IconTip := APP_NAME

;-- Context Menu
tray := A_TrayMenu
tray.Delete()
tray.Add("Help", ShowHelp)
tray.Add("Version", ShowVersion)
tray.Add("Feedback", SubmitFeedback)
tray.Add("Restart", Restart)
tray.Add("Exit", Terminate)
tray.Default := "Version"

Toast(Message, r, l, t, b)
{
  ;-- Return if toast is not enabled
  if (!APP_SETTING_ISTOASTENABLED)
    return

  ;-- Calculate the center of the current monitor
  centerX := Ceil((l + r) / 2)
  centerY := Ceil((b + t) / 2)

  title := APP_NAME . " 08ab0337-daeb-4b9c-b01d-11fbc97e1dcb"

  hWnd := WinExist(title)
  if (hWnd > 0)
    return

  toastGui := Gui()
  toastGui.Opt("+ToolWindow -Caption +AlwaysOnTop +Disabled")
  toastGui.BackColor := "000000"
  toastGui.SetFont("cFFFFFF S18", "Verdana")

  toastGui.add("Text", "Center X0 Y90 W278 H210", Message)

  toastGui.Title := title
  toastGui.Show("X" (centerX - 139) " Y" (centerY - 55) " H210 W278 NA")

  WinSetRegion("0-0 H210 W278 R30-30", title)
  WinSetExStyle(32, title)

  Loop 60
  {
    if (A_Index = 1)
    {
      WinSetTransparent(120, title)
      Sleep(1000)
    }
    else if (A_Index = 60)
    {
      toastGui.Destroy()
      break
    }
    else
    {
      TransFade := 120 - A_Index * 2
      WinSetTransparent(TransFade, title)
      Sleep(1)
    }
  }
}

SubmitFeedback(*)
{
  Run APP_FEEDBACK_URL
}

Restart(*)
{
  Reload()
}

ShowHelp(*)
{
  Run APP_URL
}

Terminate(*)
{
  ExitApp(0)
}

ShowVersion(*)
{
  MsgBox "Version " . APP_VERSION, APP_NAME, "iconi"
}

;-- Map Hotkeys
Hotkey APP_SHORTCUT_CENTER, Center
Hotkey APP_SHORTCUT_CENTERHD, CenterHD
Hotkey APP_SHORTCUT_CENTERHALF, CenterHalf
Hotkey APP_SHORTCUT_CENTERTWOTHIRD, CenterTwoThird
Hotkey APP_SHORTCUT_FIRSTTHIRD, FirstThird
Hotkey APP_SHORTCUT_CENTERTHIRD, CenterThird
Hotkey APP_SHORTCUT_LASTTHIRD, LastThird
Hotkey APP_SHORTCUT_TOPLEFTSIXTH, TopLeftSixth
Hotkey APP_SHORTCUT_BOTTOMLEFTSIXTH, BottomLeftSixth
Hotkey APP_SHORTCUT_TOPRIGHTSIXTH, TopRightSixth
Hotkey APP_SHORTCUT_BOTTOMRIGHTSIXTH, BottomRightSixth
Hotkey APP_SHORTCUT_TOPCENTERSIXTH, TopCenterSixth
Hotkey APP_SHORTCUT_BOTTOMCENTERSIXTH, BottomCenterSixth
Hotkey APP_SHORTCUT_LEFTHALF, LeftHalf
Hotkey APP_SHORTCUT_RIGHTHALF, RightHalf

Center(*)
{
  ;-- Get the active window's handle
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the active window's dimensions
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the center of the current monitor
      centerX := Ceil((l + r) / 2)
      centerY := Ceil((t + b) / 2)

      ;-- Move the active window to the center of the current monitor
      WinMove centerX - w / 2 + (ofl + ofr), centerY - h / 2 + (oft + ofb), w, h, hWnd

      ;-- Show layout toast
      Toast("Center", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

CenterHD(*)
{
  ;-- Get the active window's handle
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Set desired window dimension
    rw := 1920
    rh := 1080

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Check if the desired dimenions are more than the monitor dimensions
      if (rh >= (b - t) || rw >= (r - l))
      {
        WinMaximize hWnd
      }
      else
      {
        ;-- Calculate the center of the current monitor with desired size
        centerX := Ceil((l + r) / 2)
        centerY := Ceil((t + b) / 2)

        ;-- Move the active window to the center of the current monitor with desired size
        WinMove Ceil(centerX - (rw) / 2), Ceil(centerY - (rh) / 2), rw + ofl + ofr, rh + oft + ofb, hWnd
      }

      ;-- Show layout toast
      Toast("Center HD", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

CenterHalf(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of half of the monitor
      HalfWidth := Ceil((r - l) / 2)

      ;-- Calculate the horizontal position for centering
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(HalfWidth / 2)

      ;-- Set the window position to the center half of the monitor
      WinMove CenterX, t - oft, HalfWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Center Half", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

CenterTwoThird(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate two third width of screen
      TwoThirdWidth := Ceil((r - l) * 2 / 3)

      ;-- Calculate horizontal position for centering
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(TwoThirdWidth / 2)

      ;-- Set window position to center two third width
      WinMove CenterX, t - oft, TwoThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Center Two Third", r, l, t, b)

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

FirstThird(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Set the window position to the left one third of the monitor
      WinMove l - ofl, t - oft, OneThirdWidth + ofr + ofl, (b - t) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("First Third", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

CenterThird(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate the horizontal position for centering
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)

      ;-- Set the window position to the center one third of the monitor
      WinMove CenterX, t - oft, OneThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Center Third", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

LastThird(*)
{
  ;-- Get handle of active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains active window.
  Loop MonitorCount
  {
    ;-- Get dimensions of current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if active window is within current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate width of one third of monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate horizontal position for right aligning
      RightX := (r - ofr) - OneThirdWidth

      ;-- Set window position to right one third of monitor
      WinMove RightX, t - oft, OneThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Last Third", r, l, t, b)

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

TopLeftSixth(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Set the window position to the left one third of the monitor and top half of it
      WinMove l - ofl, t - oft, OneThirdWidth + ofl + ofb, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Top Left Sixth", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

BottomLeftSixth(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Set the window position to left one third of monitor and bottom half of it
      WinMove l - ofl, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Bottom Left Sixth", r, l, t, b)

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

TopRightSixth(*)
{
  ;-- Get handle of active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains active window
  Loop MonitorCount
  {
    ;-- Get dimensions of current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if active window is within current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate width of one third of monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate horizontal position for right aligning
      RightX := (r - ofr) - OneThirdWidth

      ;-- Set window position to right one third of monitor and top half of it.
      WinMove RightX, t - oft, OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Top Right Sixth", r, l, t, b)

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

BottomRightSixth(*)
{
  ;-- Get handle of active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains active window
  Loop MonitorCount
  {
    ;-- Get dimensions of current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if active window is within current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate width of one third of monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate horizontal position for right aligning
      RightX := (r - ofr) - OneThirdWidth

      ;-- Set window position to right one third of monitor and bottom half of it
      WinMove RightX, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Bottom Right Sixth", r, l, t, b)

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

TopCenterSixth(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate the horizontal position for centering
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)

      ;-- Set the window position to top center one sixth of the monitor
      WinMove CenterX, t - oft, OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Top Center Sixth", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

BottomCenterSixth(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate the horizontal position for centering
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)

      ;-- Set the window position to bottom center one sixth of the monitor
      WinMove CenterX, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Bottom Center Sixth", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

LeftHalf(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of half of the monitor
      HalfWidth := Ceil((r - l) / 2)

      ;-- Set the window position to the left half of the monitor
      WinMove l - ofl, t - oft, HalfWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Left Half", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

RightHalf(*)
{
  ;-- Get the handle of the active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of half of the monitor
      HalfWidth := Ceil((r - l) / 2)

      ;-- Calculate horizontal position for right aligning
      RightX := (r - ofr) - HalfWidth

      ;-- Set the window position to the right half of the monitor
      WinMove RightX, t - oft, HalfWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Show layout toast
      Toast("Right Half", r, l, t, b)

      ;-- Exit the loop since we found the correct monitor
      break
    }
  }
}

CheckWindowWithinMonitor(winX, winY, winW, winH, winOffsetLeft, winOffsetRight, winOffsetTop, winOffsetBottom, monRight, monLeft, monTop, monBottom)
{
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
    return true

  return false
}

WinGetPosEx(hWindow, &X := 0, &Y := 0, &Width := 0, &Height := 0, &Offset_Left := 0, &Offset_Top := 0, &Offset_Right := 0, &Offset_Bottom := 0)
{
  Static RECTPlus, DWMWA_EXTENDED_FRAME_BOUNDS := 9

  ;-- Workaround for AutoHotkey Basic
  PtrType := (A_PtrSize = 8) ? "Ptr" : "UInt"

  ;-- Get the window's dimensions
  ;-- Note: Only the first 16 bytes of the RECTPlus structure are used by the
  ;-- DwmGetWindowAttribute and GetWindowRect functions.
  RECTPlus := Buffer(32, 0)
  DllCall("Dwmapi.dll\DwmGetWindowAttribute", PtrType, hWindow, "UInt", DWMWA_EXTENDED_FRAME_BOUNDS, PtrType, RECTPlus, "UInt", 16)

  ;-- Populate the output variables
  X := Left := NumGet(RECTPlus, 0, "Int")
  Y := Top := NumGet(RECTPlus, 4, "Int")
  Right := NumGet(RECTPlus, 8, "Int")
  Bottom := NumGet(RECTPlus, 12, "Int")
  Width := Right - Left
  Height := Bottom - Top
  Offset_Left := 0
  Offset_Top := 0
  Offset_Right := 0
  Offset_Bottom := 0

  ;-- Collect dimensions via GetWindowRect
  RECT := Buffer(16, 0)
  DllCall("GetWindowRect", PtrType, hWindow, PtrType, RECT)
  GWR_Left := NumGet(RECT, 0, "Int")
  GWR_Top := NumGet(RECT, 4, "Int")
  GWR_Right := NumGet(RECT, 8, "Int")
  GWR_Bottom := NumGet(RECT, 12, "Int")

  ;-- Calculate offsets and update output variables
  NumPut("Int", Offset_Left := Left - GWR_Left, RECTPlus, 16)
  NumPut("Int", Offset_Top := Top - GWR_Top, RECTPlus, 20)
  NumPut("Int", Offset_Right := GWR_Right - Right, RECTPlus, 24)
  NumPut("Int", Offset_Bottom := GWR_Bottom - Bottom, RECTPlus, 28)

  Return &RECTPlus
}