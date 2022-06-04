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

* [Gameplay] Tutorial Specialists
    * data
        * config
            * export
                * main
                    * asset
                        * xml file (assets.xml) which contains all the logic for your mod.
            * gui
                * xml files containing the translations for text in every language
                    * texts_english.xml
                    * texts_french.xml
                    * texts_german.xml
                    * …
        * graphics
            * icons
                * Custom graphics we use in our mod as icons for the specialist

## What icon do we use?

For this mod we will start with creating the graphic we need. The icon that will be used for the specialist. The game already has a lot of icons and all those icons are in the gamefiles. We need to extract those icons from the data.rda files. 

The icons can be found in all data.rda files. Depending on which DLC the icons will be from that specific DLC/theme. For example the Arctic icons will be available in the data.rda from the Arctic, data13: The Passage DLC.

The location of the icons we are going to use is data2.rda/data/ui/2kimages/main/3dicons/specialists/systemic. We will be using "icon_worker_602_0.dds". We convert this icon to a png file. We could just use the path of this icon but for best practice we use our own icon to make sure if the default icon is changed by Ubisoft, our mod will still work.

![icon_maria_lopez.png](https://raw.githubusercontent.com/Hier0nimus/modding-guide/patch-1/guides/Get%20started%20with%20modding%20in%20Anno%201800/Tutorial%202%20-%20Making%20new%20specialists/_sources/icon_maria_lopez.png)

**Info:** See the previous tutorial (Tutorial 1 - My first mod) if you do not know how to open rda files and convert dds files to png.

## Changing the icon

We could change the icon in a image editor. For example we make her clothes black because she is working in a mine. The name of our specialist will be **"Maria Lopez"**.

![icon_maria_lopez_v2.png](https://raw.githubusercontent.com/Hier0nimus/modding-guide/patch-1/guides/Get%20started%20with%20modding%20in%20Anno%201800/Tutorial%202%20-%20Making%20new%20specialists/_sources/icon_maria_lopez_v2.png)

## Location of the icon

Put the icon on in the map we already created in our mod structure.  
[Gameplay] Tutorial Specialists/data/graphics/icons

## Time to code! Translations

First we will be creating our translations for this mod. We do this in the translationfiles that can be found on a specific location.  
[Gameplay] Tutorial Specialists/data/config/gui

The translationfiles are created for different languages. The fallback language is English. If you only created the English translation all other languages will see the text also in English.

### Supported languages

There are a lot of languages supported within Anno 1800. Every language file is a xml file with the ModOps structure. We have files for every language. Those files always have the same name and location.

* texts_chinese.xml
* texts_english.xml
* texts_french.xml
* texts_german.xml
* texts_italian.xml
* texts_japanese.xml
* texts_korean.xml
* texts_polish.xml
* texts_russian.xml
* texts_spanish.xml
* texts_taiwanese.xml

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

For this first part of this mod we will be using GUID's 1742008800 (name) and 1742008801 (description).

**Info:** See the previous tutorial (Tutorial 1 - My first mod) if you want to know more about GUID's.

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

* texts_chinese.xml
* texts_french.xml
* texts_german.xml
* texts_italian.xml
* texts_japanese.xml
* texts_korean.xml
* texts_polish.xml
* texts_russian.xml
* texts_spanish.xml
* texts_taiwanese.xml

## Creating the specialist, Create our assets.xml

Now the real work can start. We create again our assets.xml in the right location:  
[Gameplay] Tutorial Specialists/data/config/export/main/asset/

We start again by creating our opening and closing ModOps tags.

```XML
<ModOps>


</ModOps>
```

Next we create our ModOp with our Type. In this case we will again be adding a new asset, but in this case we will do it after a specific already existing item.
The last item in the list of Trade Union items is the item with the GUID 191431. We will add our item right after this item in the code structure.

We declare the GUID where we want to perform the action to in the ModOp and then which action. In this case add our mod as the next sibling of the GUID 191431 (Louis Comfort Tiffany - The Experimental Window Maker).

```XML
<ModOps>
   <ModOp GUID="191431" Type="addNextSibling">
      
   </ModOp>
</ModOps>
```

