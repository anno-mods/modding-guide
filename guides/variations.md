# Object Variations

## Add Variations to a Building

Shift+V variations

Keys you need to set:

- `AllowChangeVariation` in `/Values/Building`
- Multiple `Item` entries in `/Values/Object/Variations`
- (optional) `VariationIcons` in `/Values/Building` when using [variation change arrows](#variation-change-arrows)
- (optional) `BuildModeStartVariation`

Every building has at least one `/Values/Variations/Item` entry.
You just need to add more entries and set `AllowChangeVariation` to `1` and you are done.

Use `BuildModeStartVariation` to select a specific default variation instead of random choice when the player starts building: 
- The index starts with `0` for the first cfg-entry in `Objects`, `1` for the second cfg-entry and so on.
- You won't be able to prevent AI players to use other variations though.

Modifying an existing building can be as short as:

```xml
<ModOp Type="add" GUID='100415' Path="/Values/Building">
  <AllowChangeVariation>1</AllowChangeVariation>
</ModOp>
<ModOp Type="add" GUID='100415' Path="/Values/Object/Variations">
  <Item>
    <Filename>data/jakob/buildings/townhall/townhall.cfg</Filename>
  </Item>
</ModOp>
```

⚠ Important: You need to make sure that you don't have `QuestObject` in your building and template.
It will prevent the variations from working.

Example: [New Town Hall](https://github.com/jakobharder/anno-1800-jakobs-mods) (as variations adds variations to an existing building, as buildings adds a new building with variations). 

### Variation Change Arrows in the UI

You can enable arrows to switch through your variations like you know it from palace modules or depots **if you use the Generic UI** (default for ornamental buildings).
Therefore set icons for the variations by adding this to `Asset/Values/Building`:

```xml
<VariationIcons>
  <Item>
    <IconFilename>data/ui/2kimages/main/3dicons/icon_gasometer_1.png</IconFilename>
  </Item>
  <!-- one entry per variation -->
</VariationIcons>
```

## Automatically Change Variation Based on Neighbors

Fences, walls and residences with corner buildings use this mechanism.

Keys you need to set in `/Values/Building`:

- `InfluencedByNeigbors` - list all neighboring buildings that trigger a variation change
- `BuildingBlockPool` - define what is used for a middle, end, crossing etc.
- `InfluencedVariationDirection` - define which `BuildingBlockPool` is used for each neigboring scenario

### InfluencedByNeighbors

```xml
<InfluencedByNeighbors>
  <Item>
    <Building>101254</Building>
  </Item>
  <!-- as many influencers as you like -->
</InfluencedByNeighbors>
```

### BuildingBlockPool

Define which variation (index of `Object/Variations` entry) is used for the pools.
When which pool is triggered is defined by `InfluencedVariationDirection`.

You can *fix* the direction of an individual variation here with `DirectionOffet`. ⚠ The typo is in the game. Direction rotates counter clock wise.

```xml
<BuildingBlockPool>
  <Single>
    <Pool>
      <Item>
        <DirectionOffet>2</DirectionOffet>
        <Variation>0</Variation>
      </Item>
      <Item>
        <Variation>1</Variation>
      </Item>
      <!-- ... -->
    </Pool>
  </Single>
  <!-- below follow the same structure as Single -->
  <DontCare />
  <Corner />
  <Mid />
  <End />
  <TCrossing />
  <Crossing />
</BuildingBlockPool>
```        

Multiple entries of the same variation for different rotations don't work.
But vanilla assets.xml also defines them, so they were supposed to work at some point.

Defaults are 0. `<Item />` is an item with variation and direction set to zero.

Pools can be empty if you don't use them.

### InfluencedVariationDirection

Contains a list of exactly 16 items with a fixed scenario (end, mid, ...) for each.

The following is an example I used for New World tier 3 buildings.

```xml
<InfluencedVariationDirection>
  <Item>
    <!-- single -->
    <Direction>0</Direction>
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- end, south-west -->
    <Direction>1</Direction>
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- end, south-east -->
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- corner, south -->
    <Direction>2</Direction>
    <Type>Corner</Type>
  </Item>
  <Item>
    <!-- end, north-east -->
    <Direction>1</Direction>
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- mid, south-west to north-east -->
    <Direction>1</Direction>
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- corner, east -->
    <Direction>3</Direction>
    <Type>Corner</Type>
  </Item>
  <Item>
    <!-- T, front facing south-east -->
    <Direction>3</Direction>
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- end, north-west -->
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- corner, west -->
    <Direction>1</Direction>
    <Type>Corner</Type>
  </Item>
  <Item>
    <!-- mid, north-west to south-east -->
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- T, front facing south-west  -->
    <Direction>2</Direction>
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- corner, north -->
    <Type>Corner</Type>
  </Item>
  <Item>
    <!-- T, front facing north-west -->
    <Direction>1</Direction>
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- T, front facing north-east -->
    <Type>Mid</Type>
  </Item>
  <Item>
    <!-- crossing -->
  </Item>
</InfluencedVariationDirection>
```

Direction rotates counter clock wise.
Default facing is X towards NW, Y towards NE.

⚠ `DontCare` does seem to include all variations, even if you didn't define them in the `BuildingBlockPool`.

Defaults are 0. `<Item />` is an item with variation and direction set to zero.


# Object Skins

You can add multiple `Skins` to your building by adding this to `Asset/Values/Object`:

```xml
<Skins>
   <DefaultSkinName>23852</DefaultSkinName>
   <DefaultSkinDescription>23853</DefaultSkinDescription>
   <OverrideDefaultIcon>data\ui\2kimages\main\3dicons\narative_item\icon_skin_large_generic_brick_new_01.png</OverrideDefaultIcon>
     <SkinList>
       <Item>
         <SkinAssetGuid>1000888</SkinAssetGuid>
       </Item>
       <!-- One entry per Skin -->
     </SkinList>
</Skins>
```

The first skin is the building you defined in `Asset/Values/Object`. This skin is called **Default Skin** and is automatically applied when you select the building directly in the construction menu. 
- `DefaultSkinName` is the name for this skin shown in the UI. 
- `DefaultSkinDescription` is the corresponding description which pops up when you hover over the skin icon in the UI.
- (optional): With `OverrideDefaultIcon` you can assign an icon to your default skin, which is different from the construction menu icon for that building. 

- With `SkinAssetGuid` you add a second, third, forth etc. skin. Each Guid has to be defined in an explicit asset: 

```xml
<Asset>
   <Template>Skin</Template>
   <Values>
     <Standard>
       <GUID>1000888</GUID>
       <Name>My Second Skin</Name>
       <IconFilename>data\ui\2kimages\main\3dicons\icon_my_second_skin.png</IconFilename>        
     </Standard>
     <Skin>  
       <SkinName>1000889</SkinName>       
       <SkinDescription>1000890</SkinDescription> 
       <SkinVariations>
         <Item>
           <FileName>data\graphics\mod_buildings\my_second_skin.cfg</FileName>
         </Item>  
         <!-- One entry per Object Variation -->
       </SkinVariations>
     </Skin> 
     <Locked />
   </Values>
</Asset>
```

- `IconFilename`: Icon for this skin, shown in the UI.
- `SkinName`: The name for this skin, shown in the UI. 
- `SkinDescription`: The description for this skin, shown in the UI (pop-up only). 
- `FileName`: Path to your cfg. ⚠ Yes, it´s **FileName** (capitalized N) for skins! 

If you have more than one variation in `Object/Variations` you also have to add the same amount of item entries in `SkinVariations`, since the game works index based here. So e.g. if you have 5 different building variations (shift V) you also need 5 skin variations for each skin you add. Otherwise the game gets confused and variation / skin cycles can be broken

Skins need to be unlocked via trigger, unless you set `DefaultLockedState` to `0`. 
