# Modding Infotips (tooltips)

You can mod the infotips this way:
https://github.com/jakobharder/anno1800-mod-loader/blob/main/doc/modloader11.md#patching-infotip-exportbin
You can extract the vanilla "data\infotips\export.bin" file with the FileDBReader (https://github.com/anno-mods/FileDBReader/releases) and the FileFormat "infotip.xml".
Alternatively I attached the extracted file in the modding discord channel here: https://discord.com/channels/578443209940926465/1146098268850376816/1149910673678159964  

For valid text-embed commands (I mean these [Selection Object ...] things you find in the file and texts), see the textsourcelist.json file from the game (unfortunately a bit outdated though..) or this huge list of textsource commands [lua ENUMs](https://github.com/anno-mods/modding-guide/blob/main/Scripting/ENUMs.md) while you can not directly use the wording from the link since it is lua form, see also  [textembeds](https://github.com/anno-mods/modding-guide/blob/main/Scripting/textembeds.md) )  
 

## Compatibility with other mods (please read if you mod infotips!)  
Because of the structure of infotips code the ModOp Path we use to change something at a specific location needs to contain huge parts of the content of the InfoElement we want to mod. If another mod now changes the content (eg. Condition or Text) from an InfoElement, our ModOp may fail. It is still better to **not** use Conditions/AllowNoMatch to prevent the error in the logfile, because we want to get notified of incompatibilities this way in the logfile!  
Using "add/AddNextSibling/AddPrevSibling" is usually not a compatibility problem, since the Path to vanilla code is not changed this way. But when you use merge/replace/remove for vanilla code, it is extremly likely to cause incompatibility with mods changing the same infotip (even if the change is for a different part of the infotip).  
Most of the time infotip adjustments are made to support new mod-objects to be displayed in infotips. It is recommended to find a general solution for this, instead of hardcoding your own GUIDs into the infotips. For such general adjustments you should create a shared mod, so also other modders can use it. And to keep an overview about all existing general infotip adjustments, please also add your shared mod to the Community Patch mod: https://github.com/anno-mods/BugFixes/tree/main .   
If your change is very specific to your mod and no other mod could need such a change or a general solution is not possible, then still do your infotip change in a seperate folder with its on modinfo.json. This way other modders can more easily disable your change later in case they do find a general solution for the problem.  
Example for general solution: https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/blob/main/shared_TT_ModPalaceMinistryHacienda/data/infotips/export.bin.xml  


### Enums
Infotips are called **InfoTipData** in the code and are adressed as usual by Guids. Infotips use a lot of numbers to express operations. By default all non-defined integer values are 0. 
We have to test and find out the meaning ourself. Here what we already found out (no guarantee that it is correct):

- **InfoElement**
  - Each InfoTip is made of any number of InfoElements. Their order in the code corresponds to the display in the game: The first InfoElement (if visible, see below) represents the top of the Infotip and vice versa.

- **VisibilityElement**:
  - They usually contain conditions. And if the conditions are true, the content and InfoElements below the VisibilityElement will be shown. Otherwise they will be hidden. VisibilityElements are often nested to further filter the visibility of elements top down.

- **CompareOperator**:
  - 0 (or not defined) Equals
  - 1 Unequals
  - 2 smaller than
  - 3 smaller than or equal
  - 4 bigger than or equal
  - 5 bigger than


- **ResultType**:
  - 0 (or not defined) boolean (if ExpectedValueBool is not defined, it is "True")
  - 1 integer (if ExpectedValueInt is not defined, it is 0)
  - 2 float (if ExpectedValueFloat is not defined, it is 0). Use numbers seperated by "dot" here, like "1.2", not "1,2".
  - Unfortunately it seems eg. ExpectedValueInt can really only deal with Int, **not** with constructs like this, which evaluate to an int: ```[ItemAssetData([RefGuid]) InputAmountUpgradeProduct(#index0#)]```


- **OperatorType** (is used after VisibilityElement to define the logic for the conditions contained in them):
  - 0 all VisibilityElement listed on the same level are chained with "and" (so all of them must be true at the same time)
  - 1 all VisibilityElement listed on the same level are chained with "or" (so one of the conditions must be true)

- **Condition**:
  - [RefGuid] Most basic condition which checks for the Guid of a selected asset or an asset where the mouse hovers over at the moment. 
  - [Selection ... ] These conditions only work for selected assets, mouse-over is not recognized. This way, infotips change their information depending on which building was selected last (unwanted behaviour). "Selection Picked" seems to catch the object your are currently hovering (or last hovered over), while "Selection Object" is the one currently selected.
  - [StaticData ... ] These conditions work for mouse-over too, e.g. when hovering over construction menu icons. However, valid arguments are very limited. 

- **ElementType** (they define the kind of tooltip/box/structure):
  - 1  header: `Text` is bold and uses bright color, uses wordwraps; `Icon` is centered along the y axis
  - 2  header: `Text` is bold and uses bright color,  uses wordwraps; `Icon` is centered along the y axis; in addition to `1` there´s some empty space added below the text
  - 3  plain text: `Text` + (if needed) `Value` both in bright color; uses wordwraps; does not display icons
  - 4  attributes (from buffs etc): `Icon`, `Text` and `Value`; both in bright color; writes text in one line only, no matter how long it is. --> most universal type to use
  - 5  plain text: `Text` in dark-grey "background" text (can´t display `Icon` and `Value`)
  - 6  plain text (if specified) + a separator line below
  - 7  ... seems to be used as a container for (multiple) sub-VisibilityElements and InfoElements (does not show anything on it self). Has `<Source>` on same level
  - 8  ... seems to be used as a container for (multiple) sub-VisibilityElements and InfoElements (does not show anything on it self). Has `<Source>` only on sub-levels
  - 9  InfoLayer-hints: `Text` is bold and written in one line only (no wordwraps); used for UI-buttons e.g. in the construction menu and within buildings. Can't display icons.
  - 10  used as a container for (multiple) sub-VisibilityElements and InfoElements with `<ElementType>11</>` only (does not show anything on it self). Has `<Source>` and `<Column>` on same level. 
  - 11  ... seems to have sth to do with asset costs (materials, permits, godlikes, blueprints, upgradability)
  - 12  ... seems to be used as a container for (multiple) sub-VisibilityElements and InfoElements (does not show anything on it self)
  - 13  ... seems to be used as a container for (multiple) sub-VisibilityElements and InfoElements (does not show anything on it self)
  - 14  plain text: `Text` in medium-grey color (can´t display `Icon` and `Value`); used for action-descriptions (e.g. click on ... to jump to ...); does not adapt infotip size to text length!
  - 15  does nothing?
  - 16  used for main category infotips, e.g. MonumentEventCategories. Needs at least `<Headline>` to show text.
  - 17  plain text: `Text` in dark-grey "background" text (can´t display `Icon` and `Value`); does not adapt infotip size to text length!
  - 18  used for text in italics like fluff-texts of buffs / items
  - 19  seems to be used for listing attributes, eg. all effects from a buff (needs `TemplateGUID` to display sth)

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
