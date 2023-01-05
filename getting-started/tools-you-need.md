# Tools You Need

Pre-requisite: you need to know how to install and play a mod already.

## Essential Tools

### 1. XML Editor

You can start modding any special tools by simply modifying existing mods with Notepad. But I strongly recommend to use an editor with built-in XML support.

Best use [Visual Studio Code](https://code.visualstudio.com/) as it comes with a [plugin for Anno Modding](https://marketplace.visualstudio.com/items?itemName=JakobHarder.anno-modding-tools).
Open it, go to `Extensions` (Ctrl+Shift+X) and search for `Anno Modding Tools` to install the plugin.

### 2. RDAExplorer

The [RDAExplorer](https://github.com/lysannschlegel/RDAExplorer) is a tool to extract files from the game.
You need this to understand what's in the game and reuse graphics.

If you have the space, I recommend to extract all `.rda`s into one folder beginning from 0 to the highest number.

Some `.rda`s have the same file again (e.g. `assets.xml`), the file from the highest numbered `.rda` is the only one the game will use.

### 3. Assets Search

If you want to do more than changing some values of existing mods, you need to research or refer to existing definitions called `Assets` of the game.

You have two option for that:
- use [Schwubbe's online Asset Search](https://schwubbe.de/modding_blog.php#beitrag15) or,
- extract `assets.xml` with the RDAExplorer and use Visual Studio Code search (Ctrl+Shift+F)

## Anno Tools Overview

### Essentials

- [Mod Loader](https://github.com/xforce/anno1800-mod-loader) (includes `xmltest` for testing)
- [RDAExplorer](https://github.com/lysannschlegel/RDAExplorer) (or use this [.NET6 fork](https://github.com/jakobharder/RDAExplorer) if you embed dlls in your project)

### Code Editors

- [Visual Studio Code](https://code.visualstudio.com/Download)
- [Anno Modding Tools plugin for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=JakobHarder.anno-modding-tools)

### Models, Textures

- [RDM <> glTF Converter](https://github.com/lukts30/rdm4) (commandline converter)
- [Blender CFG Import/Export plugin](https://github.com/xormenter/Blender-Anno-.cfg-Import-Addon)
- [annotex](https://github.com/jakobharder/annotex) (commandline PNG > DDS converter with LOD generation)
- [Gimp DDS plugin](https://gist.github.com/taubenangriff/cb959efa00896d84c99236ea705680c2)

### Other

- [FileDBReader](https://github.com/anno-mods/FileDBReader) (commandline file converter for various Anno formats)
- [AnnoFCConverter](https://github.com/jakobharder/AnnoFCConverter) (out of support, use FileDBReader instead)
- [Map Editor](https://github.com/anno-mods/AnnoMapEditor)
- [iModYourAnno](https://github.com/anno-mods/iModYourAnno) (mod manager)
