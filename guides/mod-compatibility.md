# Mod Compatibility Guide

- [General Best Practices](#general-best-practices)
- [Construction Menu](#construction-menu)
- [Shared Product Mods](#shared-product-mods)
- [Shared Production Mods](#shared-production-mods)
- [Shared Item Effect Pools](#shared-item-effect-pools)
- [Shared Assets between Mods](#shared-assets-between-mods)
- [Hotel Needs](#hotel-needs)

## General Best Practices

- Make changes to existing assets as small as possible.
  Don't `replace` the whole thing.
- Avoid removing stuff. You never know who used that as an anker to insert new stuff.
- DO NOT remove entries from `Template`s. You may crash other mods with that.
- Use unique names for new `Template`s. Best use your name or the mod name as a prefix.
- Use `Text/TextOverride` to rename vanilla text with new assets. You don't know who is using the original text in another context.

## Construction Menu

A common problem are mods replacing entries in the construction menus.
Imagine there's a mod replacing the fishery with a fishery menu, but your mod relies on that fishery entry to position itself after it.
Your entry won't show as a result.

### Best Practices

1. Don't replace/remove menus. Hide them instead
2. Insert with `shared-pools-and-definitions`
3. Add `compact-menu` group tag
4. Insert into production chains instead of replacing the whole chain

### Hide a menus

Hide entries by adding `PlatformVisibility` like this:

```xml
<ModOp Type="merge" GUID="500094"
  Path="/Values/ConstructionCategory/BuildingList/Item[Building='1010372']">
  <Item>
    <PlatformVisibility>Console</PlatformVisibility>
  </Item>
</ModOp>
```

Reason: other mods may use those entries to insert their building.

### Insert with `shared-pools-and-definitions`

Insert into progression menus by unlock condition instead of GUID.

```xml
<ModOp Type="addNextSibling" GUID="25000190"
  Path="/Values/ConstructionCategory/BuildingList/Item[Worker&lt;=400][last()]">
  <Item>
    <Building>1500010111</Building>
    <Worker>400</Worker>
  </Item>
</ModOp>
```

The mod `shared-pools-and-definitions` adds unlock conditions for all vanilla buildings. You need to load after it.

Check [shared-pools-and-definitions guide](https://github.com/anno-mods/shared-resources/tree/main/%5BShared%5D%20Pools%20and%20Definitions#insert-into-progression-menus-by-unlock) for details.

### Add `compact-menu` group tag

Add tags to ensure your mod buildings are inserted into the correct groups up by the Compact Menu mod.

The following for example makes the building show up as part of the administration group (town hall, guild house and harbor master).

```xml
<Item>
  <Building>123</Building>
  <CompactAdministration />
</Item>
```

Check [compact-menu guide](https://github.com/jakobharder/anno1800-jakobs-mods/blob/main/mods/ui-compact-menu/README.md#modders) for details.

## Shared Product Mods

A good way to share products between sevaral mods is to use a shared product mod.

A shared product mod should contain:
- a single complete `Product` template asset
- an icon and all translations
- storage `120055` listing
- expedition values, if applicable
- ideally, a hidden fake factory with `IsMainFactory=1`. Users must use `0`.
- Docklands entries, if applicable

A shared product mod **SHOULD NOT** contain:
- a production building
- fertility entries
- anything that is not explicitely mentioned above

Use the product name as the `ModID` (`product-author`), e.g. `product-author`.

See [tea-jakob](https://github.com/jakobharder/anno1800-shared-mods/tree/main/mods/tea-jakob) for an example / template.

## Shared Production Mods

Especially raw material production is also good to share between mods.

A shared production mod should contain:
- a single production or production chain
- icons, all translations
- product listings and unlocks
- a production chain menu and construction menu entry, if it produces an product
- fertility entries, if applicable
- it may or may not include the product. Be clear about it, and don't remove it in future versions.

Use the product name plus producing region as the `ModID` (`region-product-author`), e.g. `ow-hemp-jakob`.

The reason for unlocks is to keep product listings and unlock aligned.
Also balancing is easier if everyone has the same base.

You may unlock a shared production earlier, if you really have to.

See [ow-hemp-jakob](https://github.com/jakobharder/anno1800-shared-mods/tree/main/mods/ow-hemp-jakob) for an example / template.

## Shared Item Effect Pools

Use `ItemEffectTargetPool`s from `shared-pools-and-definitions` to avoid many, very similar building names in buff InfoTips.

```xml
<!-- add to pools having sand mine -->
<ModOp Type="add"
  Path="//ItemEffectTargetPool/EffectTargetGUIDs[Item/GUID='1010560']">
  <Item>
    <GUID>1500010708</GUID> <!-- NW Sand Pit -->
  </Item>
</ModOp>
```

Check [shared-pools-and-definitions guide](https://github.com/anno-mods/shared-resources/tree/main/%5BShared%5D%20Pools%20and%20Definitions) for details and a list of all new available pools.

## Shared Assets between Mods

Products, effect pools and build menus are good examples of assets you want to include in several mods but add only once to the game.

You find community shared assets here - for use and as examples: [shared-resources](https://github.com/anno-mods/shared-resources).

### Add Product only once to storage list

The following adds Cheese `1500010102` to the market storage list `120057` after sausages `1010238`, but only if it is not already there.

```xml
<ModOp Type="addNextSibling" GUID="120057" Path="/Values/ProductStorageList/ProductList/Item[Product='1010238' and not(../Item/Product='1500010102')] | //Values[Standard/GUID='1500010221']/ProductStorageList/ProductList/Item[last()]">
  <Item>
    <Product>1500010102</Product>
  </Item>
</ModOp>
```

Here we select the item `1010238` and then do ` and not(../Item/Product='1500010102')` to make sure the list does not include Cheese already.

If you want to avoid modloader warnings (recommended), then you can do one more trick with `| //Values[Standard/GUID='1500010221']/ProductStorageList/ProductList/Item[last()]`. You can basically select an alternative node with `|` to insert your product. You only need to make sure to add a fake storage list your self - and delete it afterwards like below:

```xml
<ModOp Type="addNextSibling" GUID="120055">
  <Asset>
    <Template>fallback</Template>
    <Values>
      <Standard>
        <GUID>1500010221</GUID>
      </Standard>
      <ProductStorageList>
        <ProductList>
          <Item />
        </ProductList>
      </ProductStorageList>
    </Values>
  </Asset>
</ModOp>
<!-- ... add product with fallbacks here ... -->
<ModOp Type="remove" GUID="1500010221" />
```

### Create Shared Pool and Add from Several Mods

Generally, adding multiple versions of the same asset is ot a problem.
But if you want to have a shared list like an effect pool or a construction category you need to make sure it's only one entry and every mod adds to that.

```xml
<!-- add dummy + default list -->
<ModOp Type="addNextSibling" GUID="190886">
  <Asset>
    <Template>ItemEffectTargetPool</Template>
    <Values>
      <Standard>
        <GUID>1500010714</GUID>
        <Name>duplicate</Name>
      </Standard>
    </Values>
  </Asset>
  <Asset>
    <Template>ItemEffectTargetPool</Template>
    <Values>
      <Standard>
        <GUID>1500010714</GUID>
        <Name>all sand mines</Name>
      </Standard>
      <ItemEffectTargetPool>
        <EffectTargetGUIDs>
          <Item>
            <GUID>1010560</GUID>
          </Item>
        </EffectTargetGUIDs>
      </ItemEffectTargetPool>
    </Values>
  </Asset>
</ModOp>
<!-- remove duplicate -->
<ModOp Type="remove" Path="//Asset[Values/Standard/GUID='1500010714'][position() &amp; last()]"/>
<!-- add -->
<ModOp Type="add" Path="//ItemEffectTargetPool/EffectTargetGUIDs[Item/GUID='1010560']">
    <Item>
      <GUID>1500010708</GUID>
    </Item>
  </ModOp>
```

You add your empty/default list and then remove every entry except the last. Important always do it at the same spot, so that the last entry is always the first that has been added.

Then you can add your non-shared entries to the list with another ModOp.

Note the dummy list: this is to prevent the remove ModOp doesn't find anything to remove if your mod is the first to add this shared list.

### Docklands: exactly one `IsMainFactory=1` per product

If your product is available in Docklands you need to make sure it has the `IsMainFactory` set in one production building.
If you set none you will get corrupt pricing, if you have 2 or more all production buildings will disappear.

```xml
<Asset>
  <Template>FactoryBuilding7</Template>
  <Values>
    <!-- ... -->
    <FactoryBase>
      <!-- ... -->
      <IsMainFactory>1</IsMainFactory>
    </FactoryBase>
    <!-- ... -->
  </Values>
</Asset>
```

Hint: you can also provide a fake factory that is always locked and not added to construction menus if you want to provide Docklands only products.

## Hotel Needs

If you want to create hotels in any region you should include [assets-hotel-needs.include.xml](https://github.com/anno-mods/shared-resources/tree/main/compat).

It is a shared include that allows for easier compatibility handling between Old World and New World hotels.

The include adds `RequiredToBeBuilding` and a region (e.g. `<Region>Colony01</Region>`) to all Tourist needs.
Instead of working with single hotel GUIDs you can use the `Region` now as an anker for your ModOp queries.
