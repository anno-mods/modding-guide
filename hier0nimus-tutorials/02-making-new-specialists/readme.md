# Tutorial 2 - Making new specialists

## The better way

With Feras, we have changed an existing item, but that is not the best practice. Changing existing items increases potential problems. With every official update Ubisoft rolls out they can potentially change logic and items in the game. When we modify items they also use, this can increase the amount of conflicts. A better way is to create our own items.

## Our imagination

When modding it is up to you what kind of modder you want to be. Do you want to make things that make your game experience easier and “cheat” or do you want to keep the balance and enrich the experience. Personally I do not like the mods that give a feeling of cheating. I always go for balance and love the fact we can add stuff to the game to enrich the experience.

## A new specialist for gold mines

For our second mod we are going to make a new specialist. Our imagination is limitless! Maybe you always thought about a specialist missing from the game. Now is the time we are going to realise this!

We are going to create an specialist for the gold mines in the New World. This mine has a high production time of 2min30s. With an item we could boost this production without touching the mine itself and give the player the opportunity to boost the production with an trade union item and keep the game balanced.

## Our mod structure

Compared to the previous mod we will now have some more folders and files we need to create. We will call our mod "Tutorial Specialists" The structure now will look like this:

- [Gameplay] Tutorial Specialists
  - data
    - config
      - export
        - main
          - asset
            - xml file (assets.xml) which contains all the logic for your mod.
      - gui
        - xml files containing the translations for text in every language
          - texts_english.xml
          - texts_french.xml
          - texts_german.xml
          - …
    - graphics
      - icons
        - Custom graphics we use in our mod as icons for the specialist

## What icon do we use?

For this mod we will start with creating the graphic we need. The icon that will be used for the specialist. The game already has a lot of icons and all those icons are in the gamefiles. We need to extract those icons from the data.rda files.

The icons can be found in all data.rda files. Depending on which DLC the icons will be from that specific DLC/theme. For example the Arctic icons will be available in the data.rda from the Arctic, data13: The Passage DLC.

The location of the icons we are going to use is data2.rda/data/ui/2kimages/main/3dicons/specialists/systemic. We will be using "icon_worker_602_0.dds". We convert this icon to a png file. We could just use the path of this icon but for best practice we use our own icon to make sure if the default icon is changed by Ubisoft, our mod will still work.

![icon_maria_lopez.png](./_sources/icon_maria_lopez.png)

**Info:** See the previous tutorial (Tutorial 1 - My first mod) if you do not know how to open rda files and convert dds files to png.

## Changing the icon

We could change the icon in a image editor. For example we make her clothes black because she is working in a mine. The name of our specialist will be **"Maria Lopez"**.

![icon_maria_lopez_v2.png](./_sources/icon_maria_lopez_v2.png)

## Location of the icon

Put the icon on in the map we already created in our mod structure.  
[Gameplay] Tutorial Specialists/data/graphics/icons

## Time to code! Translations

First we will be creating our translations for this mod. We do this in the translationfiles that can be found on a specific location.  
[Gameplay] Tutorial Specialists/data/config/gui

The translationfiles are created for different languages. The fallback language is English. If you only created the English translation all other languages will see the text also in English.

### Supported languages

There are a lot of languages supported within Anno 1800. Every language file is a xml file with the ModOps structure. We have files for every language. Those files always have the same name and location.

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

### Structure of the file

Let's start with the texts_english.xml and create this file in the right folder.  
[Gameplay] Tutorial Specialists/data/config/gui

The structure of a translationfile starts like most modding files:

```XML
<ModOps>


</ModOps>
```

After that we have again a specific ModOp with a type and path. In this case we will be adding new text exports to the text files. So we have the Type="add" and we will be adding this to the Path="/TextExport/Texts".

```XML
<ModOps>
   <ModOp Type="add" Path="/TextExport/Texts">

   </ModOp>
</ModOps>
```

We will be adding text for 2 things in this mod. The **name of the specialist with a tagline**, and a **description of the specialist**. Those 2 texts need a unique identfier, a GUID. Like we saw in the previous tutorial the GUID is a number that represents something in the game. In this case it will represent the specialist and the description of the specialist.

For this first part of this mod we will be using GUID's 1742008800 (name) and 1742008801 (description). Choose your own GUID's to make sure you do not get conflicts with other mods.

**Info:** See the previous tutorial (Tutorial 1 - My first mod) if you want to know more about GUID's and why you should take your own GUID's.

Now that we know which GUID's we are going to use and we already know the name of our specialist (Maria Lopez), the only thing we need is the tagline and the description. You do not need to go fancy but it is a nice touch to put some extra effort in some nice tagline and backgroundstory for the specialist you are creating. Let's give Maria some nice story and put that in the game as a description.

The structure to put those languages in there goes as following:

```XML
<ModOps>
  <ModOp Type="add" Path="/TextExport/Texts">
    <!-- START SPECIALIST - Maria Lopez -->
    <Text>
      <GUID>1742008800</GUID>
      <Text>Maria Lopez, Mining yellow stones</Text>
    </Text>
    <Text>
      <GUID>1742008801</GUID>
      <Text>Maria is one of the few woman in the mining business. She loves working in the mines and she is really good at it. In the beginning men made fun of her. But it did not take long before they had to admit she was doing amazing work. She perfected the mining in the New World so the gold can even be extracted in easier ways. She is now honored for her hard work and inventions.</Text>
    </Text>
    <!-- END SPECIALIST - Maria Lopez -->
  </ModOp>
</ModOps>
```

We now have our main English text. We can copy paste those texts to the other translationfiles we can create in the same folder or only use the English translation file.

- texts_chinese.xml
- texts_french.xml
- texts_german.xml
- texts_italian.xml
- texts_japanese.xml
- texts_korean.xml
- texts_polish.xml
- texts_russian.xml
- texts_spanish.xml
- texts_taiwanese.xml

## Creating the specialist, Create our assets.xml

Now the real work can start. We create again our assets.xml in the right location:  
[Gameplay] Tutorial Specialists/data/config/export/main/asset/

We start again by creating our opening and closing ModOps tags.

```XML
<ModOps>


</ModOps>
```

Next we create our ModOp with our Type. In this case we will again be adding a new asset, but in this case we will do it after a specific already existing item.
The last item in the list of Trade Union items is the item with the GUID 191431. I know this because I went to the main assets.xml of the last data.rda file and searched for it. We will add our item right after this item in the code structure.

We declare the GUID where we want to perform the action to in the ModOp and then which action. In this case add our mod as the next sibling of the GUID 191431 (Louis Comfort Tiffany - The Experimental Window Maker).

```XML
<ModOps>
   <!-- START SPECIALIST - Maria Lopez -->
   <ModOp GUID="191431" Type="addNextSibling">

   </ModOp>
   <!-- END SPECIALIST - Maria Lopez -->
</ModOps>
```

First let's add the &lt;Asset> tag to wrap our new specialist in.

```XML
<ModOps>
   <!-- START SPECIALIST - Maria Lopez -->
   <ModOp GUID="191431" Type="addNextSibling">
      <Asset>

      </Asset>
   </ModOp>
   <!-- END SPECIALIST - Maria Lopez -->
</ModOps>
```

## For which building?

With creating a new specialist item we can create this for every building and ships in the game. Every building and ship can be boosted or changed based on what the specialist does. A house can be boosted so it consumes for example less goods, a production building can be boosted so it produces at a higher rate, a coastal defense building can be boosted so it does more damage, a ship can also be boosted so it has a higher movement speed. All those boosts mentioned are just a fraction of what is possible. The game already has a lot of specialists with a lot of specialities. We can use those as an inspiration to create our own boosts.

Specialists can be used inside Trade Union, Town Hall, Harbourmaster's Office, Arctic Lodge and also in ships. We have to decide for which building we want to make the specialist. In this case for our first specialist we will be creating one for the Trade Union. The specialists for Trade Unions are the ones that boost factories and mines, so in this case the logical choice for our gold mine specialist.

## &lt;Template>

We are creating a new &lt;Asset> that has a specific structure. A lot of the assets that are used in Anno 1800 can be categorized. This is done to make it easier to create multiple assets with the same proporties. For example all items that can be used inside the Trade Union work the same way and have the same function. So, it is good to put that logic inside a **"template"** we can then use again and again to save a lot of work in the end.

Now that we know it is for the Trade Union we know which &lt;Template> we will be creating. There is a specific template for Trade Union items. This is the template **"GuildhouseItem"**.

### Templates

- GuildhouseItem (Trade Union, Harbourmaster's Office, Arctic Lodge)
- TownhallItem
- VehicleItem
- CultureItem

```XML
<ModOps>
   <!-- START SPECIALIST - Maria Lopez -->
   <ModOp GUID="191431" Type="addNextSibling">
      <Asset>
         <Template>GuildhouseItem</Template>

      </Asset>
   </ModOp>
   <!-- END SPECIALIST - Maria Lopez -->
</ModOps>
```

Go to the main assets.xml you extracted from the latest data.rda and search for **"&lt;Template>GuildhouseItem&lt;/Template>"**. You will get over 500 references in this file, which means there are already over 500 items that can be put inside the Trade Union. Take a moment to let that sink in... We did not even talk about the items for the Town Hall or other buildings. So, let's appreciate the hard effort the development team and graphic team already put into creating so many content.

Take a random &lt;Template>GuildhouseItem&lt;/Template> and have a look at what you can see in the &lt;Asset> structure.

We first have another container inside the &lt;Asset>, titled &lt;Values>.

```XML
<ModOps>
   <!-- START SPECIALIST - Maria Lopez -->
   <ModOp GUID="191431" Type="addNextSibling">
      <Asset>
         <Template>GuildhouseItem</Template>
         <Values>

         </Values>
      </Asset>
   </ModOp>
   <!-- END SPECIALIST - Maria Lopez -->
</ModOps>
```

## &lt;Standard>

The next part of the asset is the standard part. This contains our main GUID for this specialist, the name, the icon and the description.

For the **GUID** we take the main GUID we allocated for this specialist. In our case 1742008800.

For the **Name** we repeat the name we originally gave to our specialist. This will be taken as a fallback but will be overwritten with our translation file.

The **IconFileName** is the path to the icon we previously created.

Last is the **InfoDescription**. This is the reference to the description GUID we created in the translation file.

```XML
<ModOps>
   <!-- START SPECIALIST - Maria Lopez -->
   <ModOp GUID="191431" Type="addNextSibling">
      <Asset>
         <Template>GuildhouseItem</Template>
         <Values>
            <Standard>
                <GUID>1742008800</GUID>
                <Name>Maria Lopez, Mining yellow stones</Name>
                <IconFilename>data/graphics/icons/icon_maria_lopez_v2.png</IconFilename>
                <InfoDescription>1742008801</InfoDescription>
            </Standard>
         </Values>
      </Asset>
   </ModOp>
   <!-- END SPECIALIST - Maria Lopez -->
</ModOps>
```

## &lt;Text>

Next is a part we can just copy paste and that we do not have to understand completly. Just make sure it is there.

```XML
<ModOps>
   <!-- START SPECIALIST - Maria Lopez -->
   <ModOp GUID="191431" Type="addNextSibling">
      <Asset>
         <Template>GuildhouseItem</Template>
         <Values>
            <Standard>
                <GUID>1742008800</GUID>
                <Name>Maria Lopez, Mining yellow stones</Name>
                <IconFilename>data/graphics/icons/icon_maria_lopez_v2.png</IconFilename>
                <InfoDescription>1742008801</InfoDescription>
            </Standard>
            <Text>
               <LocaText>
                  <English>
                     <Text>Item Template</Text>
                     <Status>Exported</Status>
                     <ExportCount>1</ExportCount>
                  </English>
               </LocaText>
            </Text>
         </Values>
      </Asset>
   </ModOp>
   <!-- END SPECIALIST - Maria Lopez -->
</ModOps>
```

## &lt;Item>

The **Item** part is the next part and we are going to talk some more about this part. It contains global item settings.

### MaxStackSize

Defines how many items you could stack together in 1 slot on a ship. Standard is 1. If you want you could change that.

### Rarity

We have different rarities in the game.

- Common
- Uncommon
- Rare
- Epic
- Legendary

The item we will be creating is a legendary item. Which you want to take depends on how strong the specialist/item you are creating is.

### ItemType

The itemtype we are using for this specialist is **"Specialist"**. But there are also "Normal" used for Cultural items.

### Allocation

With the Allocation we define where this item fits in to. This is in some way linked to the &lt;Template> we have choosen.

Allocation can be:

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

This specialist will fit into the **"GuildHouse"**.

### TradePrice & TradePriceOnlineCurrency

Defines what is will cost to buy and sell the item. Legendary items should cost more then common items.

```XML
<ModOps>
   <!-- START SPECIALIST - Maria Lopez -->
   <ModOp GUID="191431" Type="addNextSibling">
      <Asset>
         <Template>GuildhouseItem</Template>
         <Values>
            <Standard>
                <GUID>1742008800</GUID>
                <Name>Maria Lopez, Mining yellow stones</Name>
                <IconFilename>data/graphics/icons/icon_maria_lopez_v2.png</IconFilename>
                <InfoDescription>1742008801</InfoDescription>
            </Standard>
            <Text>
               <LocaText>
                  <English>
                     <Text>Item Template</Text>
                     <Status>Exported</Status>
                     <ExportCount>1</ExportCount>
                  </English>
               </LocaText>
            </Text>
            <Item>
               <MaxStackSize>1</MaxStackSize>
               <Rarity>Legendary</Rarity>
               <ItemType>Specialist</ItemType>
               <Allocation>GuildHouse</Allocation>
               <TradePrice>1250000</TradePrice>
               <TradePriceOnlineCurrency>1250000</TradePriceOnlineCurrency>
            </Item>
         </Values>
      </Asset>
   </ModOp>
   <!-- END SPECIALIST - Maria Lopez -->
</ModOps>
```

## The main modding part for specialists

The next tags are the tags that will define the specialist the most. Those tags will add production boosts, replace inputs, will define to which buildings the specialist will have effect to, ect. We will go over a lot of them but not all. If you want to know what all the tags do check the main assets.xml and where it is used and compare what is does with the corresponding specialist.

A lot of the tags do not have an opening and closing tag, but just have 1 tag with the / at the end. Those do not do anything and they there purely as reference. If we actually want to use this we need to follow the right structure depending on the tag.

### IndustrializableUpgrade

For this &lt;IndustrializableUpgrade> we need the following structure:

```XML

<IndustrializableUpgrade>
  <ProvideIndustrialization>1</ProvideIndustrialization>
</IndustrializableUpgrade>

```

It contains the opening and closing tag, and within another tag that is set to "1". With putting the value "1" there with the other tag we define that this value is set to "true". If we change this to "0" we would define it as false.

In this case this tag means that the specialist will **provide electricity within the range of the trade union**.

If you want to see an example of this for an already existing item check GUID 191355 - "Prof. Ram Devi, The Bundle of Energy". If you check the name of this GUID, you see the working title for this specialist was "Nikola Tesla - The Great Inventor". They probably changed this because using real life historic people was not ok to do.

### FactoryUpgrade

This is a really important one that can contain multiple things.

Example:

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

In this example of Gerhard Fuchs, of the Patent Eyeglass we have 3 different parts who can be used apart from eachoter and do not have to be there together like in this example. If you only want to use one of the 3 it is perfectly possible.

#### ProductivityUpgrade

With the **ProductivityUpgrade** we can define a % productionboost. We put a **% value** inbetween the value tags. So in this example we have a productionboost of 50%. So the factory will be boosted to a production of 150%.

Good to know, this value can also be negative, for example -50%. In some cases we want to decrease the productivity. A case where it could have a benefit is for example heaters or power plants. Those buildings consume a good every cycle to give a buff in return. A longer cycle with 1 input good is positive in this case. So the negative production boost is in this case better then a positive.

#### AdditionalOutput

With the **AdditionalOutput** we can define a product that is produced extra every couple of productioncycles. We define which product with the corresponding GUID for that product. If you want to search for a product use the fantastic search function on the website https://schwubbe.de/modding_blog.php.In this example we have the GUID 1010246 which is pocket watches.

We define also the number of cycles it needs to produce this good. In this case every 3 cycles a pocket wwatch will be produced as an extra product.

#### ReplaceInputs

The last part is **ReplaceInputs** where we replace one of the input products with another product. We do this by defining the 2 GUID's for both products and put those in the corrects tags. In this case brass is replaced by wood.

### ItemEffect

Example:

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

The **ItemEffect** defines to which building the specialist will have an effect. In this case multiple buildings. Good to know, this does not have to be a building. It can also be a GUID of a group of buildings. For example **GUID 25599** is **All Production Buildings**.

### BuildingUpgrade

Example:

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

With the **BuildingUpgrade** we can change **maintenance costs** of the building and the **amount of workforce** that is needed.

#### MaintenanceUpgrade

In the example above the maintenance cost is decreased by 20%. We can define a negative value here or a positive value of we want to increase the maintenance costs.

#### WorkforceAmountUpgrade

We also have workforce that is needed to let a building produce goods. With **WorkforceAmountUpgrade** we can change the amount that is needed. Again, this can be negative or positive as a value.

### ResidenceUpgrade

Examples:

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
```

With **ResidenceUpgrade** we can provide goods or services to houses. This is not really used for items for Trade Unions, but mostly for items for Town Halls.

#### AdditionalHappiness

Provide **Happiness** to people in the radius. Define a flat amount. This can be a positive or negative value.

#### GoodConsumptionUpgrade

This provides a % you define of a specific good to the people in that radius. In the above example 3 products are provides for the % of less consumption. The products are defined by their GUID. For easy checking use comments next to it to know which products.

#### TaxModifierInPercent

Let people pax more or less taxes. This amount can be positive and negative.

#### WorkforceModifierInPercent

Boost the amount of people in the houses. This can be a negative or positive value.

#### NeedProvideNeedUpgrade

A good or service can be used as a substitute for another good. In the above example the **Pub** is a substitute for **bread, sausages and fish**. When the citizen are provided with the pub they are also provided with bread, sausages and fish.

### CultureUpgrade

Examples:

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

We can also change the **Attractiveness** with a flat amount or a percentage. See above examples as references.

### ExpeditionAttribute

Example:

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

Items can also be used for expeditions. We can define what the attributes should be for the item. There is a list for all types of attributes.

#### BaseMorale

Every expedition needs a good morale. You can provide a base amount of morale with the item. Define a flat amount.

#### Trait/Perk

For the perks we can add as much as we want combined with a amount value of 1.

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

For the skills we can also add as much as we want combined with the amount we want.

- Crafting
- Diplomacy
- Melee (Force)
- Might (Naval Power)
- Navigation
- Medicine
- Faith
- Hunting

#### ItemDifficulties

This can be:

- Easy
- Average
- Hard

### Locked

```XML

<Locked>
    <DefaultLockedState>1</DefaultLockedState>
    <DLCDependency>410041</DLCDependency>
</Locked>

```

You can lock a specialist for a obvious reason. For example if it can only be used if a specific DLC is available. You use the GUID of the DLC to define it. The example above is for the Land of Lions DLC.

List of Dependencies:

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

### ModuleOwnerUpgrade

```XML

<ModuleOwnerUpgrade>
    <ModuleLimitPercent>-10</ModuleLimitPercent>
</ModuleOwnerUpgrade>

```

Some buildings have modules. For example farms. You can reduce or increase the mount of modules needed for the buildings in range of the trade union where this item is used. You use a positive or negative % amount.

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

IncidentInfectableUpgrade reduces or increases the chance for one of the 4 possible incidents.

- Fire
- Illness
- Riots
- Explosions

Put a value inbetween 0 and 10 or 0 and -10. 1 is 10%, -5 is -50% and so on.

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

#### StressUpgrade

This can adapt the impact of working conditions. For example if you upped the workingconditions for your workforce you can mitigate this with this buff. Choose a negative percentage amount.

In the example above, the impact of working conditions is reduced by 35%.

#### ResidentsUpgrade

As far as I can see this does not do anything anymore and was replaced with InputBenefitModifier.

#### InputBenefitModifier

It defines for what good we get extra citizen for and how many.

In the example above, residences with the need of Musicians' Court and Clay Pipes fullfilled get 5 more residences and 10 more coins. Also residences with the University need fullfilled are giving an additional 1 research point and an additional 10 happiness.

### KontorUpgrade

```XML

<KontorUpgrade>
    <HappinessIgnoresMorale>1</HappinessIgnoresMorale>
    <BlockHostileTakeover>1</BlockHostileTakeover>
    <BlockBuyShare>1</BlockBuyShare>
</KontorUpgrade>

```

#### HappinessIgnoresMorale

Residences no longer lose happiness as a result of morale loss during island wars when value is set to 1.

#### BlockHostileTakeover

Prevents another party from taking ownership of your island when they possess all shares when setting value to 1.

#### BlockBuyShare

Locks the shares of your island, preventing another party from purchasing them when value is set to 1.

### PassiveTradeGoodGenUpgrade

```XML

<PassiveTradeGoodGenUpgrade>
    <GenProbability>25</GenProbability>
    <GenPool>191637</GenPool> <!-- Protectionism Defender Pool 2 -->
</PassiveTradeGoodGenUpgrade>

```

Every time passive trade happens at the trading post, there is a chance of gaining the amount of goods you defined.

### HeaterUpgrade

```XML

<HeaterUpgrade>
    <HeatRangeUpgrade>
        <Value>20</Value>
        <Percental>1</Percental>
    </HeatRangeUpgrade>
</HeaterUpgrade>

```

Increase the range of heating provided by the heating building by % amount.

### PowerplantUpgrade

```XML

<PowerplantUpgrade>
    <IndustrializationRangeUpgrade>
        <Value>10</Value>
    </IndustrializationRangeUpgrade>
</PowerplantUpgrade>

```

Increase the range of electricity provided by the power plant by % amount.

### IrrigationUpgrade

```XML

<IrrigationUpgrade>
    <PipeCapacityUpgrade>
        <Value>20</Value>
    </PipeCapacityUpgrade>
</IrrigationUpgrade>

```

Increase the amount of canal tiles you can use for a water pump.

## Let's choose what we need

The only thing left for our mod is now to choose from all the possibilities mentioned above.

We wil choose a **FactoryUpgrade** with a **ProductivityUpgrade** of 200% and an **AdditionalOutput** of **Iron every 4 cycles**.

This specialist will have effect on the **Gold mine** so we choose that in the **ItemEffect**.

For **ExpeditionAttribute** we use the **PerkFemale**, with **Crafting of 40** and **Diplomacy of 10**. With a **ItemDifficulties of Hard**.

For **BuildingUpgrade** we choose a **WorkforceAmountUpgrade of +50%**.

```XML

<ModOps>
    <ModOp GUID="191431" Type="addNextSibling">
        <Asset>
            <Template>GuildhouseItem</Template>
            <Values>
                <Standard>
                    <GUID>1742008800</GUID>
                    <Name>Maria Lopez, Mining yellow stones</Name>
                    <IconFilename>data/graphics/icons/icon_maria_lopez_v2.png</IconFilename>
                    <InfoDescription>1742008801</InfoDescription>
                </Standard>
                <Text>
                    <LocaText>
                        <English>
                            <Text>Item Template</Text>
                            <Status>Exported</Status>
                            <ExportCount>1</ExportCount>
                        </English>
                    </LocaText>
                </Text>
                <Item>
                    <MaxStackSize>1</MaxStackSize>
                    <Rarity>Legendary</Rarity>
                    <ItemType>Specialist</ItemType>
                    <Allocation>GuildHouse</Allocation>
                    <TradePrice>1250000</TradePrice>
                    <TradePriceOnlineCurrency>1250000</TradePriceOnlineCurrency>
                </Item>
                <FactoryUpgrade>
                    <ProductivityUpgrade>
                        <Value>200</Value>
                        <Percental>1</Percental>
                    </ProductivityUpgrade>
                    <AdditionalOutput>
                        <Item>
                            <Product>1010227</Product> <!-- Iron -->
                            <AdditionalOutputCycle>4</AdditionalOutputCycle>
                            <Amount>1</Amount>
                        </Item>
                    </AdditionalOutput>
                </FactoryUpgrade>
                <ItemEffect>
                    <EffectTargets>
                        <Item>
                            <GUID>101311</GUID> <!-- Gold Mine -->
                        </Item>
                    </EffectTargets>
                </ItemEffect>
                <ExpeditionAttribute>
                    <BaseMorale>0</BaseMorale>
                    <ExpeditionAttributes>
                        <Item>
                            <Attribute>PerkFemale</Attribute>
                            <Amount>1</Amount>
                        </Item>
                        <Item>
                            <Attribute>Crafting</Attribute>
                            <Amount>40</Amount>
                        </Item>
                        <Item>
                            <Attribute>Diplomacy</Attribute>
                            <Amount>10</Amount>
                        </Item>
                    </ExpeditionAttributes>
                    <ItemDifficulties>Hard</ItemDifficulties>
                </ExpeditionAttribute>
                <BuildingUpgrade>
                    <WorkforceAmountUpgrade>
                        <Value>+50</Value>
                        <Percental>1</Percental>
                    </WorkforceAmountUpgrade>
                </BuildingUpgrade>
            </Values>
        </Asset>
    </ModOp>
</ModOps>

```

### Things we did not completly cover (yet)

We also have other places we can use specialists. For example Town Hall, Harbourmaster's Office, Arctic Lodge and also in ships. We just made a specialist/item for the Trade Union but the possibilities above include some of the possiblilities for the other buildings. But that list is not complete! Dive a bit in the code of the assets.xml yourself to learn more about what is even more possible for other specialists/items. For example, ships have a completely different type of possibilities compared to buildings.

Some other possibilities:

- CraftableItem
- EcoSystemProviderUpgrade
- PierUpgrade
- WarehouseUpgrade
- ItemContainerUpgrade
- ResourceUpgrade
- VehicleUpgrade
- RepairCraneUpgrade
- AttackableUpgrade
- ProjectileUpgrade
- ShipyardUpgrade
- AttackerUpgrade
- VisitorHarborUpgrade
- ItemAction

Maybe I'll expand in the future and provide extra info on those and more items/specialists for other templates.

## Rewardpool/Itempool

We have created our specialist, but we are not done yet with the mod. To use the specialist ingame we need to add that specialist to an **Itempool**. There are a lot of Itempools in the game. Every pool is a group of items with specific properties.

Example 192975 - Rewardpool: Specialists - Legendary

```XML

<Asset>
    <Template>RewardPool</Template>
    <Values>
        <Standard>
            <GUID>192975</GUID>
            <Name>Specialists - Legendary</Name>
        </Standard>
        <RewardPool>
            <ItemsPool>
                <Item>
                    <ItemLink>192732</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192737</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192840</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192742</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192850</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192747</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192752</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192757</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192762</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192767</ItemLink>
                </Item>
            </ItemsPool>
        </RewardPool>
        <Locked />
        <Text />
    </Values>
</Asset>

```

We see in this rewardpool an itempool of different items. The rewardpool is the way of making the item available ingame. Some rewardpools make items available by quests, others to be able to get by expeditions, others to be able to be bought at certain neutral traders, ect. The list of rewardpools is HUGE. Maybe I;ll add a complete list of rewardpools later to this tutorial, but for now we will just take a couple for this specific mod and then it is up to you to dive into the main assets.xml and search for **&lt;Template>RewardPool&lt;/Template>** and choose the ones you want. You can check the statitics screen ingame with the item tab to check how to get the item to be sure it is still balanced, but that is up to you.

### Adding our rewardpools in our ModOp

To add our specialist to a rewardpool we need to create a new **&lt;ModOp>**. We will be adding our item to the &lt;ItemsPool> in those rewardpools.

Remember the previous tutorial where we looked at the path of Feras to understand where we needed to replace a specific value? This time it is somwhat the same.

Instead of the **Type="replace"**, we will now use the **Type="add"**.

```XML

<ModOp Type="add">

</ModOp>

```

We will add this new item to specific Rewardpools. We need to know the ID's from those rewardpools. The item we are creating is an item for Gold mines and the trade union. So, actually for the New World. So we could take rewardpools that are specificly for the New world.

- 192975 - Specialists - Legendary
- 192737 - Specialists - South American Goods - Legendary
- 192840 - Specialists - Europe and SA Goods - Legendary
- 193963 - Specialists - Europe and SA Goods - Legendary - Guild
- 192904 - Sarmento Legendary Specialists
- 192909 - Eli Legendary Specialists

We also choose some global rewardpools.

```XML

<ModOp Type="add" GUID="192975,192737,192840,193963,192904,192909">

</ModOp>

```

The next thing we need to do is define where we want to add our item in the rewardpool. If we do not define a path it will just be added in the root of the rewardpool and that is not the right location.

If we look at the rewardpool we can see the same structure for every rewardpool. We have the GUID and name in the beginning in a Standard tag and underneath that we have the Rewardpool tag and in that the ItemsPool tag where all the items are in.

```XML

<Asset>
    <Template>RewardPool</Template>
    <Values>
        <Standard>
            <GUID>192975</GUID>
            <Name>Specialists - Legendary</Name>
        </Standard>
        <RewardPool>
            <ItemsPool>
                <Item>
                    <ItemLink>192732</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192737</ItemLink>
                </Item>
                <Item>
                    <ItemLink>192840</ItemLink>
                </Item>
                ...
            </ItemsPool>
        </RewardPool>
        <Locked />
        <Text />
    </Values>
</Asset>

```

We want to add our item in the **ItemsPool**. So we look at the path we need to take from the start of the Asset. to get to the ItemsPool. This is Values > RewardPool > ItemsPool.

```XML

<ModOp  Type="add" GUID="192975,192737,192840,193963,192904,192909" Path="/Values/RewardPool/ItemsPool">

</ModOp>

```

Now we put what we want to add in the structure inside.

```XML

<ModOp Type="add" GUID="192975,192737,192840,193963,192904,192909" Path="/Values/RewardPool/ItemsPool">
    <Item>
        <ItemLink>1742008800</ItemLink> <!-- Maria Lopez -->
    </Item>
</ModOp>

```

Now we put this underneath our first ModOp and in our main ModOps, so before the ModOps closing tag.

```XML

<ModOps>
    <ModOp GUID="191431" Type="addNextSibling">
        <Asset>
            <Template>GuildhouseItem</Template>
            <Values>
                <Standard>
                    <GUID>1742008800</GUID>
                    <Name>Maria Lopez, Mining yellow stones</Name>
                    <IconFilename>data/graphics/icons/icon_maria_lopez_v2.png</IconFilename>
                    <InfoDescription>1742008801</InfoDescription>
                </Standard>
                <Text>
                    <LocaText>
                        <English>
                            <Text>Item Template</Text>
                            <Status>Exported</Status>
                            <ExportCount>1</ExportCount>
                        </English>
                    </LocaText>
                </Text>
                <Item>
                    <MaxStackSize>1</MaxStackSize>
                    <Rarity>Legendary</Rarity>
                    <ItemType>Specialist</ItemType>
                    <Allocation>GuildHouse</Allocation>
                    <TradePrice>1250000</TradePrice>
                    <TradePriceOnlineCurrency>1250000</TradePriceOnlineCurrency>
                </Item>
                <FactoryUpgrade>
                    <ProductivityUpgrade>
                        <Value>200</Value>
                        <Percental>1</Percental>
                    </ProductivityUpgrade>
                    <AdditionalOutput>
                        <Item>
                            <Product>1010227</Product> <!-- Iron -->
                            <AdditionalOutputCycle>4</AdditionalOutputCycle>
                            <Amount>1</Amount>
                        </Item>
                    </AdditionalOutput>
                </FactoryUpgrade>
                <ItemEffect>
                    <EffectTargets>
                        <Item>
                            <GUID>101311</GUID> <!-- Gold Mine -->
                        </Item>
                    </EffectTargets>
                </ItemEffect>
                <ExpeditionAttribute>
                    <BaseMorale>0</BaseMorale>
                    <ExpeditionAttributes>
                        <Item>
                            <Attribute>PerkFemale</Attribute>
                            <Amount>1</Amount>
                        </Item>
                        <Item>
                            <Attribute>Crafting</Attribute>
                            <Amount>40</Amount>
                        </Item>
                        <Item>
                            <Attribute>Diplomacy</Attribute>
                            <Amount>10</Amount>
                        </Item>
                    </ExpeditionAttributes>
                    <ItemDifficulties>Hard</ItemDifficulties>
                </ExpeditionAttribute>
                <BuildingUpgrade>
                    <WorkforceAmountUpgrade>
                        <Value>+50</Value>
                        <Percental>1</Percental>
                    </WorkforceAmountUpgrade>
                </BuildingUpgrade>
            </Values>
        </Asset>
    </ModOp>

    <ModOp Type="add" GUID="192975,192737,192840,193963,192904,192909" Path="/Values/RewardPool/ItemsPool">
        <Item>
            <ItemLink>1742008800</ItemLink> <!-- Maria Lopez -->
        </Item>
    </ModOp>
</ModOps>

```

We are almost there! One last step.

## Triggers

Some items, buildings or other things in the game are not available from the start. You have to unlock those by progressing in the game. For example, you have to start with farmers and work your way up to investors. To do that you have to unlock everything step by step.

Unlocking those possibilities is done with **Triggers**. A lot of the things in the game have triggers, and we also need those triggers to make our specialiast actually available in the game.

There are 2 parts of a trigger. First you need to **Unhide** the asset, then you need to **Unlock** the asset.

Those triggers also have their own GUID. We need 1 trigger for our specialist mod, se we will be creating GUID 1742008802. We will combine the Unhide and the Unlock in 1 trigger. In other cases this can be done separatly because the Unhide and the Unlock not always have the same conditions.

### Unhide & Unlock

We will be adding our trigger after an already existing trigger as the next sibling. So, we choose Type="addnextSibling" and then the GUID of that trigger. In this case "130248".

```XML

<ModOp Type="addnextSibling" GUID="130248">

</ModOp>

```

This template we are going to use now is a **Trigger**. As you can see, templates are powerful things.

```XML

<ModOp Type="addnextSibling" GUID="130248">
    <Asset>
        <Template>Trigger</Template>
    </Asset>
</ModOp>

```

To see an example of a trigger template search for &lt;Template>Trigger&lt;/Template> in the main assets.xml.

Let's take over the parts we need.

## Standard

We have our **Standard** part which do not need to much explanation. We use our new GUID here to give this trigger a unique identifier and give our trigger a name.

## Trigger

### TriggerCondition

As the name states, here we define what the condition will be for our trigger to go off, and make our item available in the game.

The **ConditionPlayerCounter** is a base template we always add. The values that it contains can change. In this case we will use **PopulationByLevel** which states that the trigger will go off when we hit a certain population. In the &lt;Context> we put a GUID of a population tier which threshold we want to hit. Underneath we put the &lt;CounterAmount> of that population. For this mod we will make our specialist available when hitting 500 Obrero citizen. So we need the GUID of the Obrero population. This is GUID 15000006. I searched for this with the tool on https://schwubbe.de/modding_blog.php.

```XML

<ModOp Type="addnextSibling" GUID="130248">
    <Asset>
        <Template>Trigger</Template>
        <Values>
            <Standard>
                <GUID>1742008802</GUID>
                <Name>Specialist Trigger</Name>
            </Standard>
            <Trigger>
                <TriggerCondition>
                    <Template>ConditionPlayerCounter</Template>
                    <Values>
                        <Condition />
                        <ConditionPlayerCounter>
                            <PlayerCounter>PopulationByLevel</PlayerCounter>
                            <Context>15000006</Context>
                            <CounterAmount>500</CounterAmount>
                        </ConditionPlayerCounter>
                    </Values>
                </TriggerCondition>
            </Trigger>
            <TriggerSetup />
        </Values>
    </Asset>
</ModOp>

```

Now the last step of our tutorial, adding the specialist to the trigger. Unhide and Unlock it.

```XML

<ModOp Type="addnextSibling" GUID="130248">
    <Asset>
        <Template>Trigger</Template>
        <Values>
            <Standard>
                <GUID>1742008802</GUID>
                <Name>Specialist Trigger</Name>
            </Standard>
            <Trigger>
                <TriggerCondition>
                    <Template>ConditionPlayerCounter</Template>
                    <Values>
                        <Condition />
                        <ConditionPlayerCounter>
                            <PlayerCounter>PopulationByLevel</PlayerCounter>
                            <Context>15000006</Context>
                            <CounterAmount>500</CounterAmount>
                        </ConditionPlayerCounter>
                    </Values>
                </TriggerCondition>
                <TriggerActions>
                    <Item>
                        <TriggerAction>
                            <Template>ActionUnlockAsset</Template>
                            <Values>
                                <Action />
                                <ActionUnlockAsset>
                                    <UnhideAssets>
                                        <Item>
                                            <Asset>1742008800</Asset> <!-- Maria Lopez -->
                                        </Item>
                                    </UnhideAssets>
                                    <UnlockAssets>
                                        <Item>
                                            <Asset>1742008800</Asset> <!-- Maria Lopez -->
                                        </Item>
                                    </UnlockAssets>
                                </ActionUnlockAsset>
                            </Values>
                        </TriggerAction>
                    </Item>
                </TriggerActions>
            </Trigger>
            <TriggerSetup />
        </Values>
    </Asset>
</ModOp>

```

We should now have the fantastic assets.xml like this:

```XML

<ModOps>
    <ModOp GUID="191431" Type="addNextSibling">
        <Asset>
            <Template>GuildhouseItem</Template>
            <Values>
                <Standard>
                    <GUID>1742008800</GUID>
                    <Name>Maria Lopez, Mining yellow stones</Name>
                    <IconFilename>data/graphics/icons/icon_maria_lopez_v2.png</IconFilename>
                    <InfoDescription>1742008801</InfoDescription>
                </Standard>
                <Text>
                    <LocaText>
                        <English>
                            <Text>Item Template</Text>
                            <Status>Exported</Status>
                            <ExportCount>1</ExportCount>
                        </English>
                    </LocaText>
                </Text>
                <Item>
                    <MaxStackSize>1</MaxStackSize>
                    <Rarity>Legendary</Rarity>
                    <ItemType>Specialist</ItemType>
                    <Allocation>GuildHouse</Allocation>
                    <TradePrice>1250000</TradePrice>
                    <TradePriceOnlineCurrency>1250000</TradePriceOnlineCurrency>
                </Item>
                <FactoryUpgrade>
                    <ProductivityUpgrade>
                        <Value>200</Value>
                        <Percental>1</Percental>
                    </ProductivityUpgrade>
                    <AdditionalOutput>
                        <Item>
                            <Product>1010227</Product> <!-- Iron -->
                            <AdditionalOutputCycle>4</AdditionalOutputCycle>
                            <Amount>1</Amount>
                        </Item>
                    </AdditionalOutput>
                </FactoryUpgrade>
                <ItemEffect>
                    <EffectTargets>
                        <Item>
                            <GUID>101311</GUID> <!-- Gold Mine -->
                        </Item>
                    </EffectTargets>
                </ItemEffect>
                <ExpeditionAttribute>
                    <BaseMorale>0</BaseMorale>
                    <ExpeditionAttributes>
                        <Item>
                            <Attribute>PerkFemale</Attribute>
                            <Amount>1</Amount>
                        </Item>
                        <Item>
                            <Attribute>Crafting</Attribute>
                            <Amount>40</Amount>
                        </Item>
                        <Item>
                            <Attribute>Diplomacy</Attribute>
                            <Amount>10</Amount>
                        </Item>
                    </ExpeditionAttributes>
                    <ItemDifficulties>Hard</ItemDifficulties>
                </ExpeditionAttribute>
                <BuildingUpgrade>
                    <WorkforceAmountUpgrade>
                        <Value>+50</Value>
                        <Percental>1</Percental>
                    </WorkforceAmountUpgrade>
                </BuildingUpgrade>
            </Values>
        </Asset>
    </ModOp>

    <ModOp Type="add" GUID="192975,192737,192840,193963,192904,192909" Path="/Values/RewardPool/ItemsPool">
        <Item>
            <ItemLink>1742008800</ItemLink> <!-- Maria Lopez -->
        </Item>
    </ModOp>

    <ModOp Type="addnextSibling" GUID="130248">
        <Asset>
            <Template>Trigger</Template>
            <Values>
                <Standard>
                    <GUID>1742008802</GUID>
                    <Name>Specialist Trigger</Name>
                </Standard>
                <Trigger>
                    <TriggerCondition>
                        <Template>ConditionPlayerCounter</Template>
                        <Values>
                            <Condition />
                            <ConditionPlayerCounter>
                                <PlayerCounter>PopulationByLevel</PlayerCounter>
                                <Context>15000006</Context>
                                <CounterAmount>500</CounterAmount>
                            </ConditionPlayerCounter>
                        </Values>
                    </TriggerCondition>
                    <TriggerActions>
                        <Item>
                            <TriggerAction>
                                <Template>ActionUnlockAsset</Template>
                                <Values>
                                    <Action />
                                    <ActionUnlockAsset>
                                        <UnhideAssets>
                                            <Item>
                                                <Asset>1742008800</Asset> <!-- Maria Lopez -->
                                            </Item>
                                        </UnhideAssets>
                                        <UnlockAssets>
                                            <Item>
                                                <Asset>1742008800</Asset> <!-- Maria Lopez -->
                                            </Item>
                                        </UnlockAssets>
                                    </ActionUnlockAsset>
                                </Values>
                            </TriggerAction>
                        </Item>
                    </TriggerActions>
                </Trigger>
                <TriggerSetup />
            </Values>
        </Asset>
    </ModOp>
</ModOps>

```

Save all the files, make sure everything looks ok and you can copy your mod to the modfolder and start the game. You should be able to see this item in the statistics screen in the item menu when you search for it.

Check the possibilities how you can get the item. If you are far enough in the game and have the research institute you should be able to research the item and then develop the item!

Have fun! And now you can make as many items, specialists if you want!
