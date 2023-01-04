# Mod Compatibility Guide

General Hints:

- Make changes to existing assets as small as possible.
  Don't `replace` the whole thing.
- Avoid removing stuff. You never know who used that as an anker to insert new stuff.
- DO NOT remove entries from `Template`s. You may crash other mods with that.
- Use unique names for new `Template`s. Best use your name or the mod name as a prefix.

## Construction Menu

A common problem are mods replacing entries in the construction menus.
Imagine there's a mod replacing the fishery with a fishery menu, but your mod relies on that fishery entry to position itself after it.
Your entry won't show as a result.

### Best Practices

1. Avoid removing/replacing construction menu entries
2. Insert into production chains instead of replacing the whole chain
3. Add fallback code if you insert before or after a construction entry

### Fallback if addNextSibling/addPrevSibling entry is missing

The following code adds `1500010050` after the Town Hall `100415` in both City `500092` and Artisan `25000191` menus - or at the end if the Town Hall entry is missing.

```xml
<ModOp Type="addNextSibling" GUID='500092,25000191' Path="/Values/ConstructionCategory/BuildingList/Item[Building='100415' or (not(../Item/Building='100415'))][last()]">
    <Item>
      <Building>1500010050</Building>
    </Item>
  </ModOp>
```

The fallback has two parts.
First you select any `Item` of lists that don't include `100415` with `not(../Item/Building='100415')`.
But since that will select all menu entries, you need to reduce the selection to the last one with `[last()]`.

You can skip this fallback if you're inserting after a production chain or category. Usually GUIDs only change when single entries are converted into chains or categories.

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
