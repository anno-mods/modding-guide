# Inheritance 
### Templates/BaseAssetGUID and properties.xml, written by Serp

In properties-toolones.xml we can find all allowed properties, entries and values for xml.  
When you create your own asset, you will always either use a "Template" for it or a "BaseAssetGUID". They both basically work the same way. They define default properties,entries and values for your asset.  Everything you do not define yourself in your asset, will be "inherited" from them. And if something is not defined in them, the default value will be taken from porperties.xml (same default values can also be found in properties-toolone.xml). And if a value has not even a default defined in there, it will default to 0 / empty list as far as I know.  
  
- Lets take a simple example from vanilla game. Skins are a quite simple asset (based on the content of asset):
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <Asset>
    <Template>Skin</Template>
    <Values>
      <Standard>
        <GUID>5244</GUID>
        <Name>CDLC09 Residence Tier02</Name>
        <IconFilename>data/ui/2kimages/main/3dicons/ornaments/cosmetic_dlc09/icon_tier02_oldtown.png</IconFilename>
      </Standard>
      <Skin>
        <SkinName>5246</SkinName>
        <SkinDescription>5247</SkinDescription>
        <SkinVariations>
          <Item>
            <FileName>data/cdlc09/graphics/buildings/residence/residence_tier02_estate01/residence_tier02_estate01.cfg</FileName>
          </Item>
          <Item>
            <FileName>data/cdlc09/graphics/buildings/residence/residence_tier02_estate02/residence_tier02_estate02.cfg</FileName>
          </Item>
          <Item>
            <FileName>data/cdlc09/graphics/buildings/residence/residence_tier02_estate03/residence_tier02_estate03.cfg</FileName>
          </Item>
          <Item>
            <FileName>data/cdlc09/graphics/buildings/residence/residence_tier02_estate04/residence_tier02_estate04.cfg</FileName>
          </Item>
        </SkinVariations>
        <SkinCategoryDescription>5753</SkinCategoryDescription>
      </Skin>
      <Locked>
        <DLCDependency>24965</DLCDependency>
      </Locked>
      <Text />
    </Values>
  </Asset>
  ```

  In template.xml you will find:  
  ```xml
  <Template>
    <Name>Skin</Name>
    <Properties>
      <Standard />
      <Skin />
      <Locked>
        <Scope>Account</Scope>
      </Locked>
      <Text />
    </Properties>
  </Template>
  ```
  </details>
That means your skin will always inherit Standard, Skin,Locked and Text property, even if you do not mention it in your asset (yes that means you can leave them out of your asset to save lines of code, if the inherited values from these entries are fine for you). If you do not mention the Locked/Scope in your asset, it will default to "Account".  
Lets take a closer look as the `<Skin>` property. When you search for `<Name>Skin</Name>` in properties-toolone.xml, you will find one entry (the one with `<Property>` directly in front of it), that tells you what entries are supported for it. You see that it supports the entries: SkinName, SkinDescription, SkinVariations and SkinCategoryDescription. Not mentioning any of these in your asset will default to 0 from properties.xml (or empty list), since they are also not filled in the Template. If in the Template would be written `<SkinName>5</SkinName>`, then this would be inherited instead.

Using BaseAssetGUID instead of Template basically does the same like using a template, but the first inheritance takes place from the GUID you define as BaseAssetGUID. This is very useful if you want to create basically a copy of another asset or a copy with just a few values being different. Then you use the original as BaseAssetGUID and only mention the values you want to be different. The rest will be automatically inherited from the BaseAsset. When using BaseAssetGUID you have to make sure to enter your Asset BELOW the GUID you use as BaseAssetGUID. This is best done by using in your ModOp AddNextSibling with the GUID you want to use as BaseAssetGUID.
- BaseAssetGUID example:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <ModOp Type="addNextSibling" GUID="5244">
    <Asset>
      <BaseAssetGUID>5244</BaseAssetGUID>
      <Values>
        <Standard>
          <GUID>1111111111111</GUID>
          <Name>Copy of CDLC09 Residence Tier02</Name>
        </Standard>
        <Text>
          <TextOverride>5244</TextOverride>
        </Text>
        <Skin>
          <SkinName>54321</SkinName>
          <SkinVariations>
            <Item>
              <FileName>data/cdlc09/graphics/buildings/public/institution_01/institution_colony01_01.cfg</FileName>
            </Item>
          </SkinVariations>
          <SkinCategoryDescription />
        </Skin>
        <Locked />
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>
In this example we are using 5244 as BaseAssetGUID. We did not define the SkinDescription, that means it will be inherited from the BaseAssetGUID, so it will have a value of 5247. But SkinName we defined as 54321, so this will be used instead. Also IconFilename and DLCDependency will be inherited from the BaseAssetGUID.  
I also added `Text/TextOverride=5244` as an easy way to make the asset automatically use the ingame-text of the asset 5244, this way you dont have to define the text for it in `text_english.xml` and so on, which of course only makes sense if you want the new asset use the same text.  
It does not matter if you write `<Locked />` in your Asset or leave it out completely (same for Text which we just removed). Also for entries which directly have a value assigned instead of more entries, like `<SkinCategoryDescription />` it does not matter if you write it that way or leave it out, it will inherit from the BaseAsset (at least according to my tests. Back in 2020 Taube wrote that they behave different, but I can not confirm this, maybe sth. internally changed meanwhile)  
  
### Inheritance of lists
SkinVariations is a "list", called "Vector" in properties-toolone.xml. It can contain multiple entries, usually seperated with `<Item>` entries. Inheritance of these lists works a little bit different. Lists are only fully inherited if you do not fill it with any entry in your Asset. In our example above we filled this list with 1 new entry. That means the complete list got overwritten by our asset and not a single Item/FileName entry from anything else (neither BaseAssetGUID nor template nor properties.xml) will be used. If you would leave it out instead, then it will inherit. If you write `<SkinVariations />` instead, you will again overwrite the complete list in this case with an empty list.  
What to do now if we want to inherit eg. the first and 3rd entry from the list from the BaseAsset?   
- This is done by using VectorElement/InheritedIndex like this:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <ModOp Type="addNextSibling" GUID="5244">
    <Asset>
      <BaseAssetGUID>5244</BaseAssetGUID>
      <Values>
        <Standard>
          <GUID>1111111111111</GUID>
          <Name>Copy of CDLC09 Residence Tier02</Name>
        </Standard>
        <Skin>
          <SkinName>54321</SkinName>
          <SkinVariations>
            <Item>
              <VectorElement>							 
                <InheritedIndex>0</InheritedIndex>
              </VectorElement>
            </Item>
              <FileName>data/cdlc09/graphics/buildings/public/institution_01/institution_colony01_01.cfg</FileName>
            </Item>
            <Item>
              <VectorElement>							 
                <InheritedIndex>2</InheritedIndex>
              </VectorElement>
            </Item>
          </SkinVariations>
          <SkinCategoryDescription />
        </Skin>
        <Locked />
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>
Here we use the structure called "VectorElement" which contains InheritedIndex. The index starts with 0, while this 0 will tell the game to use the first list entry of the first inheritance found, in this case from BaseAsset. All other entries from this list are not inherited.  
In this Skin example a SkinVariations list entry only accepts one entry itself, which is called FileName. But lets assume it would also support sth. called `<TestValue></TestValue>` which is eg. set to value of 5 in your BaseAsset. Then you can inherit a list entry and inheriting TestValue with the same value, while still being able to change the FileName:
  ```xml
  <Item>
    <VectorElement>							 
      <InheritedIndex>2</InheritedIndex>
    </VectorElement>
    <FileName>new.cfg</FileName>
    <TestValue />
  </Item>
  ```
(remember it does not matter if you mention `<TestValue />` here or not, it will be inherited anyway, I just mentioned it for more clarity)


See also the german explanation from Taube back in 2020 here if you want:
https://maug-projekt.com/forum/index.php?thread/715-vererbung-von-vectorelements/
