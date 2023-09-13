# Polygon

A [Mac Rectangle](https://github.com/rxhanson/Rectangle) inspired window manager for Windows 10/11 powered by AutoHotkey.

## Prerequisites

You need to have AutoHotkey v2 installed.

## Installation

> :warning: **Note:**
> This guide assumes that you have AutoHotkey executable available in your path.

To automatically start Polygon on Windows logon -

- Create a new directory under your home directory, named `.config`.
- Download the `polygon.ahk` file to this newly created `.config` directory.
- Create a `startup.cmd` file in the `shell:startup` directory.
- Fill the content of the `startup.cmd` with the following content.
  ```cmd
  @echo off

  :: Start AutoHotkey
  call powershell.exe "Start-Process -WindowStyle hidden autohotkey.exe ""$HOME\.config\polygon.ahk"""
  ```

## Usage

Here are the shortcuts available in Polygon.

| Shortcut | Layout |
|---|---|
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>c</kbd> | Center |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>q</kbd> | Center with 1920x1080 |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>d</kbd> | First Third |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>f</kbd> | Center Third |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>g</kbd> | Last Third |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>z</kbd> | Top Left Sixth |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>x</kbd> | Bottom Left Sixth |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>v</kbd> | Top Right Sixth |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>b</kbd> | Bottom Right Sixth |

## Known Issues

Here are some known issues. Contributions are welcome.

- Some windows have an invisible margin and will leave a gap when resized.

## Bugs and feature requests

Have a bug or a feature request, please open a new issue.

## Contributing

Contributions are most welcome to fix bugs or add new features.

Editor preferences are available in the editor config for easy use in common text editors. Read more and download plugins at https://editorconfig.org/.
