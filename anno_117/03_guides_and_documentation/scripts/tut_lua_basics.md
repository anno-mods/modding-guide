This Tutorial for scripting is partially based on the [script-testing](https://github.com/03szust/script-testing) mod and makes a few references to it. 

I will try and update this once the game comes out but the version in my own repo will probably be more up to date.

# How to Lua Script in Anno 117

## 1: General Lua
[Lua](https://www.lua.org/pil/contents.html) is a programming language that is mostly used to expand already existing software to make it more customizable and this is also how it is used for mods in Anno. 
Writing Lua scripts is relatively easy as long as you already know how to write code. While the syntax is a bit different to any other language, the structure is comparable to C(++), Java, Python, or any other procedural programming language. This means code is written as a list of instructions that are called after another.
- Variables:
    Variables can be most things, but usually they are either a number, a piece of text (string), a boolean (true or false), a table (a list of other variables), a pointer (more about those later), or nil (nothing). They are what you operate on. Generally speaking what your script will do is get a varibale and then change it.
    Variables must be declared before the first time you want to use them and they can be declared as either `global`or `local`. Local variables are only usable in the file you are writing your script in, while global variables are available to Lua scripts in other files as well. Unless you are doing something complex you probably won't be using global variables though.
    This is how you declare variables. Try to choose good names for your variables so that you remember what they are used for.
    `local myVar1 = 42`
    `global myVar2 = "Text"`
    Furthermore, Lua is dynamically typed. This results in two things: First of all, if you have a variable that is a  number and you set it to a string, it will just do that. Second, you can treat numbers as strings and strings as numbers if you want to. This isn't always perfect but it can be useful sometimes.
    Finally pointers: They are a bit different and hugely important to any script you will write for Anno. Pointers aren't numbers or text but are essentially adresses to the place where something is stored in the memory. And to interact with the game in any meaningful way, you will have to first get a pointer and then do something with what is at that location. But more about that in the struct section.
- Functions:
    Functions are lists of instructions that you can call in another place, be that in your Lua script or via the Game. Usually if you want to execute code at any point in the game it has to be in a function that you can call.
    This is what a function looks like. Try to choose function names (in this case Main) in a useful way.
    ```
    function foo(MyVar1)
        MyVar1 = MyVar1 + 1
        print(MyVar1)
        return MyVar1
    end
    ```
- Conditional Statements (`if`-`then`-`else`):
    Conditional statements determine wheter you want to execute the following code or not. They follow the basic structure of if something is true, then do this and optionally, else do that.
    This looks like this:
    ```
    if MyVar1 == 42 then
        print(MyVar1)
    else
        print(MyVar2)
    end
    ```
    Conditional Statements use relational and logical operators to compare things. These are `>, <, >=, <=, ==, ~=, and, or, not`.
    Furthermore you can use elseif to add more ways to differentiate what you want to do.
- Loops (`for` and `while`):
    Sometimes you want a certain thing to be done multiple times. For this we use loops. The two most useful Loops are `for` and `while`.
    A `while` loop needs a exectutes it's content until a condition is no longer true.
    A `while` loop looks like this:
    ```
    local i = 0
    while i <= 10 do
        i = i + 1
        print(MyVar1)
    end
    ```
    This example loop prints MyVar1 10 times.

    Meanwhile `for` loops already include that addition and looks like this:
    ```
    for i = 0, 10, 1 do
        print(MyVar1)
    end
    ```
    This does exactly the same as the example `while` loop.

    `while` loops are usually used when a condition changes at an unknown point in the repetition, while `for`loops are usually used when you want to do a thing to every entry in a table. To iterate through tables, the for loop can be changed just take a table and go through it. this looks like this:
    ```
    for i,v in pairs(k) do
        print(v)
    end
    ```
    This loop takes a table k and the prints every entry. Note that entries in tables come as pairs, the first entry designating the location in the table and the second one being the content.
    Also note that tables are sometimes called arrays, even in official Lua documentation, even though in syntax they are usually named table. 

- Classes
    Variables do not have to come alone, they can also come in classes. Classes are essentially collections of variables that you want to tread as a group, mostly because they belong together in some way. Usually, when you get a pointer, this is what is behind it. This tutorial won't teach you how to make them but only how to use them. Usually when you get a pointer, that pointer has a class associated with it. If you now want to manipulate a variable of that class, this is how you do it:
    ```
    local MyObj = Ptr
    MyObj.MyVar1 = 42
    ```
    In general expect everything you get from the game in some way to be a pointer with a class behind it. such a thing is called an object (and it's where the name object oriented programming comes from).

## Lua in Anno 117
Anno 117 uses [Luau](https://luau.org/), a version of Lua that is most famous for being used in Roblox, so any tutorial or documentation that applies to Roblox will probably apply to Anno 117 as well.
To actually mod the game though we have to interact with it first. This has to be split into two sections. first, how to get our script to be executed and then second, how to do write code that actually does something ingame.
### Executing Code
There are five ways to execute Code within Anno 117: Init, Load, Tick, Trigger and Unload. To have scripts executed at Init, Load, Tick or Unload you have to tell the game to do so in the `modinfo.json`[here](https://github.com/03szust/script-testing/blob/main/modinfo.json). Check the one for this mod to see what that looks like. To have scripts executed at a Trigger you have to write some XML code as well.
- Init
    After checking the `modinfo.json` you will have noticed that the entry at Init looks different to the others. Init executes code at the time when a mod is loaded, which is usually when you start the game. There is very little reason to execute anything at that point, but we need to make sure the module your scripts are in exists. Module in this case is just a fancy word for folder.
    Having said that, any Variable that you set up outside of any function will be initialized at this point.
- Load
    This is the first interesting point to do something at. Any script that is here will be executed directly after you finish loading a savegame but before pressing the Set Sail button. One thing this is useful for is if you have to reset something everytime you load a savegame.
- Tick
    Scripts at this point are executed at every gametick, about 10 times per second. This is only useful when you **really** need to do that. Using Tick can be very dangerous because any code that takes too long to execute will inevitably slow your game down massively. Using Tick can also lead to gigantic logfiles when using print statements to debug. Whenever you can try to use a Trigger instead.
- Unload
    The final option to execute scripts via `modinfo.json` is unload, which executes scripts while unloading the game (untested, butprobably at the end of it like for load). This can be used similarly to how load can be used, to reset certain things. (Unload would be wy more useful if it was possible to save things to the savegame via Lua scripts, but at the time of writing, this is not possible)
- Trigger
    Trigger is the most complex way to execute a Lua script, but also the most versatile one. This executes a script upon a predetermined condition within the game. This condition has to be declare in the XML part of your mod via modops. This tutorial will not go further into how to write triggers, but an example is provided to execute a script with a keyboard shortcut (Shift + F11).

### Changing the Game
Actually figuring out how to influence the game is by far the most complex part of writing Lua scripts. To start you should take a look at the gamefiles with the [RDA Explorer](https://github.com/lysanntranvouez/RDAExplorer). The relevant file is called `script.rda`. In there you will find a lot of things but the best way to start is to take a look at two things. First the file called `data/script/types/generated/globals.lua` which contains the objects that you can easily access from the state of the game at that moment in time (for example the island you're currently over or the thing you have currently selected). Second take a look at everythin in the `data/script/types/generated/rdgs` folder. There you will find everything you could possibly access with your code. Yes, this is a lot of files with a lot of different things in it and it's not very readable, but you will just have to learn to find things in there. The best way to do that is to export the whole folder and then open it with [VSCode](https://code.visualstudio.com/) and either use the search function or maually check files that might relate to what you want to do, but you should probably start with `caeramanagerluabindings.lua` or `cselectionmanagerluabindings.lua`. Both are good jumping-off points to go in deeper.
Once you've done that, the rest is comparably simple: Just write the code that changes what you want to change. If you want to know what that can look like, just check out my other mod: [infinite-resources](https://github.com/03szust/infinite-resources). It's a good example of how to write Lua scripts, especially for the new system. Or you can check mods from other modders that have used Lua scripts as well.

### Debugging your Code / How to use this mod
Now after you have written your first Lua script you will have noticed, that it doesn't work. This is where this mod comes in. this mod provides a framework to test your script. simply copy the code that you want to test into the adequate function and try running it in the game. If it works, you have a problem outside of your Lua script that you need to fix. If it doesn't work and you get an error message in your log files, you can find those in your documents folder under `Documents/Anno 117/log` you can work from there. If it doesn't work and you don't get an error you have a syntax error in your code somewhere.

And now that you know all that: **Happy Modding!** 