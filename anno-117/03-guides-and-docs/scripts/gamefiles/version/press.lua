-- this script will configure the game to match the press presentation plot on April 28th 2025
local Version = require "versionhelper"
local SpecialGUIDs = require("specialguids")

Version.filterAllAchievementsAndAchievementSets()
Version.filterItems()
AssetDataManager:AddToFilter(42343) -- remove albion unlock trigger
AssetDataManager:AddToFilter(4195) -- remove cosmetic tool target mode

-- remove all progression unlocks after theater/aqueduct
AssetDataManager:AddToFilter(3997)
AssetDataManager:AddToFilter(3993)
AssetDataManager:AddToFilter(3974)
AssetDataManager:AddToFilter(43129)
AssetDataManager:AddToFilter(3973)
AssetDataManager:AddToFilter(3972)
AssetDataManager:AddToFilter(43128)
AssetDataManager:AddToFilter(3950)
AssetDataManager:AddToFilter(3948)
AssetDataManager:AddToFilter(3945)
AssetDataManager:AddToFilter(3947)

AssetDataManager:ExecuteFilter()

-- Remove L2 Side Quests
-- Remove unwanted Items

system.waitUILoaded()
print("Main menu entered.")

-- Remove unwanted Main Menu buttons
RuntimeSettings:HideTitleButton(datasets.TitleButton.Credits)
RuntimeSettings:HideTitleButton(datasets.TitleButton.UbisoftConnect)
RuntimeSettings:HideTitleButton(datasets.TitleButton.Shop)
RuntimeSettings:HideTitleButton(datasets.TitleButton.HallOfFame)

-- Remove unwanted Pause Menu buttons
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.GameSetup)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.Store)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.UbisoftConnect)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.PhotoMode)

-- change "Exit Game" button in pause menu to "End Demo" and play video on click
ToolOneDataHelper:AddDynamicTextOveride(rdsdk.TextId("A010 8372 5617 48A2"), rdsdk.TextId("A035 B7E0 DBA3 24F9"))
RuntimeSettings:SetTriggerOutroOnUnload(true)

-- change "Progress in your journey" text to "End Demo"
ToolOneDataHelper:AddDynamicTextOveride(rdsdk.TextId("A010 BF6B 085D 758F"), rdsdk.TextId("A035 B7E0 DBA3 24F9"))

-- Block access to Quest Book
RuntimeSettings:BlockUIState("Questbook")
RuntimeSettings:BlockUIState("PowerStruggle")
RuntimeSettings:BlockUIState("Achievements")

-- Force Language to English
Language:SetFixedLanguage(datasets.Language.English)

-- Fixed GameSetup & Difficulties
GameSetup:SetFixedGameSetup(83111)
GameSetup:SetFixedGameSetupCustomizationAllowed(false);
GameSetup:SetGameSeed(546)

-- Set Fixed UI scaling
AccountSettings:SetFixedUiScaling(datasets.UiScaling.MonitorMedium)

while true do
    
    print("Waiting for game setup to be loaded")
    await(events.OnGameSetupLoaded)

    local isNewGame = not GameSetup.CurrentGameSetup.HostHasSaveGame;
	
if isNewGame then 
    print("Overriding Profile Data")
	GameSetup:SetProfileCreationData("Markus Naukratius", SpecialGUIDs.PARTICIPANT_DEFAULT_COLOR_11, 29557, 77585)
end
	
    -- GameSetup:ScriptOverrideMaps(3729)

	print("Waiting for Session to be loaded....")
    await(events.OnSessionLoaded)
	print("Session Loaded")

    -- start intro sequence
    if isNewGame then 
    Quests:CheatStartStoryLineForCurrentPlayerNet(83248)

    -- register trigger that checks for content end popup
    Conditions:RegisterTriggerForCurrentParticipantNet(87154)
	end

    print("Waiting for session to be entered...")
    await(events.OnSessionEnter)
    print("Game has been entered")

    -- lock world map
    Unlock:RelockNet(SpecialGUIDs.WorldmapSession)

    -- disable major incidents
    DisableAllMajorIncidents()

    -- War Declarations
    print("Disabling War Declarations")
    Diplomacy:SetWarDeclarationAllowed(false);
    -- Rebellion
    print("Disabling Rebellion")
    Participants.ActiveEmperorProperty:SetRebellionDisabledState(true)

    local checkInterval = 1 * 60 * 1000 -- check limits every 1 minute
    local maxDuration = int64(110 * 60 * 1000) -- 2h50 in ms
    -- local maxDuration = int64(2 * 60 * 1000) -- 2mins in ms (for testing)

    while AppLifeCycleFlow.MetaGameStartState ~= rdgs.MetaGameStartState.Invalid do -- as long as metagame is alive
        
        -- check for time limits
        local currentSavegameTime = int64(Game.PlayTime)
        if currentSavegameTime >= maxDuration then
            Scripts:OpenPressDemoOutro()
            maxDuration = maxDuration + int64(10 * 60 * 1000) -- increase by 10 minutes
            -- maxDuration = maxDuration + int64(1 * 60 * 1000) -- increase by 1 minute (for testing)
        end
    
        print("Waiting for 1 minute or progression limit...")
        await_any(system.sleepPP(checkInterval), events.OnMetaGameUnloaded)
    end

    -- end game
    print("Returned to main menu.")
end