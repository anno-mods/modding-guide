# How To: Change an Existing Mod

A common first step into modding is to have a look at existing work.

What you need:
- an [XML editor like Visual Studio Code](./tools-you-need.md#1-xml-editor)
- basic understanding how XML works

## ModOp Basics

First you need to have a basic understanding how XML patches work.

All XML files in mods have several entries like the following:

```xml
<ModOp GUID='100780' Type='addNextSibling'>
  <!-- stuff in here -->
</ModOp>
```

Those are `ModOp`s. They add, remove or change assets in the game.
You need to know more about them, if you want to change more than some simple values.

## Change Maintenance

Let's start with a simple example.
You want to change the maintenance cost of [Nate's Windmill](https://github.com/jakobharder/anno-1800-jakobs-mods/releases).

### Finding the GUID

`GUID`s are unique identifiers.
Every game object definition aka `Asset` has one.

First you need the building.
You can do that by searching "Nate's Windmill" in `data\config\gui\texts_english.xml`.
Hint: you can hit `Ctrl+Shift+F` in Visual Studio Code to quickly search all files.

You'll find an entry with text and it's `GUID`.

```xml
<Text>
  <GUID>1500010001</GUID>
  <Text>Nate's Windmill</Text>
</Text>
```

### Finding the Asset

It's easy to find the asset when you search for the `GUID`.
The result should look like this:

```xml
<ModOp GUID='100780' Type='addNextSibling'>
  <Asset>
    <Template>JakobPowerplantWithRadius</Template>
    <Values>
      <Standard>
        <GUID>1500010001</GUID>
        <Name>nates_windmill</Name>
        <IconFilename>data\jakob\nates-windmill\icon_nates_windmill.png</IconFilename>
        <InfoDescription>1500010004</InfoDescription>
      </Standard>
      <!-- ... -->
```

Usually you find stuff you want to change in `data\config\export\main\asset\assets.xml` but in this case it's actually `data\jakob\nates-windmill\assets.include.xml`.
Especially more recent mods have their assets distributed across several files.

### Understanding the Asset

General structure of an asset.

```xml
<Asset>
  <Template>template name</Template> <!-- or sometimes <BaseAssetGUID> -->
  <Values>
    <Standard>
      <GUID>1500010001</GUID>
      <Name>random name</Name> <!-- not used in-game -->
      <!-- -->
    </Standard>
    <A>
      <!-- -->
    </A>
    <B>
      <!-- -->
    </B>
    <C>
      <!-- -->
    </C>
  </Values>
</Asset>
```

Assets have a `Template` or an `BaseAssetGUID`.
They define what features aka property sections that asset has within `Values`.

They always have a `Standard` property section, definining the `GUID` and other things.

The remaining property sections vary a lot.

⚠ Note: the game crashes when there is a property section that is not defined in the template. This was a common reason for crashes with GU16.

### Changing the Maintenance

If you scroll a bit through the asset of Nate's Windmill, you'll find a `Maintenance` property section.

```xml
<Maintenance>
  <IncomeCategory>ProductionBuildings</IncomeCategory>
  <Maintenances>
    <Item>
      <Product>1010017</Product> <!-- Coins -->
      <Amount>400</Amount>
    </Item>
    <Item>
      <Product>1010115</Product> <!-- Workers -->
      <Amount>20</Amount>
      <ShutdownThreshold>0.5</ShutdownThreshold>
    </Item>
  </Maintenances>
</Maintenance>
```

You can change here the amount of coins or workers needed.
Or even exchange and add/remove furter maintenance `Item`s.

The number in `Product` is just another `GUID`.

You can use [Schwubbe's online Asset Search](https://schwubbe.de/modding_blog.php#beitrag15) to figure out the `GUID` of engineers for example.

## Pitfalls and Best Practices

### Delete .cache

Always delete the `.cache` folder in `mods/`. The modloader doesn't recognize changes in `*.include.xml` files for example.

### Change gets overwritten

Sometimes mods add an asset and have in other XMLs instructions to change individual values.

⚠ These cases are too complicated for beginners, but usually you don't need to touch them.

An example in `Nate's Windmill` is the `IndustrializationDistance`.
It is defined in the asset once, but there is another instruction in `cheats.include.xml` that overwrites it.
Especially mods that provide [iModYourAnno](https://github.com/anno-mods/iModYourAnno/releases) tweaks will have that.

In `nates-windmill/assets.include.xml`:
```xml
<Powerplant>
  <IndustrializationDistance>6</IndustrializationDistance>
</Powerplant>
```

In `cheats.include.xml`:
```xml
<ModOp GUID="1500010001" Type="replace"
       Path="/Values/Powerplant/IndustrializationDistance"
       ModOpID="Range" Skip="1">
  <IndustrializationDistance>6</IndustrializationDistance>
</ModOp>
<!-- ... -->
<ImyaExpose Path="self::*" ModOpID="Range" Kind="Slider" ExposeID="Range"
            Description="Increase electricity range.">
  <SliderDefinition Min="6" Max="16" Stepping="2" />
</ImyaExpose>
```
