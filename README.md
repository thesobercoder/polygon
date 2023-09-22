# Polygon

A [Mac Rectangle](https://github.com/rxhanson/Rectangle) inspired window manager for Windows 10/11 powered by AutoHotkey.

![Release](https://github.com/github/docs/actions/workflows/main.yml/badge.svg)

> [!NOTE]
> Polygon is still a work in progress and aims to have 100% feature compatibility with Rectangle.

## Installation

### Installer

You can grab the latest Polygon installer from this [link](https://github.com/thesobercoder/polygon/releases/latest/download/polygon.msi). The installer will place a shortcut to your user startup folder to ensure that Polygon start at Windows logon.

### Manual

If you rather want to install Polygon manually, please follow the steps outlined below.

- Download the compiled executable based on your OS architecture from the latest [release](https://github.com/thesobercoder/polygon/releases/latest).
- Open the user startup folder by running the `shell:startup` command in the run (<kbd>WIN</kbd>+<kbd>R</kbd>) window.
- Copy the `polygon-x[64|86].exe` that you downloaded to the `shell:startup` directory that you opened in the previous step.

If you followed everything correctly, Polygon should start at Windows logon.

## Usage

Here are the shortcuts available in Polygon.

| Status             | Shortcut                                    | Layout              |
| ------------------ | ------------------------------------------- | ------------------- |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>C</kbd> | Center              |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>Q</kbd> | Center HD           |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>W</kbd> | Center Half         |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>[</kbd> | Left Half           |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>]</kbd> | Right Half          |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>R</kbd> | Center Two Third    |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>D</kbd> | First Third         |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>F</kbd> | Center Third        |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>G</kbd> | Last Third          |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>Z</kbd> | Top Left Sixth      |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>X</kbd> | Bottom Left Sixth   |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>V</kbd> | Top Right Sixth     |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>B</kbd> | Bottom Right Sixth  |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>N</kbd> | Top Center Sixth    |
| :white_check_mark: | <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>M</kbd> | Bottom Center Sixth |
| construction:      |                                             | Top Half            |
| construction:      |                                             | Bottom Half         |
| construction:      |                                             | First Two Thirds    |
| construction:      |                                             | Last Two Thirds     |
| construction:      |                                             | Top Left            |
| construction:      |                                             | Top Right           |
| construction:      |                                             | Bottom Left         |
| construction:      |                                             | Bottom Right        |
| construction:      |                                             | First Fourth        |
| construction:      |                                             | Second Fourth       |
| construction:      |                                             | Third Fourth        |
| construction:      |                                             | Last Fourth         |
| construction:      |                                             | Next Display        |
| construction:      |                                             | Previous Display    |

## Bugs and feature requests

Have a bug or a feature request, please open a new issue.

## Contributing

Contributions are most welcome to fix bugs or to add new features.

### Environment

- You need to have [AutoHotkey v2](https://github.com/AutoHotkey/AutoHotkey) installed.
- I recommend using Visual Studio Code or other VS Code based editors like Cursor.
- You need to have the `AutoHotkey v2 Language Support` extension installed by searching with the `thqby.vscode-autohotkey2-lsp` extension ID.
- If AutoHotkey is located in a different location other than `C:\Program Files\AutoHotkey\v2\AutoHotkey.exe`, then set the `AutoHotkey2.InterpreterPath` setting to point to the correct location.
- You need to have the `EditorConfig` extension installed by searching with the `EditorConfig.EditorConfig` extension ID.
- You need to have the `EditorConfig for VS Code` extension installed by searching with the `EditorConfig.EditorConfig` extension ID.
- You need to have the `Prettier - Code formatter` extension installed by searching with the `esbenp.prettier-vscode` extension ID.

### Structure

The repository is structured pretty flat to keep things simple and find all necessary files easily. Polygon is developed as a single AHK file named `polygon.ahk` for now. I may in the future refactor it into multiple files if the push comes to shove.

### Commit Convention

Before you create a Pull Request, please check whether your commits comply with the commit conventions used in this repository.

When you create a commit I kindly ask you to follow the convention `category(scope): message` in your commit message while using one of the following categories:

- `feat`: all changes that introduce completely new code or new features
- `fix`: changes that fix a bug (ideally you will additionally reference an issue if present)
- `refactor`: any code related change that is not a fix nor a feature
- `docs`: changing existing or creating new documentation (i.e. README, docs for usage of a lib or cli usage)
- `build`: all changes regarding the build of the software, changes to dependencies or the addition of new dependencies
- `ci`: all changes regarding the configuration of continuous integration (i.e. github actions, ci system)
- `chore`: all changes to the repository that do not fit into any of the above categories

### Release

Please follow the following release checklist and convention.

- :white_check_mark: The changes for the new version have been added to the `CHANGELOG.md` file.
- :white_check_mark: The new version has been updated in the `polygon.ahk` file.

Use the following release note body for each release.

```md
Please refer to [CHANGELOG.md](https://github.com/thesobercoder/polygon/blob/main/CHANGELOG.md) for details.
```

## License

Licensed under the [MIT license](https://github.com/thesobercoder/polygon/blob/main/LICENSE).
