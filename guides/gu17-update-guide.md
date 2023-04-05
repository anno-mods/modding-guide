# GU17 Update Guide

## Crashes

Invalid `modinfo.json` can crash the game at start-up.
Most common reason is using a string in `ModDependencies`:

```diff
- "ModDependencies": "base_mod",
+ "ModDependencies": [ "base_mod" ],
```

## Known Issues

Due to later loading of mods, there are some things that don't work currently:

- Key bindings don't work
- Changes to options menu don't work
- Loading screen changes don't work

## Modloader Changes

See [loader10](https://github.com/jakobharder/anno1800-mod-loader/blob/feature/loader10/doc/modloader10.md) for all new features and changes.

### Loading

- Mods in sub-folders will be loaded now
- Mods in .zip files will be loaded now

### Merge

Merge behavior has been made more predictable.

## Templates

GU16-like troubles should not occur anymore.


## Construction Menu

There's a new tag to overwrite `IconFilename` for construction menus only.
It is used in residences, meaning if you have any buildings based on residences your icon is overwritten now:

```xml
<Standard>
  <GUID>1500010225</GUID>
  <Name>Artisan Level 1</Name>
  <IconFilename>data/jakob/ui/icons/icon_artisan_scraper2.png</IconFilename>
</Standard>
<Constructable>
  <!-- overwrites IconFilename in construction menus -->
  <ConstructionMenuIcon>1500010225</ConstructionMenuIcon>
</Constructable>
```
