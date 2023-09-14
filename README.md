# Polygon

A [Mac Rectangle](https://github.com/rxhanson/Rectangle) inspired window manager for Windows 10/11 powered by AutoHotkey.

> [!NOTE]
> Polygon is still a work in progress and aims to have 100% feature compatibility with Rectangle.

## Prerequisites

You need to have [AutoHotkey v2](https://github.com/AutoHotkey/AutoHotkey) installed.

## Installation

> [!IMPORTANT]
> This guide assumes that you have AutoHotkey executable available in your path.

To automatically start Polygon at Windows logon -

- Create a new directory under your home `C:\Users\<username>` directory named `.config`.
- Copy the `polygon.ahk` file to this newly created `.config` directory.
- Copy the `polygon.cmd` file in the `shell:startup` directory.

If you followed everything correctly, Polygon should start with Windows logon after the next reboot.

## Usage

Here are the shortcuts available in Polygon.

| Shortcut | Layout |
|---|---|
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>C</kbd> | Center |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>Q</kbd> | Center with 1920x1080 |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>W</kbd> | Center Half |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>R</kbd> | Center Two Third |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>D</kbd> | First Third |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>F</kbd> | Center Third |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>G</kbd> | Last Third |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>Z</kbd> | Top Left Sixth |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>X</kbd> | Bottom Left Sixth |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>V</kbd> | Top Right Sixth |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>B</kbd> | Bottom Right Sixth |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>N</kbd> | Top Center Sixth |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>M</kbd> | Bottom Center Sixth |

## Known Issues

Here are some known issues. Contributions are welcome.

- Some windows have an invisible margin and will leave a gap when resized.

## Bugs and feature requests

Have a bug or a feature request, please open a new issue.

## Contributing

Contributions are most welcome to fix bugs or add new features.

Editor preferences are available in the editor config for easy use in common text editors. Read more and download plugins at https://editorconfig.org/.
