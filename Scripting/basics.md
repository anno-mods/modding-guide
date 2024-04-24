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


(following added by **Serp**)<br>
Unfortunately no one extracted all those autocomplete commands from the console yet.. so it is a bit tedious to search.<br>
You can also take a look at the (bit outdated) **_textsourcelist.json_** file that is included in the extracted gamefiles path "data\config\http". Roughly ~99% of the things you find here can also be used in lua, starting with "ts."<br>
Eg. there is "ts.Selection.", in the console you can enter this and hit TAB to show all available commands, or you can search for it in textsourcelist.json and will find CSelectionManager (with "Alias" : "Selection"), this "Alias" is what you will use in console/lua usually. Lets use ts.Selection.Object to get the currently from executing player selected object (beware in Coop games this might not be what you expect).<br>
textsourcelist.json tells you that with "Alias" : "Object" will get a "ReturnType" : "CGameObject". So now you can search the file for "CGameObject" to find the table what is included in it. Since you have a selected GameObject now, you will see most  properties here you already now from xml, like "Walking", "Building","Factory" and so on. To find out what values you can fetch from these, again simply search for their ReturnType. You can also get the GUID from the Object with ts.Selection.Object.GUID .<br>
When you compare the autocompletes of the console with the Alias options you will notice that in console many commands will have a "Get" or a "Set" in front, while in file they often don't. Get/Set are usually used when the commands needs "Arguments", also listed in textsourcelist.json, because then you need a function call to provide the arguments. "Get" if for getting a result and "Set" is for changing values, eg. ts.Selection.Object.SetChangeSkin(newSkinIndex). For commands without arguments I think it makes no difference if you do "ts.Selection.Object.GUID" or "ts.Selection.Object.GetGUID()". From textsourcelist.json it is not easily visible if something supports "Set" or not, so here it is best to again take a look at the autocomplete from the console.

# Multiplayer Sync

## General
Most commands, especially the textsource commands, are automatically synced in multiplayer and therefore cause no desync. But it is better to always test your code in Multiplayer!<br>
Since most commands are synced, it is also fine to use math.random() from lua to generate some randomness, as long as it results in commands that are synced.<br>
One command that unfortunately causes desync is for example `condition.changeOwnerOfSelected(25)` which changes the owner of currently selected object to Bente.<br>
While talking of "Selection": Keep in mind that in Multiplayer COOP games the "selection" is not explicit, because one coop player can have sth else selected than the other and doing a synced command on it may result in changing all selections. Same is true for xml `ConditionActiveSession` and the lua commands starting with `session.`, because the human can be active in multiple sessions at once.

## Keybind Commands
In GUID 2001271 KeyBindings you see and can add Keybindings and when this key is hit, execute a lua command like: `<Command>ts.Cheat.GlobalCheats.ToggleSuperShipSpeed()</Command>`.<br>
Commands executed this way are **only** executed for the player who hits the key and the result is in most cases synced.

## ActionExecuteScript
Lua code that is executed via ActionExecuteScript (see also https://github.com/anno-mods/modding-guide/blob/main/Scripting/ExecutingScripts.md#actionexecutescript ) is executed for all human players, regardless who executed this action in the Trigger. Eg. if you credit the player money via `ts.Area.Current.Economy.AddAmount(1010017,100000)` (only works while over an island), every human player will credit himself the money only and then the result is synced, so all humans got more money.<br>
Pro-Hint: You can use this helper mod https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/tree/main#shared-whichplayer-condition to at least make sure to only execute the script for the executing player by checking the unlock before calling the action and within your script with ts.Unlock.GetIsUnlocked(1500001613)
### COOP
Also in Coop a script is executed for each coop player separately and then again synced.<br>
This means a script will be **executed multiple times**!! And unfortunately I found no way to prevent this yet...

### Not synced commands
Commands that are not automatically synced by the game, like `condition.changeOwnerOfSelected(25)` or also `ts.Participants.SetChangeParticipantReputationTo(%i, %i, repchange)` can still be used in MP without causing desync IF all players execute the very same command in the very same gametick hitting the very same objects. Here it comes in handy that "ActionExecuteScript" is executed for all players at once. Although for commands affecting the "selected" object this is still not really practical, since all players also must have the same object selected.. (you can force selectiong and then force previous selection again, but this also only works if everyone is in the same session.. you can force players to enter another session, but this sucks and is still very error prone..)
