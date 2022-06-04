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

We could change the icon in a image editor. For example we made her clothes black because she is working in a mine.

![icon_maria_lopez_v2.png](https://raw.githubusercontent.com/Hier0nimus/modding-guide/patch-1/guides/Get%20started%20with%20modding%20in%20Anno%201800/Tutorial%202%20-%20Making%20new%20specialists/_sources/icon_maria_lopez_v2.png)

## Location of the icon

Put the icon on in the map we already created in our mod structure.  
[Gameplay] Tutorial Specialists/data/graphics/icons

## Time to code! Translations

First we will be creating our translations for this mod. We do this in the translationfiles that can be found on a specific location.  
[Gameplay] Tutorial Specialists/data/config/gui

The translationfiles are created for different languages. The fallback language is English. If you only created the English translation all other languages will see the text also in English.

### Supported languages

There are a lot of languages supported within Anno 1800:
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

The structure of a translationfile starts like most modding files:

```XML
<ModOps>


</ModOps>
```

After that we have again a specific ModOp with a type and path. In this case we will be adding new text exports to the text files.

```XML
<ModOps>
   <ModOp Type="add" Path="/TextExport/Texts">
      
   </ModOp>
</ModOps>
```



## Creating the specialist, Create our assets.xml

Now the real work can start. We create again our assets.xml in the right location:  
[Gameplay] Tutorial Specialists/data/config/export/main/asset/

We start again by creating our opening and closing ModOps tags.

```XML
<ModOps>


</ModOps>
```


