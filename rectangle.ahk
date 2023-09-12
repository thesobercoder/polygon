#Requires AutoHotkey v2.0
#SingleInstance

CenterWindow()
{
  ; Get the active window's handle.
  hWnd := WinExist("A")

  ; Get the active window's dimensions.
  WinGetPos(&x, &y, &w, &h, hWnd)

  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ; Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Check if the active window is within the current monitor.
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate the center of the current monitor.
      centerX := (l + r) / 2
      centerY := (t + b) / 2

      ; Move the active window to the center of the current monitor.
      WinMove centerX - w / 2, centerY - h / 2, w, h, hWnd
      break
    }
  }
}

CenterWindowWithSize(rw, rh)
{
  ; Get the active window's handle.
  hWnd := WinExist("A")

  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ; Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if the active window is within the current monitor.
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; If window size is equal to screen size, place it full screen on same monitor.
      if (w = r - l && h = b - t)
      {
        ; Resize window to desired size.
        WinMove l, t, rw, rh, hWnd
        break
      }
      else
      {
        ; Calculate the center of the current monitor with desired size.
        centerX := (l + r) / 2
        centerY := (t + b) / 2

        ; Move the active window to the center of the current monitor with desired size.
        WinMove centerX - rw / 2, centerY - rh / 2, rw, rh, hWnd

        break
      }
    }
  }
}

LeftOneThird()
{
  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Get the handle of the active window.
  hWnd := WinExist("A")

  ; Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ; Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if the active window is within the current monitor.
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ; Set the window position to the left one third of the monitor.
      WinMove l, t, OneThirdWidth, b - t, hWnd

      ; Exit the loop since we found the correct monitor.
      break
    }
  }
}

CenterOneThird()
{
  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Get the handle of the active window.
  hWnd := WinExist("A")

  ; Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ; Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if the active window is within the current monitor.
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ; Calculate the horizontal position for centering.
      CenterX := l + ((r - l) / 2) - (OneThirdWidth / 2)

      ; Set the window position to the center one third of the monitor.
      WinMove CenterX, t, OneThirdWidth, b - t, hWnd

      ; Exit the loop since we found the correct monitor.
      break
    }
  }
}

RightOneThird()
{
  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Get handle of active window
  hWnd := WinExist("A")

  ; Loop through each monitor to find which one contains active window
  Loop MonitorCount
  {
    ; Get dimensions of current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if active window is within current monitor
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate width of one third of monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ; Calculate horizontal position for right aligning
      RightX := r - OneThirdWidth

      ; Set window position to right one third of monitor
      WinMove RightX, t, OneThirdWidth, b - t, hWnd

      ; Exit loop since we found correct monitor
      break
    }
  }
}

LeftOneThirdTop()
{
  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Get the handle of the active window.
  hWnd := WinExist("A")

  ; Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ; Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if the active window is within the current monitor.
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ; Set the window position to the left one third of the monitor and top half of it.
      WinMove l, t, OneThirdWidth, (b - t) / 2, hWnd

      ; Exit the loop since we found the correct monitor.
      break
    }
  }
}

LeftOneThirdBottom()
{
  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Get the handle of the active window.
  hWnd := WinExist("A")

  ; Loop through each monitor to find which one contains the active window.
  Loop MonitorCount
  {
    ; Get the dimensions of the current monitor.
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if the active window is within the current monitor.
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate the width of one third of the monitor.
      OneThirdWidth := Ceil((r - l) / 3)

      ; Set the window position to left one third of monitor and bottom half of it.
      WinMove l, b - (b - t) / 2, OneThirdWidth, (b - t) / 2, hWnd

      ; Exit loop since we found correct monitor
      break
    }
  }
}

RightOneThirdTop()
{
  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Get handle of active window
  hWnd := WinExist("A")

  ; Loop through each monitor to find which one contains active window
  Loop MonitorCount
  {
    ; Get dimensions of current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if active window is within current monitor
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate width of one third of monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ; Calculate horizontal position for right aligning
      RightX := r - OneThirdWidth

      ; Set window position to right one third of monitor and top half of it.
      WinMove RightX, t, OneThirdWidth, (b - t) / 2, hWnd

      ; Exit loop since we found correct monitor
      break
    }
  }
}

RightOneThirdBottom()
{
  ; Get the number of monitors.
  MonitorCount := MonitorGetCount()

  ; Get handle of active window
  hWnd := WinExist("A")

  ; Loop through each monitor to find which one contains active window
  Loop MonitorCount
  {
    ; Get dimensions of current monitor
    MonitorGetWorkArea(A_Index, &l, &t, &r, &b)

    ; Get the dimensions of the current window.
    WinGetPos(&x, &y, &w, &h, hWnd)

    ; Check if active window is within current monitor
    if (x >= l && x + w <= r && y >= t && y + h <= b)
    {
      ; Calculate width of one third of monitor
      OneThirdWidth := Ceil((r - l) / 3)

      ; Calculate horizontal position for right aligning
      RightX := r - OneThirdWidth

      ; Set window position to right one third of monitor and bottom half of it.
      WinMove RightX, b - (b - t) / 2, OneThirdWidth, (b - t) / 2, hWnd

      ; Exit loop since we found correct monitor
      break
    }
  }
}

; Center a window (CTRL+WIN+c)
^#c:: CenterWindow()

; Center a window with size 1920x1080 (CTRL+WIN+q)
^#q:: CenterWindowWithSize(1920, 1080)

; Left One Third (CTRL+WIN+d)
^#d:: LeftOneThird()

; Center One Third (CTRL+WIN+f)
^#f:: CenterOneThird()

; Center One Third (CTRL+WIN+f)
^#g:: RightOneThird()

; Left One Third Top (CTRL+WIN+z)
^#z:: LeftOneThirdTop()

; Left One Third Bottom (CTRL+WIN+z)
^#x:: LeftOneThirdBottom()

; Right One Third Top (CTRL+WIN+v)
^#v:: RightOneThirdTop()

; Right One Third Bottom (CTRL+WIN+b)
^#b:: RightOneThirdBottom()
