-- this script will configure the game to match the press presentation plot on April 28th 2025
local Version = require "versionhelper"
local SpecialGUIDs = require("specialguids")

Version.filterItems()
Version.filterAllAchievementsAndAchievementSets()
AssetDataManager:ExecuteFilter()

system.waitUILoaded()
print("Main menu entered.")

-- Remove unwanted Main Menu buttons
RuntimeSettings:HideTitleButton(datasets.TitleButton.Credits)
RuntimeSettings:HideTitleButton(datasets.TitleButton.Shop)
RuntimeSettings:HideTitleButton(datasets.TitleButton.HallOfFame)

-- Remove unwanted Pause Menu buttons
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.GameSetup)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.Store)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.PhotoMode)

RuntimeSettings:BlockUIState("PowerStruggle")
RuntimeSettings:BlockUIState("Achievements")

-- Force Language to English
Language:SetFixedLanguage(datasets.Language.English)

-- Fixed GameSetup & Difficulties (no campaign)
GameSetup:SetFixedGameSetup(SpecialGUIDs.SinglePlayerSandbox)
GameSetup:SetFixedGameSetupCustomizationAllowed(true);

-- Fixed Difficulties
-- Cosmetic Tool
-- Achievements
-- Items Limitation
-- World Seed
-- Available Regions / Worldmap blocked
-- L2 Side Quests

while true do
    
    print("Waiting for game setup to be loaded")
    await(events.OnGameSetupLoaded)
	
    -- GameSetup:ScriptOverrideMaps(3729)
    
    print("Waiting for session to be entered...")
    await(events.OnSessionEnter)
    print("Game has been entered")

    local checkInterval = 60 * 1000 -- check limits every minute 

    while AppLifeCycleFlow.MetaGameStartState ~= rdgs.MetaGameStartState.Invalid do -- as long as metagame is alive

        print("Waiting for 1 minute or progression limit...")
        await_any(system.sleepPP(checkInterval), events.OnMetaGameUnloaded)
    end

    -- end game
    print("Returned to main menu.")
end