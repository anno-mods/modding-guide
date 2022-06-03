# Get started with modding in Anno 1800

Great! You decided to get into modding for Anno 1800 or thinking about it. Welcome and most importantly, have fun doing it! 

In this guide we will try to learn the basic principles of modding by doing. First we will dive a bit into the structure of a mod, what we need to actually make a mod and after that we dive right into it and start creating our own mods step by step. Do not expect to make a complex production chain from the start and be overwhelmed. We will start with a basic mod and work our way up to more complex mods.

## What do we need to know before we start?

### At your own risk

Modding is not officially supported by Ubisoft. Although they do not punish or disapprove using mods, you can not ask for official help if you have a problem or it breaks your game. If you decide to mod your game / create mods on your own you do this at your own risk.

### What knowledge do you need before starting?

You do not have to be a programmer or have written code already to be able to create mods. Obviously it makes it a lot easier if you have. We will try to make it as clear as possible.

For creating your own assets like buildings or graphics, it can be interesting if you already have some experience.

In both cases if you do not have the experience, be patient to learn the things step by step. Start with small things and grow.

### What software do you need to start modding?

Depending on the type of mods you want to create, the software you need varies from only a code editor ([Visual Studio Code](https://code.visualstudio.com/), [Notepad++](https://notepad-plus-plus.org/), [Atom](https://atom.io/), do not ever use native windows notepad) to adapt existing features / settings / mechanics in the game, 3D software ([Blender](https://www.blender.org/)) to create your own or adapt existing buildings, image editing software ([Photoshop](https://www.adobe.com/), [Gimp](https://www.gimp.org/), [Paint.net](https://www.getpaint.net/), ) to edit graphics.

We will also need some specific scripts or programs created by the community. We will talk about those when we are at that point in the modding process.

### You already know how to add mods to the game

When creating mods we expect you do know how to add mods to your game. If not, [watch this video](https://www.youtube.com/watch?v=up8LpxtLZwA&ab_channel=Takarazuka).

## Let’s get started with our first mod!

For our first mod we will combine the basic setup of creating a mod and what you need with actually creating a mod that you can use in the game.

### What are we going to make?

We all know our beloved Feras Alsarami, the Persuader. The item we put into trade unions to boost the productivity of production buildings with 50%. But what if we could change that to 420%? That would unbalance this item of course and make it even more powerful, but it is a good first test for creating a mod. So, how do we start? What files do we need to create? Where do we put those files?

### How is the game structured

If we have a look at the Anno 1800 folder that is installed on your computer we can see a list of folders. We need 2 folders of this list.
* maindata
* mods

#### mods

This folder should already exist and contains all the mods you want to be loaded when starting the game. If this folder is not there, make sure to create it, install the modloader and more importantly make sure you know how to add mods to the game before actually creating your own. [Watch this video](https://www.youtube.com/watch?v=up8LpxtLZwA&ab_channel=Takarazuka) for more info about how to add mods to the game.

#### maindata

The maindata folder contains a list of .rda files. Those files are packages of all the gamefiles. Those contain graphics, buildings, files that describe logic in the game, goods, ect. 

We have data0.rda > data22.rda. Every data file is a reference to the basegame or a specific DLC or big game update. In the future more files will be added when more updates will be released. The data22.rda is the last one at the moment which contains all the files for “Seeds of Change” DLC and the last game update.
* data2:  contains for example all icons of items, images from the basegame
* data8: contains for example all building assets from the basegame
* data10: The Anarchist DLC
* data11: Sunken Treasures DLC
* data12: Botanica DLC
* data13: The Passage DLC
* data14: Seat Of Power DLC
* data15: Bright Harvest DLC
* data16: Land Of Lions DLC
* data17: Docklands DLC
* data18: Tourist Season DLC
* data19: The High Life DLC
* data21: Eden Burning Scenario
* data22: Seeds of Change DLC

### Why do we need to know this?

All the gamefiles are inside those packages. If we want to reuse, adapt or look for references inside those files we need access to those files. For example, if we want to reuse some icons from items or goods we need access to those png files.

Another big use case is a file we use constantly to search for references of assets in the game. This is the **assets.xml**. You could say this is the most important file (or at least a really important file) in the game for modders. It contains so much logic and game info. When modding, one of the things we do is actually manipulate this file by creating our own assets.xml and merge the two together.

### How to open the rda packages?

To open the .rda files, we need a tool. This can be done in different ways. Choose one of the underneath tools and follow the steps described on the github page. 

**ATTENTION:** Make sure not to extract to your main game folder and make sure not to overwrite any of the game files! Your game could potentially break in that case. Also close the game before extracting or manipulating the .rda files.

The two tools do the same thing in a different way, unpack the .rda files and make it possible to look what is inside. Big thank you to the work of the creators of those tools!
* RDAExplorer from lysannschlegel - [https://github.com/lysannschlegel/RDAExplorer](https://github.com/lysannschlegel/RDAExplorer)
* RDAExplorer from lukts30 - [https://github.com/lukts30/RDAExplorer](https://github.com/lukts30/RDAExplorer) - [Video how to use](https://www.youtube.com/watch?v=bKWnfvLeyxs&ab_channel=Lukas) 

### Extract the assets.xml file

The “assets.xml” file can be found in almost every .rda package. It contains the important game data and is always updated with every game update. So, the assets.xml file you find in the data22.rda will contain the latest version and is the one we need. So make sure to extract this file from the data22.xml. It is situated: data/config/export/main/asset/assets.xml.

In the future when more game updates will be available make sure to take the rda data file with the highest number.

Open the assets.xml file with a code editor of your choice. Important to know is that this file is really big (180mb+). Some basic code editors can not handle those large files. Code highlighting for example will almost certainly be disabled for those large files. Otherwise the code editor would crash.

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

* Name of the mod
    * data
        * config
            * export
                * main
                    * asset
                        * xml file (assets.xml) which contains all the logic for your mod. This is the file we will be using the most.
            * gui
                * xml files containing the translations for text in every language
                    * texts_english.xml
                    * texts_french.xml
                    * texts_german.xml
                    * …
        * graphics
            * buildings
                * specific folder or multiple folders of buildings we use in the mod containing the building specific files
            * props
                * specific folder or multiple folders of props we use in the mod containing the prop specific files
            * icons
                * Custom graphics we use in our mod

The **config folder** and all folders and files that are inside this folder need to be exactly the same. 

For the graphics folder you can have your own structure but keeping the same structure as the game is a good practice. Most of the modders keep the same structure to keep it clean.

### Create our folder structure

Create a mod folder on the location of your choosing with the same structure as we mentioned above. We will start using our Feras Alsarami, the Persuader case from this point. For the name of this mod I add [Gameplay] to the front as a category. This is not needed but can help to categorize your mods. 

Because this is a basic mod where we will just be adapting 1 value, we do not need all the folders as we mentioned above. We will not be adding new graphics or translations, so we do not need those folders/files.

Our folder structure should look like this:

* [Gameplay] Feras Alsarami - The Better Persuader
    * data
        * config
            * export
                * main
                    * asset

### Create our own assets.xml

in the asset folder create an assets.xml file with your code editor. This file can be empty for now. We will start adding code in the next step.

We now created our own assets.xml that will be merged with the assets.xml from the game. This will be done when the game is launched and is managed by the modloader. 

### Writing your first code, hello Feras

The first code we need to write are the tags that make it clear everything in this file is a mod. We follow guidelines that are the same for every mod. So the modloader can actually do his/her job and merge the code we wrote with the existing assets.xml. 

```
<ModOps>


</ModOps>
```

We have the opening tag &lt;ModOps> and immediately also create the closing tag &lt;/ModOps>. It is a good practice to immediately create the closing tag. That way you will not forget. A lot of the time errors are triggered because of tags that are not closed. Everything we now put inside those tags is included in the mod.

```
<ModOps>
  <ModOp>

  </ModOp>
</ModOps>
```

We first create a &lt;ModOp> within the &lt;ModOps>. This is the wrapper for our first mod. Now we need to make it clear what we want to do in this mod.

```
<ModOps>
  <ModOp Type="replace">

  </ModOp>
</ModOps>
```

This mod is from the Type=”replace”. We will be replacing an existing value with a new value. We now have to decide what we want to replace. Well, we actually already know what but more importantly how.

#### GUID

```
<ModOps>
  <ModOp Type="replace" GUID='192450'>

  </ModOp>
</ModOps>
```

Everything in the game has a GUID, it is a unique identifier that represents an asset. This can be a building, a trade union item, a fertility, ect. In our case we need the GUID of Feras, because we want to change something about him. Above you can see “192450”, but how did I know that? How can we search for this?

Say hello to schwubbe.de! Go to [https://schwubbe.de/modding_blog.php](https://schwubbe.de/modding_blog.php), and scroll down until you see “Search for locas”.

In this field you can type whatever asset you want to know the GUID for. So, in our case we searched for “Feras Alsarami, the Persuader” and got the GUID “192450”. \
Big thank you to this amazing tool! It makes our work a lot easier.

```
<ModOps>
  <ModOp Type="replace" GUID='192450' Path="/Values/FactoryUpgrade/ProductivityUpgrade/Value">
    <Value>420</Value>
  </ModOp>
</ModOps>
```

We now have the type of action we want to do (Replace) we have the right GUID of the object we want to change, and last we need the correct path to the nested property of the chosen object. And this is where the original assets.xml from the game comes in.

Open the original assets.xml from the game and search for “192450”. At the moment of writing this tutorial, the GUID of Feras can be found 7 times in the original assets.xml. Now, how do we know we are looking at the right place?

The first time we encounter this GUID in the file, it is nested inside an &lt;Item> tag, which is nested inside &lt;AssetList> which is nested inside &lt;AssetPool> which is nested inside a main &lt;Asset>. 

In this main &lt;Asset> we see another GUID and underneath the &lt;Name> “Items Artisans 3.2 EPIC UNLOCK”. 

If we process this, we understand that this is not where we get all the info about Feras. This is another object called “Items Artisans 3.2 EPIC UNLOCK” with the GUID “130172” and this contains a list of all the items for Artisans 3.2 EPIC. So we need to go to the next reference of our GUID of Feras and this time we should be at the right place.

We see the corresponding GUID at almost the top of the &lt;Asset> opening tag in the &lt;Standard> tag.

We see &lt;Template>GuildhouseItem&lt;/Template> which means that this object is a Trade Union item. Also the name. So all those things show us that we are at the right place.

Now how do we know where the production boost is coded? This is a matter of knowledge and understanding the code. If we go through the code within this &lt;Asset> we can see a lot of different tags which all have their own function. At some point you will see &lt;FactoryUpgrade>, and nested in this &lt;ProductivityUpgrade> and nested in that the &lt;Value> of 50. 

Why do we not just change the value here and save this file you say? Well, because the main assets.xml we extracted is not part of the code that is loaded. The game loads all the .rda files not the things we have extracted from it. We can not update code in those .rda files, so we need to manipulate those files in a different way, by creating our own assets.xml file and merge those at the start of the game. This is what the modloader does.

So, Now that we have the correct location of what we want to change we can determine the path we need to use in our assets.xml where we do the replace.

Within the &lt;Asset> we go down to /Values/FactoryUpgrade/ProductivityUpgrade/Value. Then the path we want to replace we repeat again and add the new value we want to use, in our case 420.

```
<ModOps>
  <ModOp Type="replace" GUID='192450' Path="/Values/FactoryUpgrade/ProductivityUpgrade/Value">
    <Value>420</Value>
  </ModOp>
</ModOps>
```

### Comments

```
<ModOps>
  <!-- START CHANGE  Feras Alsarami, the better Persuader -->
  <ModOp Type="replace" GUID='192450' Path="/Values/FactoryUpgrade/ProductivityUpgrade/Value">
    <Value>420</Value>
  </ModOp>
  <!-- END CHANGE  Feras Alsarami, the better Persuader -->
</ModOps>
```

It can be a good practice to add comments to your code. That way when people open your mod they can get more info or even for yourself. If the file structure is getting really long some extra comments can save a lot of time to make things clear for yourself.

We are now done with our first mod! Save this file again.

The last step is to place the mod folder inside the “mods” folder in the main game directory.

Start the game and load one of your savegames. Look at Feras and see the 420% production boost instead of 50%.
