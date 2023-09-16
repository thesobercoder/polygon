# Polygon

A [Mac Rectangle](https://github.com/rxhanson/Rectangle) inspired window manager for Windows 10/11 powered by AutoHotkey.

> [!NOTE]
> Polygon is still a work in progress and aims to have 100% feature compatibility with Rectangle.

## Installation

- Download the compiled executable from the latest [release](https://github.com/thesobercoder/polygon/releases/latest).
- Copy the `polygon-*.exe` that you downloaded based on your architecture to the `shell:startup` directory.

If you followed everything correctly, Polygon should start with Windows logon after the next reboot.

## Usage

Here are the shortcuts available in Polygon.

| Shortcut                                    | Layout              |
| ------------------------------------------- | ------------------- |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>C</kbd> | Center              |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>Q</kbd> | Center 1920x1080    |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>W</kbd> | Center Half         |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>R</kbd> | Center Two Third    |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>D</kbd> | First Third         |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>F</kbd> | Center Third        |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>G</kbd> | Last Third          |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>Z</kbd> | Top Left Sixth      |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>X</kbd> | Bottom Left Sixth   |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>V</kbd> | Top Right Sixth     |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>B</kbd> | Bottom Right Sixth  |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>N</kbd> | Top Center Sixth    |
| <kbd>CTRL</kbd>+<kbd>WIN</kbd>+<kbd>M</kbd> | Bottom Center Sixth |

## Known Issues

Here are some known issues. Contributions are welcome.

- Some windows have an invisible margin and will leave a gap when resized.

## Bugs and feature requests

Have a bug or a feature request, please open a new issue.

## Contributing

Contributions are most welcome to fix bugs or add new features.

### Environment

- You need to have [AutoHotkey v2](https://github.com/AutoHotkey/AutoHotkey) installed.
- I recommend using Visual Studio Code or other VS Code based editors like Cursor.
- You need to have the `AutoHotkey v2 Language Support` extension installed by searching with the `thqby.vscode-autohotkey2-lsp` extension ID.
- You also need to make sure that `AutoHotkey v2 Language Support` is able to find the AutoHotkey executable.
- You need to have the `EditorConfig` extension installed by searching with the `EditorConfig.EditorConfig` extension ID.
- You need to have the `EditorConfig for VS Code` extension installed by searching with the `EditorConfig.EditorConfig` extension ID.
- You need to have the `Prettier - Code formatter` extension installed by searching with the `esbenp.prettier-vscode` extension ID.

### Structure

The repository is structured pretty flat to keep things simple and find all necessary files easily. Polygon is developed as a single AHK file named `polygon.ahk` for now. I may in the future refactor it into multiple files if the push comes to shove.

### Commit Convention

Before you create a Pull Request, please check whether your commits comply with the commit conventions used in this repository.

When you create a commit I kindly ask you to follow the convention `category(scope or module): message` in your commit message while using one of the following categories:

- `feat`: all changes that introduce completely new code or new features
- `fix`: changes that fix a bug (ideally you will additionally reference an issue if present)
- `refactor`: any code related change that is not a fix nor a feature
- `docs`: changing existing or creating new documentation (i.e. README, docs for usage of a lib or cli usage)
- `build`: all changes regarding the build of the software, changes to dependencies or the addition of new dependencies
- `ci`: all changes regarding the configuration of continuous integration (i.e. github actions, ci system)
- `chore`: all changes to the repository that do not fit into any of the above categories

## License

Licensed under the [MIT license](https://github.com/thesobercoder/polygon/blob/main/LICENSE).
