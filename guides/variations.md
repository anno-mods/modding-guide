# Object Variations

## Add variations to a building

Shift+V variations.

Keys you need to set:

- `AllowChangeVariation` in `/Values/Building`
- Multiple `Item` entries in `/Values/Object/Variations`
- (optional) `VariationIcons` in `/Values/Building` when using [variation change arrows](#variation-change-arrows)
- (optional) `BuildModeStartVariation`

Every building has at least one `/Values/Variations/Item` entry.
You just need to add more entries and set `AllowChangeVariation` to `1` and you are done.

Use `BuildModeStartVariation` to select a specific default variation instead of random choice when the player starts building.
You won't be able to prevent AI players to use other variations though.

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

Example: [New Town Hall](https://github.com/jakobharder/anno-1800-jakobs-mods) (as variations adds variations to an existing building, as buildings adds a new building with variations). 

### Variation change arrows

You can also enable arrows to switch through your variations like you know it from palace modules or depots if you use Generic UI (default for ornamental buildings).

⚠ Important: You need to make sure that you don't have `QuestObject` in your building or template.
It will prevent the arrows from showing somehow.

You can set icons for the variations by adding this to `Asset/Values/Building`:

```xml
<VariationIcons>
  <Item>
    <IconFilename>data/ui/2kimages/main/3dicons/icon_gasometer_1.png</IconFilename>
  </Item>
  <!-- one entry per variation -->
</VariationIcons>
```

## Automatically change variation based on neighbors

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
