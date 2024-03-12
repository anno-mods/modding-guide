# Modding Infotips (tooltips)

You can mod the infotips this way:
https://github.com/jakobharder/anno1800-mod-loader/blob/main/doc/modloader11.md#patching-infotip-exportbin
You can extract the vanilla "data\infotips\export.bin" file with the FileDBReader (https://github.com/anno-mods/FileDBReader/releases) and the FileFormat "infotip.xml".
Alternatively I attached the extracted file in the modding discord channel here: https://discord.com/channels/578443209940926465/1146098268850376816/1149910673678159964  

For valid text-embed commands (I mean these [Selection Object ...] things you find in the file and texts), see the textsourcelist.json file from the game (unfortunately a bit outdated though..) or this huge list of textsource commands [lua ENUMs](https://github.com/anno-mods/modding-guide/blob/main/Scripting/ENUMs.md) while you can not directly use the wording from the link since it is lua form, see also  [textembeds](https://github.com/anno-mods/modding-guide/blob/main/Scripting/textembeds.md) )  
 

### Enums
Infotips are called **InfoTipData** in the code and are adressed as usual by Guids. Infotips use a lot of numbers to express operations. By default all non-defined integer values are 0. 
We have to test and find out the meaning ourself. Here what we already found out (no guarantee that it is correct):

- **InfoElement**
- - Each InfoTip is made of any number of InfoElements. Their order in the code corresponds to the display in the game: The first InfoElement (if visible, see below) represents the top of the Infotip and vice versa.

- **VisibilityElement**:
- - They usually contain conditions. And if the conditions are true, the content and InfoElements below the VisibilityElement will be shown. Otherwise they will be hidden. VisibilityElements are often nested to further filter the visibility of elements top down.

- **CompareOperator**:
- - 0 (or not defined) Equals
- - 1 Unequals
- - 2 smaller than
- - 3 smaller than or equal
- - 4 bigger than or equal
- - 5 bigger than


- **ResultType**:
- - 0 (or not defined) boolean (if ExpectedValueBool is not defined, it is "True")
- - 1 integer (if ExpectedValueInt is not defined, it is 0)
- - 2 float (if ExpectedValueFloat is not defined, it is 0)
- - Unfortunately it seems eg. ExpectedValueInt can really only deal with Int, **not** with constructs like this, which evaluate to an int: ```[ItemAssetData([RefGuid]) InputAmountUpgradeProduct(#index0#)]```


- **OperatorType** (is used after VisibilityElement to define the logic for the conditions contained in them):
- - 0 all VisibilityElement listed on the same level are chained with "and" (so all of them must be true at the same time)
- - 1 all VisibilityElement listed on the same level are chained with "or" (so one of the conditions must be true)

- **Condition**:
- - [RefGuid] Most basic condition which checks for the Guid of a selected asset or an asset where the mouse hovers over at the moment. 
- - [Selection ... ] These conditions only work for selected assets, mouse-over is not recognized. This way, infotips change their information depending on which building was selected last (unwanted behaviour). "Selection Picked" seems to catch the object your are currently hovering (or last hovered over), while "Selection Object" is the one currently selected.
- - [StaticData ... ] These conditions work for mouse-over too, e.g. when hovering over construction menu icons. However, valid arguments are very limited. 

- **ElementType** (they define the kind of tooltip/box/structure):
- - 0  ?
- - 1 seems to be some kind of header
- - 2  ?
- - 3  ?
- - 4 seems to be used for attributes, eg: "Speed:    +10%"
- - 5 used for dark-grey "background" text.
- - 6  ?
- - 7  ?
- - 8  ?
- - 9  ?
- - 10  ?
- - 11  ?
- - 12  ?
- - 13  ?
- - 14  ?
- - 15  ?
- - 16  ?
- - 17  ?
- - 18 used for text in italics like fluff-texts of buffs / items
- - 19 seems to be used for listing attributes, eg. all effects from a buff.

### Code Snippets
To add a separator line (but they are as buggy as the vanilla lines below headers. Sometimes they are visible, sometimes not..)
```xml
<InfoElement>
  <ElementType>6</ElementType>
  <VisibilityElement>
    <ElementType>
      <ElementType>2</ElementType>
    </ElementType>
    <OperatorType />
  </VisibilityElement>
  <Text>
    <Style />
  </Text>
</InfoElement>
```
