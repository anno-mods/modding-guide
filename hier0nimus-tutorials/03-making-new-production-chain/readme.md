# Tutorial 3 - Making a new production chain

For our next mod we are taking another step in a more advanced mod. We are going to make a new production chain and a new good. We are not going to make it that complex for now and start with a basic production chain and one new product. We are going to make **citrus tea**.

## What are we going to do?

We are going to use an already existing good (**citrus**) to create a new good (**Citrus Tea**).

We will be creating:

- Product (Citrus Tea)
- Production chain (Citrus Tea production chain)
- Citizen needs (Citrus Tea as a Luxury Need for Engineers and Investors)
- Building texture. No 3D-modelling yet, just the texture.
- Icons
- Specialist

This can be a big step because it has a lot of small steps we need to take. But do not worry, we are going to do this step by step.

## Our mod structure

Compared to the previous mod we will now have some more folders and files we need to create. We will call our mod "Tutorial Specialists" The structure now will look like this:

- [Gameplay] Tutorial Citrus Tea
  - data
    - config
      - export
        - main
          - asset
            - xml file (assets.xml) which contains all the logic for our mod.
      - gui
        - xml files containing the translations for text in every language
          - texts_english.xml
          - texts_french.xml
          - texts_german.xml
          - …
    - graphics
      - buildings
        - production
          - production_citrus_tea  
            Contains production_citrus_tea files that describes the new building. - maps  
             Contains maps which are the materials/textures of our building. diff, mask, metal and norm file.
      - icons
        - Custom graphics we use in our mod. Icon for Citrus Tea and icon for specialist.

## Start with the icons

The icons we need for this mod are:

- Citrus Tea good
- Specialist

### Citrus Tea

If we look at what is already available in the game we have the Hibiscus Tea and citrus. Both icons can be recycled to make a new Citrus Tea icon.

For the Citrus icon we go to data18.rda/data/ui/2kimages/main/3dicons/icon_citrus_0.dds and convert the dds to a png.

For the Hibiscus Tea icon we go to data16.rda/data/ui/2kimages/main/3dicons/goods_africa/icon_hibiscus_tea_0.dds and convert the dds to a png.

![icon_citrus_0.png](./_sources/icon_citrus_0.png)
![icon_hibiscus_tea_0.png](./_sources/icon_hibiscus_tea_0.png)

We do some magic in our photo editing program and voila, we have a nice result.

![citrus-tea.png](./_sources/citrus-tea.png)

## Specialist

For the specialist, let's take a man and name him Tony Lipus, Citrua tea smasher. We go to the data2.rda/data/ui/2kimages/main/3dicons/specialists/systemic/icon_farmer_106_0.dds and convert this dds to a png.

![icon_farmer_106_0.png](./_sources/icon_farmer_106_0.png)

We do again some editing magic to get the result below. Changing some colors.

![icon_Tony Lipus_v2.png](./_sources/icon_tony_lipus_v2.png)

So, we now have our icons and can start with the next step.

## Our GUIDS

Let's start with defining all the GUIDS we need for this mod.

- 1742008803 (Tony Lipus, Citrus tea smasher)
- 1742008804 (Tony Lipus description)
- 1742008805 (Citrus Tea Good)
- 1742008806 (Citrus Tea Good description)
- 1742008807 (Citrus Tea Chain)
- 1742008808 (Citrus Tea Chain description)
- 1742008809 (Citrus Tea Dryer Building)
- 1742008810 (Citrus Tea Dryer Building description)
- 1742008811 (Trigger unhide)
- 1742008812 (Trigger unlock)

## Tony Lipus, Citrus tea smasher

Let's start with our specialist. We know from the previous tutorial how to create a new specialist. So that should not be that hard. See this as an extra exercise.

Steps we need to take:

- Create the translations
- Create the specialist with his proporties
- Add to rewardpool
- Add to trigger

### Create translation

Create the translation for our name of our specialist and the description.

```XML

<ModOps>
  <ModOp Type="add" Path="/TextExport/Texts">
    <!-- START SPECIALIST - Tony Lipus, Citrus tea smasher -->
    <Text>
      <GUID>1742008803</GUID>
      <Text>Tony Lipus, Citrus tea smasher</Text>
    </Text>
    <Text>
      <GUID>1742008804</GUID>
      <Text>Tony does not like the hibiscus tea. He prefers citrus fruits and made sure his tea is better then the hibiscus tea. He bottles some extra lemonade without any additive sugar. Sugar is the new smoking!</Text>
    </Text>
    <!-- END SPECIALIST - Tony Lipus, Citrus tea smasher -->
</ModOps>

```

### Create our specialist

We already created his **name with main GUID** (GUID 1742008803) and **description** (GUID 1742008804). The icon is also already created and we know the path to the icon.

We need to define what we want to do with the specialist. Tony is a specialist for the building that processes **Citrus** to **Citrus Tea**, the **Citrus Tea Dryer** (GUID 1742008809).

Let's make it a **Legendary Specialist** (Rarity & ItemType) item for the **Guildhouse** (Template & Allocation), because it is a specialist for a production building.

A **production boost** is always good (ProductivityUpgrade), so let's do that already for 60%.

In the description we talk about Tony hating additive sugar in **Lemonade** (GUID 133185) and making sugar free lemonade. This can be an extra good he produces when producing Citrus Tea. Let's say **every 4 cycles**.

The building he will have effect on (ItemEffect) is one of the buildings we still need to create, **Citrus Tea Dryer** (GUID 1742008809).

For **Expeditions** (ExpeditionAttribute), he is **male** (PerkMale) and is good at **Medicine - 50 and Diplomacy - 15**.

Let's also give him a **reduction for the workforce of 30%** (BuildingUpgrade).

```XML

  <!-- START SPECIALIST - Tony Lipus, Citrus tea smasher -->
  <ModOp GUID="191388" Type="addNextSibling">
    <Asset>
      <Template>GuildhouseItem</Template>
      <Values>
        <Standard>
          <GUID>1742008803</GUID> <!-- SPECIALIST - Tony Lipus, Citrus tea smasher -->
          <Name>Tony Lipus, Citrus tea smasher</Name>
          <IconFilename>data/modgraphics/icons/icon_tony_lipus_v2.png</IconFilename>
          <InfoDescription>1742008804</InfoDescription>
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
        <Locked />
        <Buff />
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
            <Value>60</Value>
            <Percental>1</Percental>
          </ProductivityUpgrade>
          <AdditionalOutput>
            <Item>
              <Product>133185</Product> <!-- Lemonade -->
              <AdditionalOutputCycle>4</AdditionalOutputCycle>
              <Amount>1</Amount>
            </Item>
          </AdditionalOutput>
        </FactoryUpgrade>
        <ItemEffect>
          <EffectTargets>
            <Item>
              <GUID>1742008809</GUID> <!-- Citrus Tea Dryer -->
            </Item>
          </EffectTargets>
        </ItemEffect>
        <ItemAction />
        <ExpeditionAttribute>
          <BaseMorale>0</BaseMorale>
          <ExpeditionAttributes>
            <Item>
              <Attribute>PerkMale</Attribute>
              <Amount>1</Amount>
            </Item>
            <Item>
              <Attribute>Medicine</Attribute>
              <Amount>50</Amount>
            </Item>
            <Item>
              <Attribute>Diplomacy</Attribute>
              <Amount>15</Amount>
            </Item>
            <Item />
            <Item />
          </ExpeditionAttributes>
          <ItemDifficulties>Hard</ItemDifficulties>
        </ExpeditionAttribute>
        <BuildingUpgrade>
          <WorkforceAmountUpgrade>
            <Value>-30</Value>
            <Percental>1</Percental>
          </WorkforceAmountUpgrade>
        </BuildingUpgrade>
      </Values>
    </Asset>
  </ModOp>
  <!-- END SPECIALIST - Tony Lipus, Citrus tea smasher -->

```

### Add to rewardpool

Adding the specialist to some rewardpools should not be that hard anymore. Pick some you like maybe? We take the following for now:

- 192840 - Specialists - Europe and SA Goods - Legendary
- 193963 - Specialists - Europe and SA Goods - Legendary - Guild
- 193079 - Specialists - Investor Specialists - Legendary

```XML

  <!-- START  ADD TO REWARDPOOL - Tony Lipus, Citrus tea smasher -->
  <ModOp GUID="192840,193963,193079" Type="add" Path="/Values/RewardPool/ItemsPool">
    <Item>
      <ItemLink>1742008803</ItemLink> <!-- SPECIALIST - Tony Lipus, Citrus tea smasher -->
    </Item>
  </ModOp>
  <!-- END ADD TO REWARDPOOL - Tony Lipus, Citrus tea smasher -->

```

### Add to trigger

We will already create our main triggers that we will use for the other assets of this mod.

We know how the triggers work. We just need to define when to trigger the trigger. In our case, we need citrus to be available to make citrus tea. Citrus is one of the Tourist goods that unlocks at a certain amount of tourists. So we can only unlock Citrus Tea when we can actually also make citrus. We unhide everything for Citrus Tea at 750 tourists and unlock everything at 1250 tourists. In this case we do have 2 separate triggers. One for unhide and one for unlock

```XML

  <!-- START TRIGGER -->
  <ModOp Type="addnextSibling" GUID="130248">
    <!--UNHIDE - 750 Tourists -->
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>1742008811</GUID>
          <Name>MOD Trigger</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionPlayerCounter</Template>
            <Values>
              <Condition />
              <ConditionPlayerCounter>
                <PlayerCounter>PopulationByLevel</PlayerCounter>
                <Context>601379</Context> <!-- Tourists -->
                <CounterAmount>750</CounterAmount>
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
                        <Asset>1742000200</Asset> <!-- SPECIALIST - Tony Lipus, Citrus tea smasher -->
                      </Item>
                      </Item>
                    </UnhideAssets>
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
  <ModOp Type="addnextSibling" GUID="130248">
    <!--UNLOCK - 1250 Tourists -->
    <Asset>
      <Template>Trigger</Template>
      <Values>
        <Standard>
          <GUID>1742008812</GUID>
          <Name>MOD Trigger</Name>
        </Standard>
        <Trigger>
          <TriggerCondition>
            <Template>ConditionPlayerCounter</Template>
            <Values>
              <Condition />
              <ConditionPlayerCounter>
                <PlayerCounter>PopulationByLevel</PlayerCounter>
                <Context>601379</Context> <!-- Tourists -->
                <CounterAmount>1250</CounterAmount>
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
                    <UnlockAssets>
                      <Item>
                        <Asset>1742000200</Asset> <!-- SPECIALIST - Tony Lipus, Citrus tea smasher -->
                      </Item>
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
  <!-- END TRIGGER -->

```

Perfect! We now have our specialist ready to use!

## Citrus Tea, the new good

Time to create our new good. We already have the icon for it. The rest is also not that complicated. A good has not that many proporties.

### addNextSibling, Template, GUID, name, description, text

We will be adding this new good to the list of goods right after for example fish (GUID 1010200)

The **template** we use for a new good is &lt;Template>Product&lt;/Template>.

```XML

  <!-- START ADD GOOD - Citrus Tea -->
  <ModOp Type="addNextSibling" GUID='1010200'>
    <Asset>
      <Template>Product</Template>
    </Asset>
  </ModOp>
  <!-- END ADD GOOD - Citrus Tea -->

```

We add the GUID, name, icon and GUID of the description.

```XML

  <!-- START ADD GOOD - Citrus Tea -->
  <ModOp Type="addNextSibling" GUID='1010200'>
    <Asset>
      <Template>Product</Template>
      <Values>
        <Standard>
          <GUID>1742008805</GUID>
          <Name>Citrus Tea</Name>
          <IconFilename>data/modgraphics/icons/citrus-tea.png</IconFilename>
          <InfoDescription>1742008806</InfoDescription>
        </Standard>
      </Values>
    </Asset>
  </ModOp>
  <!-- END ADD GOOD - Citrus Tea -->

```

Then we add the fallback text.

```XML

  <!-- START ADD GOOD - Citrus Tea -->
  <ModOp Type="addNextSibling" GUID='1010200'>
    <Asset>
      <Template>Product</Template>
      <Values>
        <Standard>
          <GUID>1742008805</GUID>
          <Name>Citrus Tea</Name>
          <IconFilename>data/modgraphics/icons/citrus-tea.png</IconFilename>
          <InfoDescription>1742008806</InfoDescription>
        </Standard>
        <Text>
          <LocaText>
            <English>
              <Text>Citrus Tea</Text>
              <Status>Exported</Status>
              <ExportCount>1</ExportCount>
            </English>
          </LocaText>
        </Text>
      </Values>
    </Asset>
  </ModOp>
  <!-- END ADD GOOD - Citrus Tea -->

```

### Product

Next is the important part of the product. It defines the most important proporties of the product.

#### StorageLevel

This can be:

- Building
- Area

Building is used for alle production goods.

Area is used for all "workforce products".

In our case it is a production good so, **building**.

#### ProductCategory

Products are categorised. We have different categories:

- 11702 - Product Category Resource
- 11703 - Product Category Intermediate Good
- 11704 - Product Category Supply Good
- 11705 - Product Category Happiness Good
- 11706 - Product Category Money Good
- 11707 - Product Category Construction Material
- 11708 - Product Category Public Supply
- 11709 - Product Category Public Happiness
- 11710 - Product Category Public Money
- 11710 - Product Category Public Money
- 134777 - Product Category Bus Need
- 135875 - Product Category Commercial Supply

In our case, it is the Product Category Happiness Good (GUID 11705).

#### BasePrice

We define a basprice for our good.

#### CivLevel

This will define on which citizen level the good is used. In our case it will be used for Engineers and Investors. So, CivLevel 4.

#### AssociatedRegion

Define where this good is assosiated with. There are a couple of regions we can choose from:

- Moderate (Old World)
- Colony01 (New World)
- Arctic (Arctic)
- Africa (Enbesa)

We can combine multiple regions. For example for us the citrus comes from the New World and we produce the good in the Old World. So both are associated with our good.

#### ProductionRegions

##### RegionType

Define where this good will be produced. There are a couple of regions we can choose from:

- Moderate (Old World)
- Colony01 (New World)
- Arctic (Arctic)
- Africa (Enbesa)

We can also combine multiple regions. But we only need 1 in this case. It will only be produced in the Old World.

##### RequiredDLCs

Lock the good if the required DLC is not available. We already saw this list before but here it is again:

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

We need in our case the Tourist DLC (GUID 410084).

```XML

<Product>
    <StorageLevel>Building</StorageLevel>
    <ProductCategory>11705</ProductCategory> <!-- Happiness Good -->
    <BasePrice>150</BasePrice>
    <CivLevel>4</CivLevel>
    <AssociatedRegion>Moderate;Colony01</AssociatedRegion>
    <ProductionRegions>
        <Item>
            <RegionType>Moderate</RegionType>
            <RequiredDLCs>
                <Item>
                    <RequiredDLC>410084</RequiredDLC> <!-- Tourist Season -->
                </Item>
            </RequiredDLCs>
        </Item>
    </ProductionRegions>
</Product>

```

### ExpeditionAttribute

Define a base flat amount for morale and a flat amount if you want to add a specific attribute to the good.

We already saw the list but here it is again:

- Crafting
- Diplomacy
- Melee (Force)
- Might (Naval Power)
- Navigation
- Medicine
- Faith
- Hunting

In our case we add 0 base morale but an extra attribute of 20 medicine.

```XML

<ExpeditionAttribute>
    <BaseMorale>0</BaseMorale>
    <ExpeditionAttributes>
        <Item>
            <Attribute>Medicine</Attribute>
            <Amount>20</Amount>
        </Item>
    </ExpeditionAttributes>
</ExpeditionAttribute>

```

If we combine all this we get:

```XML

  <!-- START ADD GOOD - Citrus Tea -->
  <ModOp Type="addNextSibling" GUID='1010200'>
    <Asset>
      <Template>Product</Template>
      <Values>
        <Standard>
          <GUID>1742008805</GUID>
          <Name>Citrus Tea</Name>
          <IconFilename>data/modgraphics/icons/citrus-tea.png</IconFilename>
          <InfoDescription>1742008806</InfoDescription>
        </Standard>
        <Text>
          <LocaText>
            <English>
              <Text>Citrus Tea</Text>
              <Status>Exported</Status>
              <ExportCount>1</ExportCount>
            </English>
          </LocaText>
        </Text>
        <Product>
          <StorageLevel>Building</StorageLevel>
          <ProductCategory>11705</ProductCategory> <!-- Luxury Need -->
          <BasePrice>150</BasePrice>
          <CivLevel>4</CivLevel>
          <AssociatedRegion>Moderate</AssociatedRegion>
          <ProductionRegions>
            <Item>
              <RegionType>Moderate</RegionType>
              <RequiredDLCs>
                <Item>
                  <RequiredDLC>410084</RequiredDLC> <!-- Tourist Season -->
                </Item>
              </RequiredDLCs>
            </Item>
          </ProductionRegions>
        </Product>
        <ExpeditionAttribute>
          <BaseMorale>20</BaseMorale>
          <ExpeditionAttributes>
            <Item>
              <Attribute>Medicine</Attribute>
              <Amount>20</Amount>
            </Item>
          </ExpeditionAttributes>
        </ExpeditionAttribute>
      </Values>
    </Asset>
  </ModOp>
  <!-- END ADD GOOD - Citrus Tea -->

```

WILL UPDATE THIS FURTHER, STAY TUNED!
