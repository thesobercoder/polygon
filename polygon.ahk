#Requires AutoHotkey v2.0
#SingleInstance
#DllLoad Dwmapi.dll
#DllLoad User32.dll

;-- Context Menu
A_TrayMenu.Add
A_TrayMenu.Add("Version", ShowVersion)

ShowVersion(*)
{
  MsgBox "Version 0.1.0", "Polygon"
}

;-- Center (CTRL+WIN+c)
^#c:: CenterWindow()

;-- Center with 1920x1080 (CTRL+WIN+q)
^#q:: CenterWindowWithSize(1920, 1080)

;-- Center Half (CTRL+WIN+w)
^#w:: CenterHalf()

;-- Center Two Third (CTRL+WIN+r)
^#r:: CenterTwoThird()

;-- First Third (CTRL+WIN+d)
^#d:: FirstThird()

;-- Center Third (CTRL+WIN+f)
^#f:: CenterThird()

;-- Last Third (CTRL+WIN+f)
^#g:: LastThird()

;-- Top Left Sixth (CTRL+WIN+z)
^#z:: TopLeftSixth()

;-- Bottom Left Sixth (CTRL+WIN+z)
^#x:: BottomLeftSixth()

;-- Top Right Sixth (CTRL+WIN+v)
^#v:: TopRightSixth()

;-- Bottom Right Sixth (CTRL+WIN+b)
^#b:: BottomRightSixth()

;-- Top Center Sixth (CTRL+WIN+n)
^#n:: TopCenterSixth()

;-- Bottom Center Sixth (CTRL+WIN+m)
^#m:: BottomCenterSixth()

CenterWindow()
{
  ;-- Get the active window's handle.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the active window's dimensions.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the center of the current monitor.
      centerX := Ceil((l + r) / 2)
      centerY := Ceil((t + b) / 2)

      ;-- Move the active window to the center of the current monitor.
      WinMove centerX - w / 2 + (ofl + ofr), centerY - h / 2 + (oft + ofb), w, h, hWnd
      break
    }
  }
}

CenterWindowWithSize(rw, rh)
{
  ;-- Get the active window's handle.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- If the desired height is greater than the monitor height then set it to the max monitor height.
    if (rh >= (b - t)) {
      rh := (b - t)
    }

    ;-- If the desired width is greater than the monitor width then set it to the max monitor width.
    if (rw >= (r - l)) {
      rw := (r - l)
    }

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the center of the current monitor with desired size.
      centerX := Ceil((l + r) / 2)
      centerY := Ceil((t + b) / 2)

      ;-- Move the active window to the center of the current monitor with desired size.
      WinMove Ceil(centerX - (rw + ofl + ofr) / 2), Ceil(centerY - (rh + oft + ofb) / 2), rw + ofl + ofr, rh + oft + ofb, hWnd

      break
    }
  }
}

CenterHalf()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of half of the monitor.
      HalfWidth := Ceil((r - l) / 2)

      ;-- Calculate the horizontal position for centering.
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(HalfWidth / 2)

      ;-- Set the window position to the center half of the monitor.
      WinMove CenterX, t - oft, HalfWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Exit the loop since we found the correct monitor.
      break
    }
  }
}

CenterTwoThird()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)


    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate two third width of screen
      TwoThirdWidth := Ceil((r - l) * 2 / 3)

      ;-- Calculate horizontal position for centering
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(TwoThirdWidth / 2)

      ;-- Set window position to center two third width
      WinMove CenterX, t - oft, TwoThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

FirstThird()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Set the window position to the left one third of the monitor.
      WinMove l - ofl, t - oft, OneThirdWidth + ofr + ofl, (b - t) + oft + ofb, hWnd

      ;-- Exit the loop since we found the correct monitor.
      break
    }
  }
}

CenterThird()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate the horizontal position for centering.
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)

      ;-- Set the window position to the center one third of the monitor.
      WinMove CenterX, t - oft, OneThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Exit the loop since we found the correct monitor.
      break
    }
  }
}

LastThird()
{
  ;-- Get handle of active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
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

      ;-- Set window position to right one third of monitor
      WinMove RightX, t - oft, OneThirdWidth + ofl + ofr, (b - t) + oft + ofb, hWnd

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

TopLeftSixth()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Set the window position to the left one third of the monitor and top half of it.
      WinMove l - ofl, t - oft, OneThirdWidth + ofl + ofb, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Exit the loop since we found the correct monitor.
      break
    }
  }
}

BottomLeftSixth()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Set the window position to left one third of monitor and bottom half of it.
      WinMove l - ofl, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

TopRightSixth()
{
  ;-- Get handle of active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
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

      ;-- Set window position to right one third of monitor and top half of it.
      WinMove RightX, t - oft, OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

BottomRightSixth()
{
  ;-- Get handle of active window
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
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

      ;-- Set window position to right one third of monitor and bottom half of it.
      WinMove RightX, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Exit loop since we found correct monitor
      break
    }
  }
}

TopCenterSixth()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate the horizontal position for centering.
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)

      ;-- Set the window position to top center one sixth of the monitor.
      WinMove CenterX, t - oft, OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Exit the loop since we found the correct monitor.
      break
    }
  }
}

BottomCenterSixth()
{
  ;-- Get the handle of the active window.
  hWnd := WinExist("A")
  if (hWnd <= 0)
    return

  ;-- Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ;-- Get the dimensions of the current window.
  WinGetPosEx(hWnd, &x, &y, &w, &h, &ofl, &oft, &ofr, &ofb)

  ;-- Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ;-- Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ;-- Check if the active window is within the current monitor.
    if (CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b))
    {
      ;-- Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ;-- Calculate the horizontal position for centering.
      CenterX := (l - ofl) + Ceil(((r - ofr) - (l - ofl)) / 2) - Ceil(OneThirdWidth / 2)

      ;-- Set the window position to bottom center one sixth of the monitor.
      WinMove CenterX, Ceil(b - (b - t) / 2), OneThirdWidth + ofl + ofr, Ceil((b - t) / 2) + oft + ofb, hWnd

      ;-- Exit the loop since we found the correct monitor.
      break
    }
  }
}

CheckWindowWithinMonitor(x, y, w, h, ofl, ofr, oft, ofb, r, l, t, b)
{
  if (x + ofl >= l && x + w - ofr <= r && y + oft >= t && y + h - ofb <= b)
  {
    return true
  }
  return false
}

WinGetPosEx(hWindow, &X := "", &Y := "", &Width := "", &Height := "", &Offset_Left := "", &Offset_Top := "", &Offset_Right := "", &Offset_Bottom := "")
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