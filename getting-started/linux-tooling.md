# Linux tooling

## Installing wine

Use your distribution package manager to install [Wine](https://www.winehq.org/).

From this point on, we will use a dedicated wine prefix for Anno tooling.

## Running RDA explorer

Download and extract RDA explorer as explained in the main [tooling](./tools-you-need.md) page.

Install requirements:
```shell
export WINEPREFIX=~/.wine-anno-tooling
winetricks dotnet48 dxvk
```
Then run RDAExplorer:
```shell
wine /path/to/extracted/folder/RDAExplorerGUI.exe
```
