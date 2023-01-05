# Structure of a Mod

## Overall Folder Structure

Core contents of a mod:
- assets.xml: game object definitions, pure retexture mods may not need it
- texts_*language*.xml: localization
- graphics: models, textures, icons etc.
- modinfo.json: optional, but highly recommended information about dependencies and versions

Most parts have a fixed name and location in order to work.
The following example shows the expected folders and files for a skin mod.

```yaml
- [Skin] Residence Skins/
  - data/
    - config/
      - export/
        - main/
          - asset/
            - assets.xml     # game object definitions
      - gui/
        - texts_english.xml  # Localization
        # ... other languages
    - jakob/                 # this is your graphics folder
                             # Vanilla uses 'graphics' and 
                             # some mods simply use 'modgraphics'
  - banner.jpg               # or banner.png, picture for mod managers
  - modinfo.json             # meta information for mod managers
  - README.md                # description (not only) for mod managers
```

## Mod Name

Mod names should follow the following scheme:
`[category] mod-name`.

You can additionally add the author name in brackets to help managing bigger collections: `[category] mod-name (author)`.

There's no hard rule how to name categories, people have different opinions and the preferred names have slightly changed over time.

| Category | When to use
| - | -
| Addon | Bigger collection of a mixture of the below.
| Building | New buildings, production chains, etc.
| Gameplay | Game balancing or new game mechanics.
| Misc | Everything else.
| Module | Docklands, museum etc. modules.
| Ornamental | Ornament collecions.
| Shared | Shared textures, products, production chains.
| Skin | Paintbrush skins, Shift+V variants. Everything without it's own construction menu entry.
| UI | Construction menu, icon changes.

If you have a category mix just choose one that fits to the prominent part of your mod.

## assets.xml

This file contains the definition, configuration of the mod.

Most of the following guide pages will explain how to write it and best practices, so I'll skip it here.

## modinfo.json

This file allows you to provide some meta information to your mod like verion, dependencies to other mods or DLCs.

Best you check out the [modinfo.json documentation](https://github.com/anno-mods/Modinfo) directly if you need to understand more.

## Graphics Folder Structure

There are many ways to structure your graphics folder.
I recommend to put as much as possible under your personal folder to avoid clashes with other mods.

⚠ Note: Make sure your files are uniquely named. A file in the same folder with the same name in another mod will clash.

Here is one example how I do it:

```yaml
- [Skin] Residence Skins (Jakob)/
  # ...
  - data/jakob/             # mod content under author name
    - artisan-skins/        # feature to group your stuff
      - maps/               # textures in DDS format
        - residence_tier3_1b_diff_0.dds
        # ...
      - skin1/              # icon, model description, ...
        - icon_artisan_blue.png
        - residence_tier03_estate01.cfg
        - residence_tier03_estate01.fc
        - residence_tier03_estate01.ifo
      - rdm/                # model files in custom RDM format
        - tier03_01_lod0.rdm
        # ...
      - assets.include.xml  # contains definitions of 'artisan-skins'
  # ...
```
