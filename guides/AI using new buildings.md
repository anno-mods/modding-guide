# How AI can use new buildings/productionchains

## General
- Most of the AIs logic is hardcoded outside of xml, but already makes them use new products/buildings automatically, if they need it for their population.  
- In the `Building` Property of each Building you can define `SecondPartyRelevant` 1 or 0. This is an easy switch to allow the AI to build you building or not. (Beware to not add a new need mandatory for AI, which they can not fullfill because you set SecondPartyRelevant to 0).  
- The buildings also must be added to the `ConstructiomMenu`, otherwise the AI wont build them.

---

## Needs
- `PopulationInputs` (Needs) from residences: **`IsConsideredByAI`**. 
- - If this is set to 1, the AI will try to fullfill this need before advancing to the next resident tier. If it is unable to, it will never advance. 
- - Set to 0 makes the AI not build anything in regards to this need, since they consider it as "not needed". (I think they will also advance without fullfilling it, even if humans mandatory need it to advance?)


### Productions Buildings
- `ConstructionAI/TradeRules/OverProduction`.
- `ConstructionAI/EconomyRules/ConstructionMaterials` to produce goods that are not needed for needs, but for building. Many of these in defined in templates and Profile_2ndParty-asset. Quite complicated structured.

#### Limitations
They only build the most efficient buildings to produce a good: if there are multiple and the efficient one is unlocked later, they may get stuck.  
The vanilla example of "coal" being produced in two buildings is in fact a very special case and seems to be hardcoded as an exception to this stupid rule. Stupid because they seem unable to check for "most efficient **unlocked** building", eg in my test to add an early less efficient clay mine, the AI refused to build it and simply never advanced, BUT when I changed to GUIDs to the ones from the coal productions (nothing more, just GUID), it suddenly worked ..  
So best solution I can think of is making the regular clay mine unlocked earlier for AI only, while humans get a less efficient early clay mine in this example.  

### PublicService
- ...

---

## Shipyards
`ConstructionAI/CrafterConfiguration` (vanilla examples are in templates.xml).  
In addition to the entries there you must make sure:  
- The shipyard needs a ship in `AssemblyOptions` that is not buildable in another shipyard.
- This new ship must be part of the WarFleet of the AI if it is a warship (and tradeships in TradeShipRatio I guess?)
- Shipyard must have `<TerrainType>Water_Including_Coast</TerrainType>`? (Airship shipyards are in vanilla monuments, see MonumentConfiguration, not sure if this is mandatory)

## Defense Buildings
- `ConstructionAI/DefenseStructuresGround` and `DefenseStructuresAir`

---

## Ornaments
- `RevelantForAI` in `ConstructionCategory` (only relevant for ornaments?)
- `ConstructionAI/LookAndFeel`

## Monuments
- `ConstructionAI/MonumentConfiguration` , but the `BlockScore`'s require an datasets.xml Enum, so you can not really add your own logic for the placement I think? Not sure if using a vanilla one is suficient or what you can do in GlobalConstructionAIBalancing.

---

## Replace buildings
- In `ConstructionAI/BuildingReplacements` you can define special GUIDs for AI, eg. Mercier using a special theatre instead of the normal one.
- Global replacement of building if DLC is active `DlcController/ReplaceBuildingsWhenDLCisActive` (can also set IgnoreSecondParty if you dont want it for AI.)
Both of them only work on new games or games where you just enabled the DLC on.

## Building Placement
- `GlobalConstructionAIBalancing` ? Don't know how this works, will most likely effect every AI the same.

## Unlock buildings for AI only
- `ConstructionAI/UnlockReferenceAssets`: here you can define sth like "if you unlocked X, also unlock Y"
- A workaround Taube mentioned: The AI only checks if a building is in the Construction Menu and if it is unlocked, then the AI can build it. If you put your building into a "ProductionChain" and this chain into the menu, you can unlock the building, which will allow AI to build it. But players won't be able to build it since they also need the ProductionChain unlocked.
- With help of Serps mod [shared_IsAIPlayer_Condition](https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/tree/main/shared_IsAIPlayer_Condition)
