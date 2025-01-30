# Get started with modding in Anno 1800

Great! You decided to get into modding for Anno 1800 or thinking about it. Welcome and most importantly, have fun doing it!

In this guide we will try to learn the basic principles of modding by doing. First we will dive a bit into the structure of a mod, what we need to actually make a mod and after that we dive right into it and start creating our own mods step by step. Do not expect to make a complex production chain from the start and be overwhelmed. We will start with a basic mod and work our way up to more complex mods.

## What do we need to know before we start?
At your own risk

### At your own risk

Although they do not punish or disapprove using mods and we even have the ingame mod browser, you can not ask for official help if you have a problem or it breaks your game. If you decide to mod your game / create mods on your own you do this at your own risk.

There are multiple modding communities that will try to help out as much as possible if you encounter some problems with mods or want help with modding. You can reach out to our Anno modding discord if you are interested or looking for help. Always welcome! [https://discord.gg/VdGbJWdXKn](https://discord.gg/VdGbJWdXKn)

### What knowledge do you need before starting?

You do not have to be a programmer or have written code already to be able to create mods. Obviously it makes it a lot easier if you have. We will try to make it as clear as possible.

For creating your own assets like buildings or graphics, it can be interesting if you already have some experience.

In both cases if you do not have the experience, be patient to learn the things step by step. Start with small things and grow.

### What software do you need to start modding?

Depending on the type of mods you want to create, the software you need varies from only a code editor ([Visual Studio Code](https://code.visualstudio.com/), [Notepad++](https://notepad-plus-plus.org/), do not use native windows notepad) to adapt existing features / settings / mechanics in the game, 3D software ([Blender](https://www.blender.org/)) to create your own or adapt existing buildings, image editing software ([Photoshop](https://www.adobe.com/), [Gimp](https://www.gimp.org/), [Paint.net](https://www.getpaint.net/), ) to edit graphics.

We will also need some specific scripts or programs created by the community. We will talk about those when we are at that point in the modding process.

### You already know how to add mods to the game

When creating mods we expect you do know how to add mods to your game. If not, read more about it at the [Anno Union website](https://www.anno-union.com/mods/).

## Let’s get started with our first mod!

For our first mod we will combine the basic setup of creating a mod and what you need with actually creating a mod that you can use in the game.

### What are we going to make?

We all know our beloved Feras Alsarami, the Persuader. The item we put into trade unions to boost the productivity of production buildings by 50%. But what if we could change that to 420%? That would unbalance this item of course and make it even more powerful, but it is a good first test for creating a mod. So, how do we start? What files do we need to create? Where do we put those files?

### How is the game structured

If we have a look at the Anno 1800 folder that is installed on your computer we can see a list of folders. We need 2 folders of this list.

- maindata
- mods

#### mods

This folder should already exist and contains all the mods you want to be loaded when starting the game if you manually install mods. If this folder is not there, make sure to create it. 

If you only installed mods via the ingame mod browser, this location will probably also not be created, because those mods are stored on a different location. For testing and adding our own mods manually we use this location in the installation directory to easily manage our mods. Both work together alongside eachother. Mods from both locations will be loaded together.

#### maindata

The maindata folder contains a list of .rda files. Those files are packages of all the gamefiles. Those contain graphics, buildings, files that describe logic in the game, goods, ect.

We have data0.rda > data33.rda. Every data file is a reference to the basegame or a specific DLC or big game update. The data33.rda is the last one at the moment which contains all the files for “End Of An Era” CDLC and the last game update.

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
- data20: Pedestrian Zone Pack CDLC
- data21: Eden Burning Scenario
- data22: Seeds of Change DLC
- data23: Industrial Zone Pack CDLC
- data24: Empire of the Skies DLC
- data25: New World Rising DLC
- data26: Dragon Garden Pack CDLC
- data27: Old Town Pack CDLC
- data28: Fiesta Pack CDLC
- data29: National Park Pack CDLC
- data30: Eldritch Pack CDLC
- data31: Steampunk Pack CDLC
- data32: Pirate Cove Pack CDLC
- data33: End Of An Era CDLC

### Why do we need to know this?

All the gamefiles are inside those packages. If we want to reuse, adapt or look for references inside those files we need access to those files. For example, if we want to reuse some icons from items or goods we need access to those png files.

Another big use case is a file we use constantly to search for references of assets in the game. This is the **assets.xml**. You could say this is the most important file (or at least a really important file) in the game for modders. It contains so much logic and game info. When modding, one of the things we do is actually manipulate this file by creating our own assets.xml and merge the two together.

### How to open the rda files?

To open the .rda files, we need a tool. This can be done in different ways. Choose one of the underneath tools and follow the steps described on the github page.

**ATTENTION:** Make sure not to extract to your main game folder and make sure not to overwrite any of the game files! Your game could potentially break in that case. Also close the game before extracting or manipulating the .rda files.

The two tools do the same thing in a different way, unpack the .rda files and make it possible to look what is inside. Big thank you to the work of the creators of those tools!

- RDAExplorer from lysannschlegel - [https://github.com/lysannschlegel/RDAExplorer](https://github.com/lysannschlegel/RDAExplorer)
- RDAExplorer from lukts30 - [https://github.com/lukts30/RDAExplorer](https://github.com/lukts30/RDAExplorer) - [Video how to use](https://www.youtube.com/watch?v=bKWnfvLeyxs&ab_channel=Lukas)

### Extract the assets.xml file

The “assets.xml” file can be found in almost every .rda package. It contains the important game data and is always updated with every game update. So, the assets.xml file you find in the data33.rda will contain the latest version and is the one we need. So make sure to extract this file from the data33.xml. It is situated: **data/config/export/main/asset/assets.xml**.

Open the assets.xml file with a code editor of your choice. Important to know is that this file is really big (280mb+). Some basic code editors can not handle those large files. Code highlighting for example will almost certainly be disabled for those large files. Otherwise the code editor would crash.

### First impressions of the assets.xml

If we have a look at the assets.xml, people with coding experience will recognise the structure. It is an xml file and so, has opening and closing tags. If you scroll through it, you will recognise some references from the game and by reading you will understand how some things are coded just by looking at the tags.

For people without coding experience this will be harder to understand. You can imagine this structure as a house. The house is the game itself. The house has different rooms which have their own furniture. That furniture can store other goods/boxes which again can store other goods that again store… And so on.

Everything on one of the levels we just mentioned also has its own properties. For example, the closet in the living room is not the same closet as the one from the bedroom. The one in the living room is made out of steel, the one in the bedroom is made out of wood. Those are different properties and must be described in text. Also, the one in the bedroom contains clothes, the one in the living room contains books. In coding we call this structure “nesting”.

When creating a new object/thing, whatever it is, we start with an “opening tag”. For example &lt;Asset>. Tags are wrapped inside “&lt;>” Everything from this point is nested inside this “&lt;Asset>”, until we say we want to end this object/thing. We end this by closing this with the “closing tag”, in this case ”&lt;/Asset>”. The same name but before the name we put a “/”.

As you can see in the file the whole structure is created like this. The most important thing to know is that every aspect in the game is in some way structured like this and described in text. A lot can be found in this assets.xml. Feel free to scroll through it and try to understand what some things maybe could do.

## The structure of an Anno 1800 mod

We now have the most important things to actually start creating our mod. We will be writing our own code in a second. Let’s start by creating our mod folder structure that we need, to make sure the mod is loaded correctly when we add it to the mods folder in the main game folder.

### Folder structure

If we have a look at the folderstructure of any Anno 1800 mod, we will see this is the same for all mods.

- Name of the mod
  - modinfo.json
  - data
    - config
      - export
        - main
          - asset
            - assets.xml which contains all the logic for your mod. This is the file we will be using the most.
      - gui
        - xml files containing the translations for text in every language
          - texts_english.xml
          - texts_french.xml
          - texts_german.xml
          - …
    - graphics
      - buildings
        - specific folder or multiple folders of buildings we use in the mod containing the building specific files
      - props
        - specific folder or multiple folders of props we use in the mod containing the prop specific files
      - icons
        - Custom graphics we use in our mod

The **data and config folder and all folders and files that are inside this folder** need to be exactly the same.

For the graphics folder you can have your own structure but keeping the same structure as the game is a good practice. Most of the modders keep the same structure to keep it clean.

Some modders also add some more custom folder structure, but for the sake of this basic tutorial we stick with the current structure.

### Create our folder structure

Create a mod folder on the location of your choosing with the same structure as we mentioned above. We will start using our Feras Alsarami, the Persuader case from this point. For the name of this mod I add [Gameplay] to the front as a category. This is not needed but can help to categorize your mods.

Because this is a basic mod where we will just be adapting 1 value, we do not need all the folders as we mentioned above. We will not be adding new graphics or translations, so we do not need those folders/files.

Our folder structure should look like this:

- [Gameplay] Feras Alsarami - The Better Persuader
  - data
    - config
      - export
        - main
          - asset

### Create our own assets.xml

In the asset folder create an assets.xml file with your code editor. This file can be empty for now. We will start adding code in the next step.

We now created our own assets.xml that will be merged with the assets.xml from the game. This will be done when the game is launched and is managed by the modloader.

### Writing your first code, hello Feras

The first code we need to write are the tags that make it clear everything in this file is a mod. We follow guidelines that are the same for every mod. So the modloader can actually do their job and merge the code we wrote with the existing assets.xml.

```XML
<ModOps>


</ModOps>
```

We have the opening tag &lt;ModOps> and immediately also create the closing tag &lt;/ModOps>. It is a good practice to immediately create the closing tag. That way you will not forget. A lot of the time errors are triggered because of tags that are not closed. Everything we now put inside those tags is included in the mod.

`ModOps` stands for **Mod Operations**. It includes all mod operations inside this parent node.

```XML
<ModOps>
  <ModOp>

  </ModOp>
</ModOps>
```

We first create a &lt;ModOp> within the &lt;ModOps>. This is the wrapper for our first mod operation. Now we need to make it clear what we want to do in this mod.

```XML
<ModOps>
  <ModOp Type="replace">

  </ModOp>
</ModOps>
```

This mod is from the **Type=”replace”**. We will be replacing an existing value with a new value.

Other operations that we can do are **"add"**, **"addNextSibling"**, **"addPrevSibling"**, **"merge"** and **"remove"**. We will touch on those when we need them in one of the next tutorials.

We now have to decide what we want to replace. Well, we actually already know what but more importantly how.

#### GUID

```XML
<ModOps>
  <ModOp Type="replace" GUID='192450'>

  </ModOp>
</ModOps>
```

Everything in the game has a GUID, it is a unique identifier that represents an asset. This can be a building, a trade union item, a fertility, ect. In our case we need the GUID of Feras, because we want to change something about him. Above you can see `192450`, but how did I know that? How can we search for this?

Say hello to a1800.net! Go to [https://a1800.net/](https://a1800.net/).

![a1800.net homepage](https://image.modcdn.io/members/315f/23806477/profilea1800net/screenshot2025-01-15235447.png)

In the search field you can type whatever asset you want to know the GUID for. In case you can not find it with the left search field, you can also use the text search on the right.

![a1800.net search Feras](https://image.modcdn.io/members/315f/23806477/profile/screenshot2025-01-15235654.png)

In our case we searched for **“feras”** and got 2 results with one being a GuildhouseIten and one being Text. The one we need is the GuildhouseItem.

We see in front of this result the field GUID, with the value `192450`.

Big thank you to this amazing tool! It makes our work a lot easier.

```XML
<ModOps>
  <ModOp Type="replace" GUID='192450' Path="/Values/FactoryUpgrade/ProductivityUpgrade/Value">
    <Value>420</Value>
  </ModOp>
</ModOps>
```

We now have the type of action we want to do (Replace) we have the right GUID of the object we want to change, and last we need the correct path to the nested property of the chosen object where the productivity boost is defined. And this is where the original assets.xml from the game could come in, but we also have the a1800.net website. If we click through on the result of feras, we also get the overview of the asset of Feras.

![a1800.net search Feras 2](https://image.modcdn.io/members/315f/23806477/profile/screenshot2025-01-16220326.png)

The asset is opened in the **DATA view**. We also have an **XML view**. Depending on preferences, you can use both views.

At the top we see the **GUID** and the **template** of the Asset, **"GuildhouseItem"**. The **template** is the parent type of the asset and defines what type of asset this is. The parent contains basic properties that are taken over by the asset.

Under this information we have a list of **References**. Those are all other assets where the asset of Feras is used. We are not going deeper into that for now.

I personally like the XML view because I like that nested structure and it shows how everything is structured..

```XML
<Asset>
    <Template>GuildhouseItem</Template>
    <Values>
        <Standard>
            <GUID>192450</GUID>
            <Name>Feras Alsarami</Name>
            <IconFilename>data/ui/2kimages/main/3dicons/specialists/influencer/icon_influencer_realferas_2.png</IconFilename>
            <InfoDescription>21354</InfoDescription>
        </Standard>
        <Text>
            <LocaText>
                <English>
                    <Text>Feras Alsarami the Persuader</Text>
                    <Status>Exported</Status>
                    <ExportCount>1</ExportCount>
                </English>
            </LocaText>
            <LineID>29139</LineID>
        </Text>
        <Item>
            <MaxStackSize>1</MaxStackSize>
            <Rarity>Epic</Rarity>
            <ItemType>Specialist</ItemType>
            <TradePrice>289400</TradePrice>
            <TradePriceOnlineCurrency>50</TradePriceOnlineCurrency>
        </Item>
        <FactoryUpgrade>
            <ProductivityUpgrade>
                <Value>50</Value>
                <Percental>1</Percental>
            </ProductivityUpgrade>
        </FactoryUpgrade>
        <ItemEffect>
            <EffectTargets>
                <Item>
                    <GUID>193856</GUID>
                </Item>
            </EffectTargets>
        </ItemEffect>
       ...
    </Values>
</Asset>
```

We see the corresponding GUID at almost the top of the &lt;Asset> opening tag in the &lt;Standard> tag. This is another check to see if we are at the right location and we check this GUID with our ModOp that we created.

Now how do we know where the production boost is coded? This is a matter of knowledge and understanding the code. If we go through the code within this &lt;Asset> we can see a lot of different tags which all have their own function. At some point you will see <FactoryUpgrade>, and nested in this &lt;ProductivityUpgrade> and nested in that the &lt;Value> of 50.

Why do we not just change the value in the extracted assets.xml and save this file you say? Well, because the main assets.xml we extracted is not part of the code that is loaded. The game loads all the .rda files not the things we have extracted from it. We can not update code in those .rda files, so we need to manipulate those files in a different way, by creating our own assets.xml file and merge those at the start of the game. This is what the modloader does.

So, Now that we have the correct location of what we want to change we can determine the path we need to use in our assets.xml where we do the replace.

Within the <Asset> we go down to `/Values/FactoryUpgrade/ProductivityUpgrade/Value`. Then the path we want to replace we repeat again and add the new value we want to use, in our case 420.

```XML
<ModOps>
  <ModOp Type="replace" GUID='192450' Path="/Values/FactoryUpgrade/ProductivityUpgrade/Value">
    <Value>420</Value>
  </ModOp>
</ModOps>
```
If we go over the code we have now, we have the following:

- We have an opening tag at the beginning that defines this xml file contains Mod Operations (`<ModOps>`).
- We closed this tag at the end of the file, so everything inbetween those tags is in our Mod.
- We created a Mod Operation (`<ModOp>`) within where we defined our different parts that define what we do, where we do it and how we do it
- We added the "Type" where we say what type of action this mod operation is. In our case we are going to replace a value, so it is from the type replace.
- We added the GUID of the asset where we want want to do the replace action, being the GUID of Feras, `192450`
- Because the productivity value that we want to change is in a specific location in this asset, we need to define the path to this location. We did this by going from the top of our asset down to the specific location of the productivity value, creating the path.
- Once we all had done this, we add the piece of code that we want to use for the action. In our case, we replace the <Value> node with the new node.

### Comments

```XML
<ModOps>
  <!-- START CHANGE  Feras Alsarami, the better Persuader -->
  <ModOp Type="replace" GUID='192450' Path="/Values/FactoryUpgrade/ProductivityUpgrade/Value">
    <Value>420</Value>
  </ModOp>
  <!-- END CHANGE  Feras Alsarami, the better Persuader -->
</ModOps>
```

It can be a good practice to add comments to your code. That way when people open your mod they can get more info or even for yourself. If the file structure is getting really long some extra comments can save a lot of time to make things clear for yourself.

Adding comments in an XML file can be done by starting with `<!--` then you place the text you want as somment and then close the comment with `-->`, as you can also see above.

We are now almost done with our first mod! Save this file again.

### modinfo.json

An additional step introduced with the mod.io platform is the addition of the modinfo.json file.

If we go back to the complete structure of a mod, you will see that we create this file in the rootfolder of our mod. next to the data folder.

Create a new file, name it modinfo.json and save this file in the right location in your modfolder.

#### What does this do?

This file is a technical sheet of your mod. It contains the technical information that is used by the modloader to understand your mod and behaviour and relation with other mods.

We will not go to deep into this file for now. We will only use a simplified version for this mod. But know that this could also have information regarding compatibility with other mods, load order with other mods, DLC dependancy information, ect. If you want to learn more about it, you can have a look on the modding github of the community: [https://github.com/anno-mods/Modinfo](https://github.com/anno-mods/Modinfo)


```XML
{
  "Version": "1.0",
  "ModID": "feras_the_better_persuader",
  "Category": {
    "Chinese": null,
    "English": "[Gameplay]",
    "French": null,
    "German": null,
    "Italian": null,
    "Korean": null,
    "Polish": null,
    "Russian": null,
    "Spanish": null,
    "Taiwanese": null
  },
  "ModName": {
    "Chinese": null,
    "English": "Feras Alsarami, the better Persuader",
    "French": null,
    "German": null,
    "Italian": null,
    "Korean": null,
    "Polish": null,
    "Russian": null,
    "Spanish": null,
    "Taiwanese": null
  },
  "Description": {
    "Chinese": null,
    "English": "Let us make Feras even more crazy then he already is!",
    "French": null,
    "German": null,
    "Italian": null,
    "Korean": null,
    "Polish": null,
    "Russian": null,
    "Spanish": null,
    "Taiwanese": null
  },
  "CreatorName": "My name"
}
```

The above mentioned fields I would advice to always use, and if possible also include the different languages if you can. If you only want to use English or another languages you can actually remove all the other languages.

```XML
{
  "Version": "1.0",
  "ModID": "feras_the_better_persuader",
  "Category": {
    "English": "[Gameplay]"
  },
  "ModName": {
    "English": "Feras Alsarami, the better Persuader"
  },
  "Description": {
    "English": "Let us make Feras even more crazy then he already is!"
  },
  "CreatorName": "My name"
}
```

Save this file and we are done with creating files!

The last step is to place your mod folder inside the “mods” folder in the main game directory.

Start the game and load one of your savegames. Look at Feras and see the 420% production boost instead of 50%.

![feras-420.jpg](https://image.modcdn.io/members/315f/23806477/profile/screenshot2025-01-16224049.png)

Congratulations! You have succesfully created your first mod!

Ready for the next one? For now you can have a look at [https://github.com/anno-mods/modding-guide](https://github.com/anno-mods/modding-guide) where you can find the next tutorials. I'm currently reworking all the tutorials and transferring them also here on the mod.io platform. Have fun and enjoy your Anno modding journey!