# Documentation

When modding having an overview or snippets of common used tags and code can save a lot of time. On this page we will combine those for easy acces and documentation.

## Overview data.rda files

- data0: General game files
- data1: Shaders used in the basegame
- data2: Icons and images used in the basegame
- data3: Video used in the basegame
- data4: Blacklisted words in every language and fonts for the game
- data5: Maps used in the basegame
- data6: Islands used in the basegame
- data7: Benchmarks
- data8: Buildings used in the basegame
- data9: Sounds used in the basegame
- data10: The Anarchist DLC
- data11: Sunken Treasures DLC
- data12: Botanica DLC
- data13: The Passage DLC
- data14: Seat Of Power DLC
- data15: Bright Harvest DLC
- data16: Land Of Lions DLC
- data17: Docklands DLC
- data18: Tourist Season DLC
- data19: The High Life DLC
- data20: Pedestrian Zone Pack
- data21: Eden Burning Scenario
- data22: Seeds of Change DLC

## Supported languages

- texts_chinese.xml
- texts_english.xml
- texts_french.xml
- texts_german.xml
- texts_italian.xml
- texts_japanese.xml
- texts_korean.xml
- texts_polish.xml
- texts_russian.xml
- texts_spanish.xml
- texts_taiwanese.xml

## Type="" actions

```XML
<ModOp Type="add">
```

```XML
<ModOp Type="replace">
```

```XML
<ModOp Type="merge">
```

```XML
<ModOp Type="remove">
```

```XML
<ModOp Type="addNextSibling">
```

```XML
<ModOp Type="addPrevSibling">
```

## Building templates

...

## Item templates

- GuildhouseItem
- GuildhouseBuff
- TownhallItem
- TownhallBuff
- HarborOfficeItem
- HarbourOfficeBuff
- VehicleItem
- VehicleBuff
- ShipSpecialist
- CultureItem
- CultureBuff
- CultureSet
- FestivalBuff
- ...

```XML
<Template>GuildhouseItem</Template>
```

## Item main proporties

### MaxStackSize

Defines how many items you could stack together in 1 slot on a ship. Standard is 1. If you want you could change that.

```XML
<MaxStackSize>1</MaxStackSize>
```

### Rarity

- Common
- Uncommon
- Rare
- Epic
- Legendary

```XML
<Rarity>Legendary</Rarity>
```

### ItemType

- Specialist
- Normal

```XML
<ItemType>Specialist</ItemType>
```

### Allocation

- Museum
- Zoo
- BotanicGarden
- Warship
- SailShip
- SteamShip
- Ship
- DivingVessel
- GuildHouse
- TownHall
- HarborOffice
- Lodge

```XML
<Allocation>TownHall</Allocation>
```

### TradePrice & TradePriceOnlineCurrency

```XML
<TradePrice>356000</TradePrice>
<TradePriceOnlineCurrency>50</TradePriceOnlineCurrency>
```

### ExclusiveGroup

- Canons
- Telescopes
- AutoAttackProjectile
- Flag
- TradingTaxBill
- FactoryAct
- CleanAirAct
- AdministrationAct
- EntertainmentAct
- ResearchAct
- EducationAct
- Ordinance
- EconomyAct
- PublicHealthAct
- FirePreventionAct
- PublicGatheringAct
- ChildRightsAct
- HumanRightsAct
- AlcoholAct
- AlcoholTaxesAct
- SecularizationAct
- TaxesManagementAct
- WorkingConditionsAct
- AmnestyEdict
- TourismAdCampaign
- NatalityRegulationEdict
- WomenRightsAct
- Propaganda
- Newspaper
- EconomicDoctrine
- AnarchyEssay
- DivingBell
- Sonar
- Cables
- GGJSoilSampler
- GGJUrbanPlants
- GGJWasteManagement
- GGJIndustrialAirFilters
- GGJDistillery
- GGJLocalGarden
- GGJFertilizer
- GGJEnactments
- GGJCoralPlants
- GGJPondPlants

```XML
<ExclusiveGroup>Canons</ExclusiveGroup>
```

### ItemFilterCategory

Used in Eden Burning scenario.

- 24592 - Soil
- 24593 - Water
- 24594 - Air
- 24602 - Miscellaneous

```XML
<ItemFilterCategory>24594</ItemFilterCategory>
```

### ScenarioFilter

Used in Eden Burning scenario.

650 is only value.

```XML
<ScenarioFilter>650</ScenarioFilter>
```

## Item proporties

### IndustrializableUpgrade

```XML
<IndustrializableUpgrade>
  <ProvideIndustrialization>1</ProvideIndustrialization>
</IndustrializableUpgrade>
```

### FactoryUpgrade

```XML
<FactoryUpgrade>
    <ProductivityUpgrade>
        <Value>50</Value>
        <Percental>1</Percental>
    </ProductivityUpgrade>
    <AdditionalOutput>
        <Item>
            <Product>1010246</Product> <!-- Poket Watches -->
            <AdditionalOutputCycle>3</AdditionalOutputCycle>
            <Amount>1</Amount>
        </Item>
    </AdditionalOutput>
    <ReplaceInputs>
        <Item>
            <OldInput>1010204</OldInput> <!-- Brass -->
            <NewInput>120008</NewInput> <!-- Wood -->
        </Item>
    </ReplaceInputs>
</FactoryUpgrade>
```

### ItemEffect

```XML
<ItemEffect>
    <EffectTargets>
        <Item>
            <GUID>1010315</GUID> <!-- Framework Knitters -->
        </Item>
        <Item>
            <GUID>1010325</GUID> <!-- Fur Dealer -->
        </Item>
        <Item>
            <GUID>118734</GUID> <!-- Tailor's Shop -->
        </Item>
    </EffectTargets>
</ItemEffect>
```

### BuildingUpgrade

```XML
<BuildingUpgrade>
    <MaintenanceUpgrade>
        <Value>-20</Value>
        <Percental>1</Percental>
    </MaintenanceUpgrade>
    <WorkforceAmountUpgrade>
       <Value>20</Value>
       <Percental>1</Percental>
    </WorkforceAmountUpgrade>
</BuildingUpgrade>
```

### ResidenceUpgrade

```XML
<ResidenceUpgrade>
    <AdditionalHappiness>30</AdditionalHappiness>
    <GoodConsumptionUpgrade>
        <Item>
            <ProvidedNeed>114404</ProvidedNeed> <!-- Tapestries -->
            <AmountInPercent>-100</AmountInPercent>
        </Item>
        <Item>
            <ProvidedNeed>117698</ProvidedNeed> <!-- Illuminated Script -->
            <AmountInPercent>-80</AmountInPercent>
        </Item>
        <Item>
            <ProvidedNeed>117699</ProvidedNeed> <!-- Lanterns -->
            <AmountInPercent>-50</AmountInPercent>
        </Item>
    </GoodConsumptionUpgrade>
    <TaxModifierInPercent>-25</TaxModifierInPercent>
    <WorkforceModifierInPercent>30</WorkforceModifierInPercent>
</ResidenceUpgrade>
```

```XML
<ResidenceUpgrade>
    <NeedProvideNeedUpgrade>
        <Item>
            <ProvidedNeed>1010213</ProvidedNeed> <!-- Bread -->
            <SubstituteNeed>1010349</SubstituteNeed> <!-- Pub -->
        </Item>
        <Item>
            <ProvidedNeed>1010238</ProvidedNeed> <!-- Sausages -->
            <SubstituteNeed>1010349</SubstituteNeed> <!-- Pub -->
        </Item>
        <Item>
            <ProvidedNeed>1010200</ProvidedNeed> <!-- Fish -->
            <SubstituteNeed>1010349</SubstituteNeed> <!-- Pub -->
        </Item>
    </NeedProvideNeedUpgrade>
</ResidenceUpgrade>
```

### CultureUpgrade

```XML
<CultureUpgrade>
    <AttractivenessUpgrade>
        <Value>40</Value>
    </AttractivenessUpgrade>
</CultureUpgrade>
```

```XML
<CultureUpgrade>
    <AttractivenessUpgrade>
        <Value>-20</Value>
        <Percental>1</Percental>
    </AttractivenessUpgrade>
</CultureUpgrade>
```

### ExpeditionAttribute

#### Trait/Perk

- PerkMale (Male)
- PerkFemale (Female)
- PerkHypnotist (Hypnotist)
- PerkAnthropologist (Anthropologist)
- PerkMilitaryShip (Military ship)
- PerkSailingShip (Sailing ship)
- PerkSteamShip (Steam ship)
- PerkTradeShip (Trade ship)
- PerkFormerPirate (Pirate)
- PerkDiver (Diver)
- PerkJackOfAllTraits (Jack Of All Traits)
- PerkEntertainer (Entertainer)
- PerkPolyglot (Polyglot)
- PerkZoologist (Zoologist)
- PerkArcheologist (Archeologist)

#### Skills

- Crafting
- Diplomacy
- Melee (Force)
- Might (Naval Power)
- Navigation
- Medicine
- Faith
- Hunting

#### ItemDifficulties

- Easy
- Average
- Hard

```XML
<ExpeditionAttribute>
    <BaseMorale>20</BaseMorale>
    <ExpeditionAttributes>
        <Item>
            <Attribute>PerkMale</Attribute>
            <Amount>1</Amount>
        </Item>
        <Item>
            <Attribute>Crafting</Attribute>
            <Amount>50</Amount>
        </Item>
        <Item>
            <Attribute>Melee</Attribute>
            <Amount>15</Amount>
        </Item>
        <Item>
            <Attribute>PerkMilitaryShip</Attribute>
            <Amount>1</Amount>
        </Item>
        <Item />
    </ExpeditionAttributes>
    <ItemDifficulties>Average;Hard</ItemDifficulties>
</ExpeditionAttribute>
```

### Locked

- 410003 (Imperial Pack)
- 410021 (Season Pass Player Assets)
- 410069 (Season 2 Pass Reward)
- 305 (Season 3 Pass Reward)
- 25945 (Season 4 Bonus Content)
- 410079 (Amusements Pack)
- 116630 (Holiday Ornament Pack)
- 4100010 (The Anarchist)
- 410040 (Sunken Treasures)
- 410041 (Botanica)
- 410042 (The Passage)
- 410059 (Seat Of Power)
- 410070 (Bright Harvest)
- 410071 (Land of Lions)
- 410083 (Docklands)
- 410084 (Tourist Season)
- 410085 (The High Life)
- 24961 (Seeds Of Change)

```XML
<Locked>
    <DefaultLockedState>1</DefaultLockedState>
    <DLCDependency>410041</DLCDependency>
</Locked>
```

### ModuleOwnerUpgrade

```XML
<ModuleOwnerUpgrade>
    <ModuleLimitPercent>-10</ModuleLimitPercent>
</ModuleOwnerUpgrade>
```

### IncidentInfectableUpgrade

```XML
<IncidentInfectableUpgrade>
    <IncidentFireIncreaseUpgrade>
        <Value>-1</Value>
    </IncidentFireIncreaseUpgrade>
    <IncidentIllnessIncreaseUpgrade>
        <Value>-1</Value>
    </IncidentIllnessIncreaseUpgrade>
    <IncidentRiotIncreaseUpgrade>
        <Value>-1</Value>
    </IncidentRiotIncreaseUpgrade>
    <IncidentExplosionIncreaseUpgrade>
        <Value>-1</Value>
    </IncidentExplosionIncreaseUpgrade>
</IncidentInfectableUpgrade>
```

### PopulationUpgrade

```XML
<PopulationUpgrade>
    <StressUpgrade>
        <Value>-35</Value>
        <Percental>1</Percental>
    </StressUpgrade>
    <ResidentsUpgrade>
        <Value>20</Value>
        <Percental>1</Percental>
    </ResidentsUpgrade>
    <InputBenefitModifier>
        <Item>
            <Product>114361</Product> <!-- Musicians' Court -->
            <AdditionalSupply>5</AdditionalSupply>
            <AdditionalMoney>10</AdditionalMoney>
        </Item>
        <Item>
            <Product>114414</Product> <!-- Clay Pipes -->
            <AdditionalSupply>5</AdditionalSupply>
            <AdditionalMoney>10</AdditionalMoney>
        </Item>
        <Item>
            <Product>1010353</Product> <!--University -->
            <AdditionalResearch>1</AdditionalResearch>
            <AdditionalHappiness>10</AdditionalHappiness>
        </Item>
    </InputBenefitModifier>
</PopulationUpgrade>
```

### KontorUpgrade

```XML
<KontorUpgrade>
    <HappinessIgnoresMorale>1</HappinessIgnoresMorale>
    <BlockHostileTakeover>1</BlockHostileTakeover>
    <BlockBuyShare>1</BlockBuyShare>
</KontorUpgrade>
```

### PassiveTradeGoodGenUpgrade

```XML
<PassiveTradeGoodGenUpgrade>
    <GenProbability>25</GenProbability>
    <GenPool>191637</GenPool> <!-- Protectionism Defender Pool 2 -->
</PassiveTradeGoodGenUpgrade>
```

### HeaterUpgrade

```XML
<HeaterUpgrade>
    <HeatRangeUpgrade>
        <Value>20</Value>
        <Percental>1</Percental>
    </HeatRangeUpgrade>
</HeaterUpgrade>
```

### PowerplantUpgrade

```XML
<PowerplantUpgrade>
    <IndustrializationRangeUpgrade>
        <Value>10</Value>
    </IndustrializationRangeUpgrade>
</PowerplantUpgrade>
```

### IrrigationUpgrade

```XML
<IrrigationUpgrade>
    <PipeCapacityUpgrade>
        <Value>20</Value>
    </PipeCapacityUpgrade>
</IrrigationUpgrade>
```

## Overview RewardPool

- ...

## Overview AssetPool

- 102418 - CQIPool_Pyrphorian_WarItems01
- 100653 - asset pool imperial kontors
- 130066 - asset pool zoo modules
- 130067 - asset pool museum modules
- 130068 - asset pool harbor defenses
- 130111 - asset pool splendour elements (1st set)
- 130113 - asset pool park elements (all)
- 130115 - asset pool splendour elements (all)
- 130133 - asset pool monuments
- 130057 - asset pool market
- 130040 - asset pool warehouse
- 140029 - asset pool timber
- 130056 - asset pool fish
- 140028 - asset pool schnapps
- 130060 - asset pool basic clothes
- 130042 - asset pool pub
- 140031 - asset pool brick
- 130053 - asset pool warehouse &amp; kontor II
- 140027 - asset pool sausage
- 140033 - asset pool bread
- 130043 - asset pool church
- 130050 - asset pool sail shipyard
- 140050 - asset pool sailcloth
- 140034 - asset pool beam
- 140051 - asset pool weapon
- 140030 - asset pool soap
- 140035 - asset pool beer
- 130044 - asset pool school
- 140037 - asset pool glass pane
- 130054 - asset pool warehouse &amp; kontor III
- 130052 - asset pool tourism pier
- 140036 - asset pool canned food
- 140032 - asset pool sewing machines
- 130045 - asset pool cabaret
- 140046 - asset pool fur coat
- 130046 - asset pool university
- 140043 - asset pool concrete
- 130047 - asset pool electricity oil
- 130041 - asset pool glasses
- 140044 - asset pool light bulb
- 140052 - asset pool steam motor
- ...

## Creating new building

### Building

This part contains a couple of different parts.

#### BuildModeRandomRotation

```XML
<BuildModeRandomRotation>90</BuildModeRandomRotation>
```

Define how many degrees you can rotate the building when placing the building.

- 90
- 180

##### BuildingType

```XML
<BuildingType>Residence</BuildingType>
```

The type of building can be:

- Residence
- Logistic (Warehouse)
- Warehouse (Trading Post)
- BuildingModule (Silo, Tractor)
- Factory (Hacienda alternative production factories)
- Other (Campaign and scenario specific buildings)

#### AssociatedRegions

```XML
<AssociatedRegions>Moderate</AssociatedRegions>
```

Defines in which region we can build this building.

Regions:

- Moderate
- Colony01
- Arctic
- Africa

##### BuildingCategoryName

```XML
<BuildingCategoryName>100000</BuildingCategoryName>
```

The category of the building can be:

- 100000 (Production)
- 11175 (Livestock Area)
- 100003 (Public Service)
- 2498 (Exhibition Space)
- 11169 (Electricity)
- 11149 (Ornament)
- 11150 (Harbour)
- 11151 (Infrastructure)
- 11152 (Administration) - Example: Guild House/Town Hall
- 11154 (Railway)
- 269841 (Tractor)
- 19227 (Wooden Ruins)
- 19233 (Stone Ruins)
- 19158 (Sells tickets for long voyages)
- 116953 (Abandoned Tents)
- 269960 (Agricultural Improvement)
- 134142 (Food & Drink Venue)
- 132773 (Multifactory)
- 134987 (Tourist Lodgings)
- 0 (ScenarioRuinEco)

##### TerrainType

```XML
<TerrainType>Water_Including_Coast</TerrainType>
```

Defines **special terraintypes** where the building can be placed. This can be:

- Water_Including_Coast
- Water_Excluding_Coast
- Coast
- Terrain (used in special cases)

##### SecondPartyRelevant

```XML
<SecondPartyRelevant>0</SecondPartyRelevant>
```

Disable a building for AI. This building will not be available for them.

##### Movable

```XML
<Movable>0</Movable>
```

Make it impossible to move the building/asset. Set to 0.

##### AllowChangeDirection

```XML
<AllowChangeDirection>0</AllowChangeDirection>
```

Disable changing direction. Set to 0.

##### AlternativeGrassColorAvailable

```XML
<AlternativeGrassColorAvailable>1</AlternativeGrassColorAvailable>
```

Make alternative grass available for the building. Set to 1.

### Blocking

This is used for example for coastal buildings. To block tiles that are reachable by quay/street.

```XML
<Blocking>
    <GroundDecalAsset>100446</GroundDecalAsset> <!-- Quay street -->
    <GroundDecalInvisible>101008</GroundDecalInvisible> <!-- Quay street -->
    <GroundDecalAssetExtra>100691</GroundDecalAssetExtra> <!-- Quay street -->
    <HasBuildingBaseTiles>1</HasBuildingBaseTiles>
</Blocking>
```

### Cost

Every building has a building cost. Depending on what you need you can add the different building materials.

```XML
<Cost>
    <Costs>
        <Item>
            <Ingredient>1010017</Ingredient> <!-- Coins -->
            <Amount>4000</Amount>
        </Item>
        <Item>
            <Ingredient>1010196</Ingredient> <!-- Timber -->
            <Amount>40</Amount>
        </Item>
        <Item>
            <Ingredient>1010205</Ingredient> <!-- Bricks -->
            <Amount>35</Amount>
        </Item>
        <Item>
            <Ingredient>1010218</Ingredient> <!-- Steal Beams -->
            <Amount>25</Amount>
        </Item>
        <Item>
            <Ingredient>1010207</Ingredient> <!-- Windows -->
            <Amount>15</Amount>
        </Item>
        <Item>
            <Ingredient>1010202</Ingredient> <!-- Reinforced concrete -->
            <Amount>5</Amount>
        </Item>
    </Costs>
</Cost>
```

### Object

Within the object we can define the model of the building we are creating.

We can add multiple variations for the building.

```XML
<Object>
    <Variations>
        <Item>
            <Filename>data/dlc05/graphics/buildings/ornamental/industrial/industrial_props_system_wall02_1x1_straight_01.cfg</Filename>
        </Item>
        <Item>
            <Filename>data/dlc05/graphics/buildings/ornamental/industrial/industrial_props_system_wall02_1x1_end_01.cfg</Filename>
        </Item>
        <Item>
            <Filename>data/dlc05/graphics/buildings/ornamental/industrial/industrial_props_system_wall02_1x1_corner_01.cfg</Filename>
        </Item>
        <Item>
            <Filename>data/dlc05/graphics/buildings/ornamental/industrial/industrial_props_system_wall02_1x1_cross_01.cfg</Filename>
        </Item>
        <Item>
            <Filename>data/dlc05/graphics/buildings/ornamental/industrial/industrial_props_system_wall02_1x1_tee_01.cfg</Filename>
        </Item>
    </Variations>
</Object>
```

#### Selection

##### ParticipantMessageArcheType

Complete list:
- Advisor_01_Hannah
- Advisor_01_Hannah_BlackDress
- Advisor_02_Aahrant
- Campaign_character_01_demolition_expert
- Campaign_character_02_pyrophorian_red
- Campaign_character_02_pyrophorian_red_blinded
- Campaign_character_03_pyrophorian_silver
- Campaign_character_04_pyrophorian_gold
- Campaign_character_04b_pyrophorian_gold_nonattackable
- Campaign_character_07_magistrate
- Campaign_character_08_cousin_female
- Campaign_character_09_cousin_male
- Campaign_character_10_SA_ticketseller
- Second_ai_11_Mercier
- Second_ai_01_Jorgensen
- Second_ai_02_Qing
- Second_ai_03_Wibblesock
- Second_ai_04_Smith
- Second_ai_05_OMara
- Second_ai_06_Gasparov
- Second_ai_07_von_Malching
- Second_ai_08_Gravez
- Second_ai_09_Silva
- Second_ai_10_Hunt
- Third_party_09_Vasco_Silva
- Third_enemy_01_Grant
- Third_party_01_Queen
- Third_party_02_Blake
- Third_party_02b_Blake_AttacksPirate
- Third_party_03_Pirate_Harlow
- Third_party_04_Pirate_LaFortune
- Third_party_05_Sarmento
- Third_party_05b_Sarmento_Prosperity_Campaign
- Third_party_05c_Sarmento_Attackable_Campaign
- Third_party_06_Nate
- Third_party_07_Jailor_Bleakworth
- Third_party_08_Kahina
- Resident_tier01
- Resident_tier02
- Resident_tier03
- Resident_tier04
- Resident_tier05
- Captain
- Visitor
- Editor
- SA_Resident_tier01
- SA_Resident_tier02
- SA_Resident_tier01_atWork
- SA_Resident_tier02_atWork
- Resident_tier01_atWork
- Resident_tier02_atWork
- Resident_tier03_atWork
- Resident_tier04_atWork
- Resident_tier05_atWork
- Workforce_Commuter_Captain
- Paloma
- Human0
- Human1
- Human2
- Human3
- General_Enemy
- Scenario_Item_Trader
- Third_enemy_01_Grant
- Arctic_Inuit
- Arctic_SirJohn
- Arctic_LadyFaithful
- Third_party_06b_Nate_Arctic
- Arctic_Resident_tier01
- Arctic_Resident_tier01_atWork
- Arctic_Resident_tier02
- Arctic_Resident_tier02_atWork
- Africa_Resident_tier01
- Africa_Resident_tier02
- Africa_Resident_tier03
- Africa_Kidusi
- Africa_Angereb
- Africa_Waha
- Africa_Ketema
- Africa_Blake
- Africa_Hippopotamus
- Africa_Biniam
- Africa_Kyria
- Africa_KetemaFake
- Africa_Blake
- Africa_Nomads
- Africa_Building
- Void_Trader
- Resident_Tourist
- HighLife_Donald
- HighLife_JennyEng
- HighLife_JennyWorker
- HighLife_William
- Scenario02_Actuary
- Scenario02_Vasco
- Scenario02_Questgiver
- Scenario3_Challenger1
- Scenario3_Challenger2
- Scenario3_Challenger3
- Scenario3_Challenger4
- Scenario3_Challenger5
- Scenario3_Challenger6
- Scenario3_Challenger7
- Scenario3_Challenger8
- Scenario3_Challenger9
- Scenario3_Challenger10
- Scenario3_Challenger11
- Scenario3_Challenger12
- Scenario3_Queen
- Scenario3_Ketema
- Scenario3_Archie
- Scenario3_Eli
- Scenario3_Nate
- Scenario3_Paloma
- Scenario3_Mercier
- Scenario3_Mara
- Scenario3_Fortune
- Scenario3_Bente
- Scenario3_Editor
- Scenario4_Trader_Hunt
- Scenario4_Trader_Yaosca
- Scenario4_Trader_Malching
- Scenario4_Trader_DaSilva
- Scenario4_Trader_Paloma
- Scenario4_Kahina
- GGJ_Yaosca
- GGJ_OldNate
- GGJ_Pyrphorian
- GGJ_Fisherman
- GGJ_Maya
- GGJ_Isabel
- Mercier_DeserterWorker

```XML
<Selection>
    <ParticipantMessageArcheType>Resident_tier02_atWork</ParticipantMessageArcheType>
</Selection>
```

#### SoundEmitter

This will define which sounds will be played when clicking the building or zoom in to the building.

```XML
<SoundEmitter>
    <ActiveSounds>
        <Item>
            <Sound>270300</Sound> <!-- Tea Spicer sounds -->
        </Item>
        <Item>
            <Sound>270266</Sound> <!-- Tea Spicer sounds -->
        </Item>
    </ActiveSounds>
</SoundEmitter>
```

#### Maintenance

Every building has an upkeep in most cases coins and workforce.

##### Workforce

- 1010052 - Farmer Workforce
- 1010115 - Worker Workforce
- 1010116 - Artisan Workforce
- 1010117 - Engineer Workforce
- 1010128 - Investor Workforce
- 1010366 - Jornalero Workforce
- 1010367 - Obrero Workforce
- 112653 - Explorer Workforce
- 112654 - Technician Workforce
- 114340 - Shepherd Workforce
- 114341 - Elder Workforce
- 124478 - Scholar Workforce

```XML
<Maintenance>
    <Maintenances>
        <Item>
            <Product>1010017</Product> <!-- Amount of coins upkeep -->
            <Amount>150</Amount>
            <InactiveAmount>50</InactiveAmount>
        </Item>
        <Item>
            <Product>1010115</Product> <!-- Amount of Workforce - Workers -->
            <Amount>40</Amount>
        </Item>
    </Maintenances>
</Maintenance>
```

#### Industrializable

We can electrify a building to get a productionboost of 100%. We set the value to 1.

```XML
<Industrializable>
    <BoostedByIndustrialization>1</BoostedByIndustrialization>
</Industrializable>
```
