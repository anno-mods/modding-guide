# An Example

```lua
function AddCoins()
    local oldAmount = ts.Economy.MetaStorage.GetStorageAmount(1010017) -- Get amount of coins
    print(oldAmount)
    ts.Economy.MetaStorage.AddAmount(1010017, 50000)  -- Add 50000 coins
    local newAmount = ts.Economy.MetaStorage.GetStorageAmount(1010017) -- Get amount of coins
    print(newAmount)
end 
```

Now, judging by the codesnipped above. If before running `AddCoins()` snipped you had a total of 10000 coins, you would probably not expect the output to be: 

```
10000
10000
```

But that is exactly what you are gonna get.

### Wait, what the hell? 

Yes, you read correctly, this will be the output, even though we just added 50k coins to our profile BEFORE getting newAmount. Why is this the case?

# Game Ticks and Writeback 

Some (not all) Write Actions are executed on the next game tick. 

|Tick|Actions|
|-|-|
| 0 | Command to Add Money is run |
| 1 | Money was added to metastorage |

## Script Threading

First and foremost: functions are by default executed in a blocking manner on the main thread. That means, The Game tick wants to run a function, the entire function is executed, only then the next game tick happens. (That is also why, when you code an infinite loop in a script, it will just block the entire game forever)

|Tick|Actions|
|-|-|
|1| Running Function: Run Test <br/> Get Amount of Coins <br/> Add 50k Coins <br/> Get Amount of Coins |
|2| Money was added to Metastorage |

> By now, you should spot the problem. 

<details>
    <p>On the same tick, we are getting coins amount, adding 50k coins, then getting coins amount again, BEFORE the Metastorage has updated. That means, because the writeback happens only on the next game tick, we are getting the Storage at still the current tick's state.</p>
</details>

# The Right Way - system.start

So, obviously we need a way to fix this, right? The solution is to let the next game tick happen in between Write and Read. 

That happens through lua coroutines, and luckily, we don't need to set up the coroutines ourselves (for the most part) as Ubisoft has already given us the tool we need. 

You can run a function as a new coroutine using `system.start(func)`, passing in a function. It will then run that function until it returns as a coroutine - and when the coroutine is dead, it gets dropped. 
Most importantly though, upon each yield, the game advances to the next tick and only then resumes the coroutine. 

> You can also use `system.start(func, label)` to name your coroutine. You can see currently active coroutines in `system.internal.coroutines`

> If you want to wait for some time instead of just one tick, you can use `system.waitForGameTimeDelta(ms)`

## Result

So, with everything we know, we adapt our code, add a yield after the write action, and run our function as a managed coroutine.

```lua
function AddCoins()
    system.start(function ()
        -- Get amount of coins
        local oldAmount = ts.Economy.MetaStorage.GetStorageAmount(1010017)
        print(oldAmount)
        -- Add 50000 coins
        ts.Economy.MetaStorage.AddAmount(1010017, 50000)  
        coroutine.yield()
        -- Get amount of coins
        local newAmount = ts.Economy.MetaStorage.GetStorageAmount(1010017)
        print(newAmount)
    end)
end 
```

Which will give us our desired flow of events: 

|Tick|Actions|
|-|-|
|1| Start Coroutine: Run Test <br/> Get Amount of Coins <br/> Add 50k Coins |
|2| Money was added to Metastorage <br/> Get Amount of Coins |

## Parameters

```lua
function AddCoins(amount)
    system.start(function ()
        -- Get amount of coins
        local oldAmount = ts.Economy.MetaStorage.GetStorageAmount(1010017)
        print(oldAmount)
        -- Add 50000 coins
        ts.Economy.MetaStorage.AddAmount(1010017, amount)  
        coroutine.yield()
        -- Get amount of coins
        local newAmount = ts.Economy.MetaStorage.GetStorageAmount(1010017)
        print(newAmount)
    end)
end 
```