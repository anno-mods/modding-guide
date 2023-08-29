# The LUA API 

Anno 1800 has an internal lua API that it uses to communicate between UI and Game. There were some small scripts added in Season 4, but for the most part, the lua API serves this purpose. 

For us modders however, it offers a scripting engine and data source that the assets simply cannot hope to be. 

## Prerequisites 

### I'm Just taking a look around
- Ability to use a shell
### I want to code scripts for the game
- general Anno 1800 XML modding knowledge
- Knowledge of the lua language: This is not a LUA tutorial. I am assuming a decent level of LUA knowledge for everything that follows. If you don't have that, you should learn lua along with this guide.
- A Text Editor with lua plugin

# The Console

The game offers ingame access to the API with an ingame console. You will need a mod to access it, so you better install one - like the one I wrote and uploaded to [mod.io](https://mod.io/g/anno-1800/m/console), but really any will do. 

We will see how to run and execute scripts without the console later. 

Load into your game and press the keybind to open your console (Which, for the mod linked above is Shift+F1 by default). This will
bring down a console window, from which we can try to get an overview over the API. For the Console, the TAB key will be your best friend as you can autocomplete with it. 

For exiting, run the command `console.toggleVisibility()`  

# API Overview

## TextSources

Arguably most important to get started, under `TextSources.TextSourceRoots`, you find general Game Data Access. It is so important that the devs have even implemented the Shortcut `ts` for it. There are some interesting textsources here:

- Especially for Modders, you wanna look at `ts.Cheat`