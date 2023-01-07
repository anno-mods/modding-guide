# GU16 Update Guide

## Crashes

The most common reason for crashes are `Asset`s that have a wrong template.
That was OK in previous versions, but it needs to be correct with GU16.

Usually it crashes when you load the game with a building/ship that has the problem.
Or when you build or select such a building/ship.

### Find the trouble maker

- Crash when loading: disable mods until you find the crashing mod.
- Crash on selection: build everything and select it once.

### Remove the problem

Now go into the mod and find the `Asset` you want to fix.
Have a look at [Change an existing mod](../getting-started/change-existing-mod.md) if you don't know how to.

Now check the `<Template>` entry. If it has `<BaseAssetGUID>` you need to find that asset and repeat the search for the template.

Now you need to check all tags that are listed under `<Values>` in your problematic asset and compare it with `<Properties>` in the template.

The game crashes when there are entries in the asset, that are not in the template.

THe easy fix is to remove those, but that may break the feature - but at least you can start the game with that mod again.

### Fix the problem

In order to fix the problem you need to create or adjust templates.

Create file called `templates.xml` next to the `assets.xml` if not there already and make sure it has `ModOps` tags in it.

```xml
<ModOps>
</ModOps>
```

Now copy the whole section from `<Template>` to `</Template>` into a `<ModOp>` like below:

```xml
<ModOps>
  <ModOp Type="addNextSibling" Template="FactoryBuilding7">
    <Template>
      <!-- ... -->
    </Template>
  </ModOp>
</ModOps>
```

In the template, change the `<Name>` to something unique with your name in it, e.g. `jakob_FactoryBuilding7`.

The only thing left now is to add all the tags that in your asset but not in the template.

Example of adding `ModuleOwner`:
```xml
<ModOps>
  <ModOp Type="addNextSibling" Template="FactoryBuilding7">
    <Template>
      <Name>jakob_FactoryBuilding7</Name>
      <Properties>
        <!-- ... all the old properties ... -->
        <ModuleOwner />
      </Properties>
    </Template>
  </ModOp>
</ModOps>
```

## Missing entry in construction menu

You need to replace some `GUID`s to fix where construction icons are added.

For example `500944` is the old moderation city menu. You need to change that to `500092`.

```diff
-<ModOp Type="add" GUID='500944' Path="/Values/ConstructionCategory/BuildingList">
+<ModOp Type="add" GUID='500092' Path="/Values/ConstructionCategory/BuildingList">
    <Item>
        <Building>77100010</Building>
    </Item>
</ModOp>
```

| Old GUID | Menu | New GUID | Menu
| --- | --- | --- | ---
| 500944 | OW City | 500092 | "
| | | 500094 | OW Public Services
| 25000197 | OW Culture | 500116 | OW Culture 
| | | 500069 | OW Ornament Classic 
| | | 500067 | OW Ornament Park
| | | 500068 | OW Ornament City
| | | 500059 | OW Ornament Industry
| 500903 | OW Harbor | 500111 | OW Ornament Harbor
| 500946 | NW City | 500137 | "
| | | 500138 | NW Public Services
| 500951 | NW Culture | 500150 | NW Culture
| | | 500055 | NW Ornament Classic 
| | | 500053 | NW Ornament Park
| | | 500079 | NW Ornament City
| | | 500058 | NW Ornament Industry
| 25000195 | NW Harbor | 500149 | "
