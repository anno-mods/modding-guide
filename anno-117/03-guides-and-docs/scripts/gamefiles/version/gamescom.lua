-- this script will configure the game to match the press presentation plot on April 28th 2025
local Version = require "versionhelper"
local SpecialGUIDs = require("specialguids")

system.waitUILoaded()
print("Main menu entered.")

-- Remove unwanted Main Menu buttons
RuntimeSettings:HideTitleButton(datasets.TitleButton.LoadGame)
RuntimeSettings:HideTitleButton(datasets.TitleButton.Options)
RuntimeSettings:HideTitleButton(datasets.TitleButton.Credits)
RuntimeSettings:HideTitleButton(datasets.TitleButton.UbisoftConnect)
RuntimeSettings:HideTitleButton(datasets.TitleButton.QuitGame)
RuntimeSettings:HideTitleButton(datasets.TitleButton.Shop)
RuntimeSettings:HideTitleButton(datasets.TitleButton.Benchmark)
RuntimeSettings:HideTitleButton(datasets.TitleButton.HallOfFame)

-- Remove unwanted Pause Menu buttons
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.Options)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.Save)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.Load)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.GameSetup)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.Store)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.UbisoftConnect)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.PhotoMode)

RuntimeSettings:SetTriggerOutroOnUnload(true)

-- Fixed GameSetup & Difficulties
GameSetup:SetFixedGameSetup(107296)

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

    print("Waiting for session to be entered...")
    await(events.OnSessionEnter)
    print("Game has been entered")

    -- lock world map
    Unlock:RelockNet(SpecialGUIDs.WorldmapSession)

    await(events.OnMetaGameUnloaded);

    print("Returned to main menu.")
end